<div align="center">

# 🗂️ M159: Directoryservices | Projekt Contoso

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-8%25-orange?style=flat)
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
| 🏢 On-Prem AD | [`ad.contoso.com`](./03-gesamtstruktur-dc-client/) |
| ☁️ AWS Managed AD | [`aws.contoso.com`](./05-aws-managed-ad/) |
| 🔑 Öffentlicher UPN | `contoso-robin.dynv6.net` |
| 📋 Details | [Setup-Sheet](./01-planung/setup-sheet.md) |

<br>

## 🗓️ Zeitplan

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       M159 Zeitplan (dienstags, 3 Netto-Lektionen)
    todayMarker on

    section Block 1
    01 Planung                         :active, t1, 2026-08-18, 1d
    02 Initial Setup                   :t2, 2026-08-25, 1d
    03 Gesamtstruktur & Client         :t3, 2026-09-01, 1d
    04 Freigaben/Berechtigungen        :t4, 2026-09-08, 1d
    Checkpoint: Zeitstand pruefen      :milestone, cp, 2026-09-08, 0d

    section Block 2
    05 AWS Managed AD + 06 RSAT        :t5, 2026-09-15, 1d
    07 DIT/GPOs + 08 Suche             :t6, 2026-09-22, 1d
    09 PowerShell + 10 Entra Connect   :t7, 2026-09-29, 1d
    10 fertig + 11 + 12 + 13           :t8, 2026-10-20, 1d
```

<details>
<summary>Als Tabelle anzeigen</summary>

<br>

| # | Datum | Auftrag | Status |
|---|---|---|---|
| 1 | Di, 18.08.2026 | [01: Planung](./01-planung/) | 🟡 in Arbeit |
| 2 | Di, 25.08.2026 | [02: Initial Setup](./02-initial-setup/) | ⬜ offen |
| 3 | Di, 01.09.2026 | [03: Gesamtstruktur (1. DC) & Client](./03-gesamtstruktur-dc-client/) | ⬜ offen |
| 4 | Di, 08.09.2026 | [04: Freigaben/Berechtigungen](./04-freigaben-berechtigungen/) | ⬜ offen |
| n/a | n/a | **Checkpoint: Zeitstand prüfen** | n/a |
| 5 | Di, 15.09.2026 | [05: AWS Managed AD](./05-aws-managed-ad/) + [06: RSAT & Admin Center](./06-rsat-admin-center/) | ⬜ offen |
| 6 | Di, 22.09.2026 | [07: DIT & GPOs](./07-dit-gpos/) + [08: Suche im Directory](./08-suche-im-directory/) | ⬜ offen |
| 7 | Di, 29.09.2026 | [09: PowerShell-Debugging](./09-identity-mgmt-powershell/) + [10: Entra Connect (Start)](./10-entra-connect/) | ⬜ offen |
| 8 | Di, 20.10.2026 | 10 fertig + [11](./11-benutzerprofil/)/[12](./12-netzlaufwerk-azure/)/[13](./13-sso-python-app/) (Rest ggf. Selbstarbeit) | ⬜ offen |

</details>

<br>

## 📋 Aufträge: Übersicht

### Block 1: Lokale Umgebung

| # | Auftrag | Status | Modul-Auftrag |
|---|---|---|---|
| [01](./01-planung/) | Planung | 🟡 in Arbeit | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/01-planung/) |
| [02](./02-initial-setup/) | Initial Setup | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/02-initial-setup/) |
| [03](./03-gesamtstruktur-dc-client/) | Gesamtstruktur (1. DC) & Client | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/03-neue-gesamtstruktur-und-client/) |
| [04](./04-freigaben-berechtigungen/) | Freigaben, Laufwerke, Berechtigungen | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/04-freigaben-laufwerke-berechtigungen/) |
| [05](./05-aws-managed-ad/) | AWS Managed Microsoft AD | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/05-aws-managed-microsoft-ad/) |
| [06](./06-rsat-admin-center/) | RSAT & Admin Center V2 | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/06-rsat-admin-center-v2/) |
| [07](./07-dit-gpos/) | DIT & GPOs | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/07-dit-gpos/) |
| [08](./08-suche-im-directory/) | Suche im Directory (LDAP) | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/08-suche-im-directory/) |
| [09](./09-identity-mgmt-powershell/) | Identity Management & PowerShell Debugging | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/09-automation-und-debugging/) |

### Block 2: Cloud-Integration

| # | Auftrag | Status | Modul-Auftrag |
|---|---|---|---|
| [10](./10-entra-connect/) | MS Entra ID & MS Entra Connect | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/10-ms-entra-id-ms-entra-connect/) |
| [11](./11-benutzerprofil/) | Servergespeicherte Benutzerprofile | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/11-servergespeicherte-benutzerprofile/) |
| [12](./12-netzlaufwerk-azure/) | Netzlaufwerk to Azure Migration | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/12-netzlaufwerk-to-azure-migration/) |
| [13](./13-sso-python-app/) | SSO Python App | ⬜ offen | [↗](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/13-sso-python-app/) |

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

⬆️ [Nach oben](#️-m159-directoryservices--projekt-contoso) · ➡️ [Weiter zu Auftrag 01](./01-planung/)

</div>
