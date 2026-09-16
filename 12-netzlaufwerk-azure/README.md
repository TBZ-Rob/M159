<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 12: Netzlaufwerk to Azure Migration

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal) · Kompetenzfelder=58a6ff (blau, neutral)
-->

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-100%25-1b7f79?style=flat)
![Block](https://img.shields.io/badge/Block-2%20Cloud%20Integration-lightgrey?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8250df?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-G%2C%20H-58a6ff?style=flat)

**[Ziel](#ziel) · [Umsetzung](#umsetzung) · [Nachweise](#nachweise) · [Checkliste](#checkliste)**

</div>

---

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> Ein Azure-Netzlaufwerk (Azure Files Share) einrichten und per Active Directory Domain Services (AD DS) authentifizieren, sodass lokale AD-Benutzer sich transparent per Kerberos anmelden koennen, genau wie bei einem klassischen On-Premises-Netzlaufwerk. Zwei Abteilungen (Sekretariat, Buchhaltung) erhalten unterschiedliche Berechtigungsstufen.

<br>

<h2 id="umsetzung"><font color="#8250df">Umsetzung</font></h2>

**Warum AD DS statt Microsoft Entra Domain Services oder Microsoft Entra Kerberos:** Microsoft Entra Domain Services verursacht zusaetzliche laufende Kosten ohne Mehrwert in diesem Szenario. Microsoft Entra Kerberos wird aktuell nur von Windows-Clients unterstuetzt und ist die eleganteste, aber noch nicht ueberall einsetzbare Loesung. AD DS ist die von der Aufgabenstellung empfohlene Variante fuer dieses Setup (bestehendes lokales AD bereits vorhanden) und wurde deshalb gewaehlt.

**Storage Account und Share** (Azure CLI auf AdminCenter01):

```powershell
az group create --name rg-m159-files --location eastus
az storage account create --name stm159netzlaufwerk --resource-group rg-m159-files --sku Standard_LRS --kind StorageV2
az storage share-rm create --storage-account stm159netzlaufwerk --resource-group rg-m159-files --name netzlaufwerk --quota 10
```

**Stolperstein 1: Region-Einschraenkung von Azure for Students.** Storage-Account-Erstellung in `eastus`, `westeurope`, `eastus2`, `centralus`, `southcentralus`, `westus2` und `northeurope` schlug jeweils mit `RequestDisallowedByAzure` fehl ("This policy maintains a set of best available regions..."). Azure-for-Students-Subscriptions haben eine feste, kontoindividuelle Whitelist von ca. 5 erlaubten Regionen (Azure Policy "Allowed resource deployment regions"), nicht aenderbar. Erlaubte Regionen fuer dieses Konto per `az policy assignment list` ermittelt: `germanywestcentral`, `italynorth`, `denmarkeast`, `spaincentral`, `belgiumcentral`. Storage Account letztlich in `germanywestcentral` erstellt.

**Stolperstein 2: Microsoft.Storage-Resource-Provider nicht registriert.** Fehler `SubscriptionNotFound` bei der ersten Storage-Account-Erstellung, obwohl die Subscription eindeutig existierte. Ursache: `Microsoft.Storage`-Provider war fuer diese frische Subscription noch nicht registriert (`az provider register --namespace Microsoft.Storage`), Registrierung dauert ca. 1 Minute.

**AzFilesHybrid und Domain Join** (musste in der interaktiven RDP-Session als `AD\Administrator` laufen, nicht per SSH, da die SSH-Session als lokaler `admincenter01\administrator` ohne AD-Schreibrechte laeuft):

```powershell
Connect-AzAccount -UseDeviceAuthentication
Import-Module C:\AzFilesHybrid\AzFilesHybrid.psd1
Join-AzStorageAccount -ResourceGroupName rg-m159-files -StorageAccountName stm159netzlaufwerk -SamAccountName stm159nlw -DomainAccountType ComputerAccount
```

**Stolperstein 3: Az PowerShell + AWSPowerShell-Modulkonflikt.** `Connect-AzAccount` schlug fehl mit `Method not found: Void Microsoft.Identity.Client.Extensions.Msal.MsalCacheHelper.RegisterCache`. Ursache: das auf der AWS-AMI vorinstallierte `AWSPowerShell`-Modul bringt eine aeltere, kollidierende Version der MSAL-Extensions-DLL mit, die durch .NET-Framework-Assembly-Bindung vor der von Az.Accounts mitgelieferten Version geladen wird. Fix: PowerShell mit `powershell -NoProfile` neu starten (verhindert das AWS-Modul am automatischen Laden).

**Stolperstein 4: veraltete PowerShellGet-Version.** `Import-Module AzFilesHybrid.psd1` verlangte PowerShellGet 1.6.0+, Update schlug beim ersten Versuch fehl (Session nicht elevated). Fix: PowerShell **als Administrator** neu starten, `Install-Module PowerShellGet -Force -AllowClobber -Scope AllUsers`, danach Session nochmal komplett neu starten.

**Stolperstein 5: ADWS-Port blockiert.** `Join-AzStorageAccount` (intern `Get-ADDomain`) schlug fehl mit `Unable to contact the server ... Active Directory Web Services running`, obwohl der ADWS-Dienst auf DC01 lief. Ursache: Security Group von DC01 hatte Port 9389 (ADWS) nie geoeffnet, nur die urspruenglich fuer Auftrag 02/03 benoetigten Ports. Fix: Inbound-Regel TCP 9389 von `10.0.0.0/16` in der AWS-Konsole ergaenzt.

**Ergebnis Domain Join:** Storage Account erfolgreich als Computerobjekt (`stm159nlw`) im AD registriert, AD-DS-Authentifizierung automatisch aktiviert:

```json
"activeDirectoryProperties": {
  "accountType": "Computer",
  "domainName": "ad.contoso.com",
  "forestName": "ad.contoso.com",
  "samAccountName": "stm159nlw"
},
"directoryServiceOptions": "AD"
```

**Kerberos-Realm-Mapping (GPO):** Neue GPO `Kerberos-Realm-Mapping-AzureFiles`, an Domain-Root verlinkt, setzt Registry-Wert `HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Domain_Realm\.file.core.windows.net = AD.CONTOSO.COM`, damit Clients wissen, dass `*.file.core.windows.net`-Hosts ueber den lokalen AD-Realm per Kerberos authentifiziert werden. Nach `gpupdate /force` auf Client01 im Registry verifiziert.

**Berechtigungen (Azure RBAC, gescoped auf den File Share):**

| Gruppe | Rolle | Zweck |
|---|---|---|
| `Sekretariat` | Storage File Data SMB Share **Reader** | Nur Lesezugriff |
| `Buchhaltung` | Storage File Data SMB Share **Contributor** | Lese- und Schreibzugriff |

```bash
az role assignment create --assignee <ObjectId Sekretariat> --role "Storage File Data SMB Share Reader" --scope <Share-Resource-ID>
az role assignment create --assignee <ObjectId Buchhaltung> --role "Storage File Data SMB Share Contributor" --scope <Share-Resource-ID>
```

**Verbindungstest auf Client01:** Netzlaufwerk `\\stm159netzlaufwerk.file.core.windows.net\netzlaufwerk` verbunden.

- `anna.muster` (Sekretariat, Reader): kann Inhalt sehen, Schreibversuch (Datei umbenennen) ergibt **"File Access Denied"**, korrekt.
- `peter.keller` (Buchhaltung, Contributor): kann Dateien erstellen/schreiben, kein Fehler, korrekt.

<br>

<h2 id="nachweise"><font color="#8250df">Nachweise</font></h2>

<details open>
<summary><strong>Screenshots anzeigen</strong></summary>

<br>

| Screenshot | Beschreibung |
|---|---|
| [01-anna-sekretariat-reader-denied.png](./00-screenshots/01-anna-sekretariat-reader-denied.png) | `anna.muster` (Sekretariat, Reader-Rolle): Zugriff auf Netzlaufwerk moeglich, Schreibversuch korrekt mit "File Access Denied" verweigert |
| [02-peter-buchhaltung-contributor-ok.png](./00-screenshots/02-peter-buchhaltung-contributor-ok.png) | `peter.keller` (Buchhaltung, Contributor-Rolle): Datei erfolgreich erstellt, kein Zugriffsfehler |

</details>

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [x] Auftrag gestartet
- [x] Storage Account und File Share erstellt
- [x] AD DS-Authentifizierung konfiguriert (Domain Join per AzFilesHybrid)
- [x] Kerberos-Realm-Mapping per GPO gesetzt
- [x] RBAC-Rollen fuer Sekretariat (Reader) und Buchhaltung (Contributor) zugewiesen
- [x] Verbindungstest mit beiden Abteilungen erfolgreich verifiziert
- [x] Umsetzung abgeschlossen
- [x] Screenshots/Nachweise abgelegt
- [x] `ki-log.md` ausgefüllt

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/12-netzlaufwerk-to-azure-migration/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/12-netzlaufwerk-to-azure-migration/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 11: Servergespeicherte Benutzerprofile](../11-benutzerprofil/README.md) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 13: SSO Python App](../13-sso-python-app/README.md)

</div>
