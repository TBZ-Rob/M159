<div align="center">

# 🗂️ M159: Directoryservices | Projekt Contoso

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-27%25-orange?style=flat)
![Domain](https://img.shields.io/badge/Domain-contoso.com-1f6feb?style=flat)
![Cloud](https://img.shields.io/badge/Cloud-AWS%20%2B%20Azure-8957e5?style=flat)

**[Zeitplan](#️-zeitplan) · [Aufträge](#-aufträge-übersicht) · [Architektur](./01-planung/README.md#️-architektur) · [Setup-Sheet](./01-planung/setup-sheet.md) · [KI-Nutzung](https://ch-tbz-it.gitlab.io/Stud/m159/ki-nutzung.html)**

</div>

---

## 📌 Kurzüberblick

Aufbau einer Active-Directory-Umgebung (Contoso) auf AWS EC2, Integration mit AWS Managed Microsoft AD und Anbindung an Microsoft Entra ID.

| | |
|---|---|
| 🌐 Second-Level-Domäne | [`contoso.com`](./01-planung/README.md) |
| 🏢 On-Prem AD | [`ad.contoso.com`](./03-gesamtstruktur-dc-client/README.md) |
| ☁️ AWS Managed AD | [`aws.contoso.com`](./05-aws-managed-ad/README.md) |
| 🔑 Öffentlicher UPN | `contoso-robin.dynv6.net` |
| 📋 Details | [Setup-Sheet](./01-planung/setup-sheet.md) |

<br>

## 🗓️ Zeitplan

> ⚠️ AWS Managed AD (Auftrag 05) kostet ca. 18 Dollar pro Woche. Deshalb liegen 05 und 06 bewusst nicht in der Mitte, sondern kompakt am Ende, direkt hintereinander, Managed AD wird erst kurz davor erstellt und sofort danach wieder gelöscht. 05/06 sind laut Modul die einzigen Aufträge, die verschoben werden dürfen.

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       M159 Zeitplan (dienstags, 3 Netto-Lektionen)

    section Block 1
    01 Planung                         :done, t1, 2026-08-18, 1d
    02 Initial Setup                   :done, t2, 2026-08-25, 1d
    03 Gesamtstruktur und Client       :done, t3, 2026-09-01, 1d
    04 Freigaben und Berechtigungen    :active, t4, 2026-09-08, 1d
    Checkpoint Zeitstand pruefen       :milestone, cp, 2026-09-08, 0d

    section Block 2
    07 DIT und GPOs                    :t5, 2026-09-15, 1d
    08 Suche im Directory              :t6, 2026-09-22, 1d
    09 PowerShell und 10 Entra Connect :t7, 2026-09-29, 1d
    10 fertig und 11 und 12 und 13     :t8, 2026-10-20, 1d

    section Zum Schluss kurz vor Abgabe
    05 AWS Managed AD und 06 RSAT      :crit, t9, 2026-10-21, 3d
```

<details>
<summary>Als Tabelle anzeigen</summary>

<br>

| # | Datum | Auftrag | Status |
|---|---|---|---|
| 1 | Di, 18.08.2026 | [01: Planung](./01-planung/README.md) | ✅ erledigt |
| 2 | Di, 25.08.2026 | [02: Initial Setup](./02-initial-setup/README.md) | ✅ erledigt |
| 3 | Di, 01.09.2026 | [03: Gesamtstruktur (1. DC) & Client](./03-gesamtstruktur-dc-client/README.md) | ✅ erledigt |
| 4 | Di, 08.09.2026 | [04: Freigaben/Berechtigungen](./04-freigaben-berechtigungen/README.md) | 🟡 in Arbeit |
| n/a | n/a | **Checkpoint: Zeitstand prüfen** | n/a |
| 5 | Di, 15.09.2026 | [07: DIT & GPOs](./07-dit-gpos/README.md) | ⬜ offen |
| 6 | Di, 22.09.2026 | [08: Suche im Directory](./08-suche-im-directory/README.md) | ⬜ offen |
| 7 | Di, 29.09.2026 | [09: PowerShell-Debugging](./09-identity-mgmt-powershell/README.md) + [10: Entra Connect (Start)](./10-entra-connect/README.md) | ⬜ offen |
| 8 | Di, 20.10.2026 | 10 fertig + [11](./11-benutzerprofil/README.md)/[12](./12-netzlaufwerk-azure/README.md)/[13](./13-sso-python-app/README.md) (Rest ggf. Selbstarbeit) | ⬜ offen |
| n/a | kurz vor Schlussbesprechung | [05: AWS Managed AD](./05-aws-managed-ad/README.md) + [06: RSAT & Admin Center](./06-rsat-admin-center/README.md), kompakt an 1 bis 2 Tagen, danach Managed AD sofort löschen | ⬜ offen |

</details>

<br>

## 📋 Aufträge: Übersicht

### Block 1: Lokale Umgebung

| # | Auftrag | Status | Modul-Auftrag |
|---|---|---|---|
| [01](./01-planung/README.md) | Planung | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/01-planung/) |
| [02](./02-initial-setup/README.md) | Initial Setup | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/02-initial-setup/) |
| [03](./03-gesamtstruktur-dc-client/README.md) | Gesamtstruktur (1. DC) & Client | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/03-neue-gesamtstruktur-und-client/) |
| [04](./04-freigaben-berechtigungen/README.md) | Freigaben, Laufwerke, Berechtigungen | 🟡 in Arbeit | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/04-freigaben-laufwerke-berechtigungen/) |
| [05](./05-aws-managed-ad/README.md) | AWS Managed Microsoft AD | ⬜ ans Ende verschoben (Kosten) | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/05-aws-managed-microsoft-ad/) |
| [06](./06-rsat-admin-center/README.md) | RSAT & Admin Center V2 | ⬜ ans Ende verschoben (Kosten) | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/06-rsat-admin-center-v2/) |
| [07](./07-dit-gpos/README.md) | DIT & GPOs | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/07-dit-gpos/) |
| [08](./08-suche-im-directory/README.md) | Suche im Directory (LDAP) | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/08-suche-im-directory/) |
| [09](./09-identity-mgmt-powershell/README.md) | Identity Management & PowerShell Debugging | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/09-automation-und-debugging/) |

### Block 2: Cloud-Integration

| # | Auftrag | Status | Modul-Auftrag |
|---|---|---|---|
| [10](./10-entra-connect/README.md) | MS Entra ID & MS Entra Connect | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/10-ms-entra-id-ms-entra-connect/) |
| [11](./11-benutzerprofil/README.md) | Servergespeicherte Benutzerprofile | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/11-servergespeicherte-benutzerprofile/) |
| [12](./12-netzlaufwerk-azure/README.md) | Netzlaufwerk to Azure Migration | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/12-netzlaufwerk-to-azure-migration/) |
| [13](./13-sso-python-app/README.md) | SSO Python App | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/13-sso-python-app/) |

<br>

## 📁 Weitere Ordner

| Ordner | Inhalt |
|---|---|
| [`00-files/`](./00-files/) | Allgemeine Unterlagen (Modul-PDFs, Notizen, Sonstiges) |
| [`kompetenznachweis/`](./kompetenznachweis/) | Vorbereitung mündlicher Nachweis, Gesamt-Reflexion |

<br>

## 🤖 KI-Nutzung

Der KI-Einsatz in diesem Projekt folgt dem verbindlichen Rahmen aus [`ki-nutzung.md`](https://ch-tbz-it.gitlab.io/Stud/m159/ki-nutzung.html) des Modul-Repositories. Pro Auftrag mit KI-Anteil liegt ein `ki-log.md` mit Prompt, Verifikation und Reflexion vor, siehe zum Beispiel [01-planung/ki-log.md](./01-planung/ki-log.md).

<br>

<div align="center">

⬆️ [Nach oben](#️-m159-directoryservices--projekt-contoso) · ➡️ [Weiter zu Auftrag 01](./01-planung/README.md)

</div>
