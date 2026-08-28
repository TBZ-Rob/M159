<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://tbz.ch/wp-content/uploads/2026/04/TBZ-Logo-invertiert.svg">
  <img src="https://tbz.ch/wp-content/uploads/2026/04/TBZ-Logo.svg" alt="TBZ Technische Berufsschule Zürich" width="180">
</picture>

# 🗂️ M159: Directoryservices | Projekt Contoso

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-31%25-orange?style=flat)
![Domain](https://img.shields.io/badge/Domain-contoso.com-1f6feb?style=flat)
![Cloud](https://img.shields.io/badge/Cloud-AWS%20%2B%20Azure-8957e5?style=flat)

**[Zeitplan](#zeitplan) · [Aufträge](#aufträge-übersicht) · [Architektur](./01-planung/README.md#architektur) · [Setup-Sheet](./01-planung/setup-sheet.md) · [KI-Nutzung](https://ch-tbz-it.gitlab.io/Stud/m159/ki-nutzung.html)**

</div>

---

```mermaid
flowchart LR
    C["💻 Client"] --> DC["🖥️ DC ad.contoso.com"]
    DC --> MAD["☁️ AWS Managed AD"]
    DC --> ENTRA["🔷 Entra ID"]
```

<br>

## Kurzüberblick

Aufbau einer Active-Directory-Umgebung (Contoso) auf AWS EC2, Integration mit AWS Managed Microsoft AD und Anbindung an Microsoft Entra ID.

| Technologie | Einsatz |
|---|---|
| ![AWS](https://img.shields.io/badge/-AWS%20EC2-FF9900?style=flat-square&logo=amazonaws&logoColor=white) | Cloud-Hosting der gesamten AD-Umgebung |
| ![PowerShell](https://img.shields.io/badge/-PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white) | Automatisierung, AD-/DNS-/NTFS-Verwaltung |
| ![Active Directory](https://img.shields.io/badge/-Active%20Directory-0078D4?style=flat-square&logo=windows&logoColor=white) | Domain Services, Gruppen, Berechtigungen, GPOs |
| ![Entra ID](https://img.shields.io/badge/-Microsoft%20Entra%20ID-0078D4?style=flat-square&logo=microsoftazure&logoColor=white) | Cloud-Identity, Sync via Entra Connect |
| ![GitHub](https://img.shields.io/badge/-GitHub-181717?style=flat-square&logo=github&logoColor=white) | Versionierung, Dokumentation |

| | |
|---|---|
| 🌐 Second-Level-Domäne | [`contoso.com`](./01-planung/README.md) |
| 🏢 On-Prem AD | [`ad.contoso.com`](./03-gesamtstruktur-dc-client/README.md) |
| ☁️ AWS Managed AD | [`aws.contoso.com`](./05-aws-managed-ad/README.md) |
| 🔑 Öffentlicher UPN | `contoso-robin.dynv6.net` |
| 📋 Details | [Setup-Sheet](./01-planung/setup-sheet.md) |

<div align="center">

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://quickchart.io/chart?c=%7B%22type%22%3A%22pie%22%2C%22data%22%3A%7B%22labels%22%3A%5B%22Erledigt%20%284%29%22%2C%22Offen%20%289%29%22%5D%2C%22datasets%22%3A%5B%7B%22data%22%3A%5B4%2C9%5D%2C%22backgroundColor%22%3A%5B%22%232ea44f%22%2C%22%238b949e%22%5D%7D%5D%7D%2C%22options%22%3A%7B%22plugins%22%3A%7B%22title%22%3A%7B%22display%22%3Atrue%2C%22text%22%3A%22Auftr%C3%A4ge-Status%20%2813%20total%29%22%2C%22color%22%3A%22%23c9d1d9%22%2C%22font%22%3A%7B%22size%22%3A18%7D%7D%2C%22legend%22%3A%7B%22display%22%3Atrue%2C%22position%22%3A%22right%22%2C%22labels%22%3A%7B%22color%22%3A%22%23c9d1d9%22%2C%22font%22%3A%7B%22size%22%3A14%7D%7D%7D%7D%7D%7D&width=480&height=280&backgroundColor=transparent&format=png&version=4">
  <img src="https://quickchart.io/chart?c=%7B%22type%22%3A%22pie%22%2C%22data%22%3A%7B%22labels%22%3A%5B%22Erledigt%20%284%29%22%2C%22Offen%20%289%29%22%5D%2C%22datasets%22%3A%5B%7B%22data%22%3A%5B4%2C9%5D%2C%22backgroundColor%22%3A%5B%22%232ea44f%22%2C%22%238b949e%22%5D%7D%5D%7D%2C%22options%22%3A%7B%22plugins%22%3A%7B%22title%22%3A%7B%22display%22%3Atrue%2C%22text%22%3A%22Auftr%C3%A4ge-Status%20%2813%20total%29%22%2C%22color%22%3A%22%231f2328%22%2C%22font%22%3A%7B%22size%22%3A18%7D%7D%2C%22legend%22%3A%7B%22display%22%3Atrue%2C%22position%22%3A%22right%22%2C%22labels%22%3A%7B%22color%22%3A%22%231f2328%22%2C%22font%22%3A%7B%22size%22%3A14%7D%7D%7D%7D%7D%7D&width=480&height=280&backgroundColor=transparent&format=png&version=4" alt="Aufträge-Status: 4 von 13 erledigt" width="480">
</picture>

</div>

<br>

## Zeitplan

> ⚠️ AWS Managed AD (Auftrag 05) kostet ca. 18 Dollar pro Woche. Deshalb liegen 05 und 06 bewusst nicht in der Mitte, sondern kompakt am Ende, direkt hintereinander, Managed AD wird erst kurz davor erstellt und sofort danach wieder gelöscht. 05/06 sind laut Modul die einzigen Aufträge, die verschoben werden dürfen.

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       M159 Zeitplan (dienstags, 3 Netto-Lektionen)

    section Block 1
    01 Planung                         :done, t1, 2026-08-18, 1d
    02 Initial Setup                   :done, t2, 2026-08-25, 1d
    03 Gesamtstruktur und Client       :done, t3, 2026-09-01, 1d
    04 Freigaben und Berechtigungen    :done, t4, 2026-09-08, 1d
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
| 4 | Di, 08.09.2026 | [04: Freigaben/Berechtigungen](./04-freigaben-berechtigungen/README.md) | ✅ erledigt |
| n/a | n/a | **Checkpoint: Zeitstand prüfen** | n/a |
| 5 | Di, 15.09.2026 | [07: DIT & GPOs](./07-dit-gpos/README.md) | ⬜ offen |
| 6 | Di, 22.09.2026 | [08: Suche im Directory](./08-suche-im-directory/README.md) | ⬜ offen |
| 7 | Di, 29.09.2026 | [09: PowerShell-Debugging](./09-identity-mgmt-powershell/README.md) + [10: Entra Connect (Start)](./10-entra-connect/README.md) | ⬜ offen |
| 8 | Di, 20.10.2026 | 10 fertig + [11](./11-benutzerprofil/README.md)/[12](./12-netzlaufwerk-azure/README.md)/[13](./13-sso-python-app/README.md) (Rest ggf. Selbstarbeit) | ⬜ offen |
| n/a | kurz vor Schlussbesprechung | [05: AWS Managed AD](./05-aws-managed-ad/README.md) + [06: RSAT & Admin Center](./06-rsat-admin-center/README.md), kompakt an 1 bis 2 Tagen, danach Managed AD sofort löschen | ⬜ offen |

</details>

<br>

## Aufträge: Übersicht

### Block 1: Lokale Umgebung

| # | Auftrag | Status | Modul-Auftrag |
|---|---|---|---|
| [01](./01-planung/README.md) | Planung | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/01-planung/) |
| [02](./02-initial-setup/README.md) | Initial Setup | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/02-initial-setup/) |
| [03](./03-gesamtstruktur-dc-client/README.md) | Gesamtstruktur (1. DC) & Client | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/03-neue-gesamtstruktur-und-client/) |
| [04](./04-freigaben-berechtigungen/README.md) | Freigaben, Laufwerke, Berechtigungen | ✅ erledigt | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/04-freigaben-laufwerke-berechtigungen/) |
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

## Weitere Ordner

| Ordner | Inhalt |
|---|---|
| [`00-files/`](./00-files/) | Allgemeine Unterlagen (Modul-PDFs, Notizen, Sonstiges) |
| [`kompetenznachweis/`](./kompetenznachweis/) | Vorbereitung mündlicher Nachweis, Gesamt-Reflexion |

<br>

## KI-Nutzung

Der KI-Einsatz in diesem Projekt folgt dem verbindlichen Rahmen aus [`ki-nutzung.md`](https://ch-tbz-it.gitlab.io/Stud/m159/ki-nutzung.html) des Modul-Repositories. Wie KI konkret in diesem Projekt eingesetzt wird (Dokumentation, Diagramme, Status-Updates, Anleitungen, Screenshots), steht in [ki-einsatz.md](./ki-einsatz.md). Pro Auftrag mit KI-Anteil liegt zusätzlich ein `ki-log.md` mit Prompt, Verifikation und Reflexion vor, siehe zum Beispiel [01-planung/ki-log.md](./01-planung/ki-log.md).

<br>

<div align="center">

⬆️ [Nach oben](#-m159-directoryservices--projekt-contoso) · ➡️ [Weiter zu Auftrag 01](./01-planung/README.md)

</div>
