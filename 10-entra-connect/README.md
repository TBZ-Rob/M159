<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 10: MS Entra ID & MS Entra Connect

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal) · Kompetenzfelder=58a6ff (blau, neutral)
-->

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-100%25-1b7f79?style=flat)
![Block](https://img.shields.io/badge/Block-2%20Cloud%20Integration-lightgrey?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8250df?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-G%2C%20B-58a6ff?style=flat)

**[Ziel](#ziel) · [Blocker geloest](#blocker-geloest-eigener-azure-tenant) · [Entra Connect Installation](#entra-connect-installation) · [Nachweise](#nachweise) · [Checkliste](#checkliste)**

</div>

---

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> Einen eigenen Microsoft-Entra-Tenant mit MS Entra Connect an das lokale Active Directory (`ad.contoso.com`) anbinden: Installation von Entra Connect, Konfiguration der Synchronisation, Password Hash Synchronization (gemaess Vorgabe: YES), und eine eigene UPN-Domain fuer die synchronisierten Benutzer.

<br>

<h2 id="blocker-geloest-eigener-azure-tenant"><font color="#8250df">Blocker geloest: eigener Azure-Tenant</font></h2>

> Auftrag 10 war blockiert, weil fuer Entra Connect Global-Admin-Zugriff auf einen eigenen, nicht TBZ-verwalteten Tenant benoetigt wird. Der TBZ-Schul-Account (`robin.nydegger@edu.tbz.ch`, aktiviert in Auftrag 01) hat zwar aktives Azure-for-Students-Guthaben, laeuft aber im organisationsverwalteten Tenant `TBZ.CH` ohne Admin-Rechte (Fehler 401 "Insufficient privileges").

**Bisherige Fehlschlaege (Stand 14.09.2026), zur Nachvollziehbarkeit:**

1. Neues Konto mit TBZ-Mail fuer Azure for Students verifiziert: Fehler "no active sponsorship" auf der separaten Balance-Seite, vermutlich ein reiner Anzeige-Bug, aber dadurch faelschlich als Fehlschlag interpretiert.
2. Erneuter Verifizierungsversuch: Fehler "This email account has already been used for verification this year." SheerID (Microsofts Verifizierungs-Backend) sperrt eine Mail-Adresse 12 Monate lang nach dem ersten Versuch, auch wenn dieser fehlgeschlagen wirkte, kein Self-Service-Reset moeglich.
3. GitHub Student Developer Pack als Alternativweg probiert: GitHub verlangte fuer TBZ eine `@giacal.ch`-Mailadresse (vermutlich fehlerhafte Eintragung in GitHubs Schul-Datenbank), keine Bestaetigungsmail erhalten.
4. Erster neu erstellter Account fuer diesen Auftrag: kein eigenes Entra-ID-Verzeichnis vorhanden, Azure-for-Students-Aktivierung nie durchgelaufen.

**Loesung:** Es stellte sich heraus, dass bereits vorher ein separates Konto mit privater Mail-Adresse (`robin.nydegger.tbz@outlook.com`) erfolgreich fuer Azure for Students erstellt und verifiziert worden war, dessen Zugangsdaten aber zwischenzeitlich in Vergessenheit gerieten. Gefunden ueber die Bestaetigungsmails von Microsoft im eigenen Gmail-Postfach ("Your account is set to close on..." bzw. "Your account was reopened"). Nach Reaktivierung des Kontos ist ein voll funktionsfaehiger, eigener Tenant mit aktivem Azure-for-Students-Guthaben und Global-Admin-Rechten bestaetigt (siehe [Nachweise](#nachweise)).

<br>

<h2 id="entra-connect-installation"><font color="#8250df">Entra Connect Installation</font></h2>

> Installiert auf **AdminCenter01** (bereits vorhandener, domain-joined Server, statt neuer EC2-Instanz, aus Kostengruenden).

**Stolperstein 1: veraltete Installer-URL.** Ein zuerst per direkter `download.microsoft.com`-URL heruntergeladener Installer schlug mit "incorrect version" fehl. Microsoft hat den oeffentlichen Download-Center-Vertrieb fuer Entra Connect eingestellt, aktuelle Builds gibt es nur noch ueber das Entra Admin Center (`entra.microsoft.com` -> Microsoft Entra Connect -> "Get started" -> Kachel "Connect Sync" -> "download connect sync agent", nicht die Cloud-Sync-Kachel).

**Stolperstein 2: Microsoft-Konto (MSA) als Global Admin nicht installationsfaehig.** Sign-in im Installer mit `robin.nydegger.tbz@outlook.com` schlug fehl: `AADSTS50020: User account ... from identity provider 'live.com' does not exist in tenant 'Microsoft Services'`. Ursache laut offizieller Microsoft-Doku: der Global-Admin-Account fuer die Entra-Connect-Installation muss ein "school or organization account" sein, kein Microsoft-Konto (MSA), selbst wenn die MSA im Portal problemlos als Tenant-Owner/Global-Admin funktioniert. Fix: neuen Cloud-Benutzer direkt im eigenen Tenant angelegt (`admin@robinnydeggertbzoutlook.onmicrosoft.com`), Rolle Global Administrator zugewiesen, diesen fuer den Installer-Login verwendet.

**Stolperstein 3: Security Defaults blockieren MFA-Setup im Installer.** Der neue Tenant hat automatisch Security Defaults aktiviert, das erzwingt beim ersten Login des neuen Admin-Kontos eine MFA-Einrichtung. Der im Installer eingebettete Browser (veraltete Rendering-Engine) kann den MFA-Setup-Flow nicht darstellen ("Your browser is not supported"). Fix: Security Defaults in Microsoft Entra ID -> Properties -> "Manage security defaults" auf Disabled gesetzt (vertretbar, reiner Test-/Schul-Tenant).

**Durchgefuehrte Installation (Custom Settings):**

- User sign-in: **Password Hash Synchronization** (gemaess Vorgabe: YES)
- Connect to Azure AD: `admin@robinnydeggertbzoutlook.onmicrosoft.com` (Global Admin im eigenen Tenant)
- Connect to AD DS: `AD\Administrator` (Enterprise Admin, lokales AD)
- Azure AD sign-in configuration: `ad.contoso.com` als UPN-Suffix nicht verifizierbar (echte, fremde oeffentliche Domain, siehe unten), Option "Continue without matching all UPN suffixes to verified domains" gewaehlt
- Domain/OU-Filterung: alle Domains und OUs synchronisiert
- Sync beim Abschluss automatisch gestartet

**Ergebnis:** Initialer Sync erfolgreich, 17 Benutzer aus dem lokalen AD in Microsoft Entra ID sichtbar (Spalte "On-premises sync" = Yes), `Get-ADSyncScheduler` zeigt aktiven Zeitplan (`SyncCycleEnabled: True`, Delta-Sync alle 30 Minuten). Siehe [Nachweise](#nachweise), Screenshots 05 und 06.

**Entscheid eigene UPN-Domain:** bewusst keine eigene, oeffentliche Domain gekauft/verifiziert (Robin besitzt keine). `ad.contoso.com` scheidet aus, da echte, fremde oeffentliche Domain (Azure DNS), nicht verifizierbar. Synchronisierte Benutzer bleiben deshalb unter der Standard-Domain `robinnydeggertbzoutlook.onmicrosoft.com`, funktional identisch (Sign-in, Password Hash Sync funktionieren unabhaengig vom UPN-Domain-Namen), nur kosmetisch anders als ein Produktivsetup mit eigener Domain. Fuer den muendlichen Nachweis als bewusste, kostenbedingte Design-Entscheidung zu begruenden.

**Hybrid Join (Client01):** Ueber "Additional tasks" -> "Configure device options" -> "Configure Hybrid Azure AD join" konfiguriert (Forest `ad.contoso.com`, SCP automatisch erstellt, Windows 10+ domain-joined devices aktiviert). Erster Registrierungsversuch auf Client01 (`schtasks /Run /TN "\Microsoft\Windows\Workplace Join\Automatic-Device-Join"`) schlug fehl: `Server error: The device object by the given id (...) is not found` (Event-ID 304, `registrationType: sync`). Ursache: das Konfigurieren von Hybrid Join fuegt eine neue Sync-Regel hinzu, die per Delta-Sync nicht rueckwirkend auf bestehende Objekte angewendet wird, dafuer ist ein **Initial-Sync** noetig (`Start-ADSyncSyncCycle -PolicyType Initial`). Nach Initial-Sync und erneutem Task-Lauf erfolgreich:

```
dsregcmd /status
             AzureAdJoined : YES
              DomainJoined : YES
                  DeviceId : b4cbb0ef-dcc0-465a-a129-7d236d23a8a7
```

<br>

<h2 id="nachweise"><font color="#8250df">Nachweise</font></h2>

<details open>
<summary><strong>Screenshots anzeigen</strong></summary>

<br>

| Screenshot | Beschreibung |
|---|---|
| [01-entra-id-tenant-overview.png](./00-screenshots/01-entra-id-tenant-overview.png) | Microsoft Entra ID Uebersicht: eigener Tenant "Default Directory", Primary Domain `robinnydeggertbzoutlook.onmicrosoft.com`, Tenant-ID `ef4925a6-ccf7-4f72-932f-0bbd2fc319c7`, Lizenz "Microsoft Entra ID Free" |
| [02-subscription-azure-for-students.png](./00-screenshots/02-subscription-azure-for-students.png) | Abonnement-Liste: Eintrag "Azure for Students", Status Active, eigene Rolle "Owner" |
| [03-guthaben-details.png](./00-screenshots/03-guthaben-details.png) | Education-Uebersicht: Guthaben 100 von 100 Dollar, gueltig bis 15.09.2027 (365 Tage) |
| [04-tenant-users-liste.png](./00-screenshots/04-tenant-users-liste.png) | Benutzerliste des Tenants: einziger Benutzer "Robin Nydegger", kein On-Premises-Sync (noch vor Entra Connect) |
| [05-entra-id-users-synced.png](./00-screenshots/05-entra-id-users-synced.png) | Benutzerliste nach Entra Connect Sync: 17 Benutzer aus dem lokalen AD, Spalte "On-premises sync" = Yes |
| [06-adsyncscheduler.png](./00-screenshots/06-adsyncscheduler.png) | PowerShell `Get-ADSyncScheduler` auf AdminCenter01: aktiver Sync-Zeitplan, Delta-Sync alle 30 Minuten |

</details>

> Hinweis: Screenshot 4 zeigt die Benutzerliste, nicht direkt die Rollenzuweisung ("Assigned roles" liess sich im Portal nicht auf Anhieb finden). Die Global-Admin-Rolle ergibt sich aber zweifelsfrei daraus, dass der Account als einziger Benutzer den Tenant selbst erstellt hat und als "Owner" auf dem Abonnement eingetragen ist (Screenshot 2), das ist Microsoft-Standardverhalten fuer den Tenant-Ersteller. Bei Bedarf spaeter zusaetzlich ueber "Roles and administrators" -> "Global Administrator" -> "Assignments" verifizierbar.

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [x] Auftrag gestartet
- [x] Eigener Azure-Tenant mit Admin-Rechten steht
- [x] MS Entra Connect installiert
- [x] Password Hash Synchronization aktiv, initialer Sync erfolgreich (17 Benutzer)
- [x] Eigene UPN-Domain geprueft, bewusst nicht umgesetzt (keine eigene Domain vorhanden, begruendet)
- [x] Hybrid Join (Client01) getestet, `AzureAdJoined: YES`
- [x] Umsetzung abgeschlossen
- [x] Screenshots/Nachweise abgelegt
- [x] `ki-log.md` ausgefüllt
- [x] `entscheidungsprotokoll.md` ausgefüllt (eigene UPN-Domain vs. Standard-Tenant-Domain)

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [entscheidungsprotokoll.md](./entscheidungsprotokoll.md) | Begründung des Entscheids in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/10-ms-entra-id-ms-entra-connect/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/10-ms-entra-id-ms-entra-connect/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 09: Identity Management & PowerShell Debugging](../09-identity-mgmt-powershell/README.md) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 11: Servergespeicherte Benutzerprofile](../11-benutzerprofil/README.md)

</div>
