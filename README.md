<div align="center">

# 🗂️ M159: Directoryservices | Projekt Contoso

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=for-the-badge)
![Fortschritt](https://img.shields.io/badge/Fortschritt-8%25-orange?style=for-the-badge)
![Domain](https://img.shields.io/badge/Domain-contoso.com-1f6feb?style=for-the-badge)
![Cloud](https://img.shields.io/badge/Cloud-AWS%20%2B%20Azure-8957e5?style=for-the-badge)

</div>

---

## 📌 Kurzüberblick

Aufbau einer Active-Directory-Umgebung (Contoso) auf AWS EC2, Integration mit AWS Managed Microsoft AD und Anbindung an Microsoft Entra ID. Details siehe [Setup-Sheet](./01-planung/setup-sheet.md).

<br>

## 🗓️ Zeitplan

| # | Datum | Auftrag | Status |
|---|---|---|---|
| 1 | Di, 18.08.2026 | 01: Planung | 🟡 in Arbeit |
| 2 | Di, 25.08.2026 | 02: Initial Setup | ⬜ offen |
| 3 | Di, 01.09.2026 | 03: Gesamtstruktur (1. DC) & Client | ⬜ offen |
| 4 | Di, 08.09.2026 | 04: Freigaben/Berechtigungen | ⬜ offen |
| n/a | n/a | **Checkpoint: Zeitstand prüfen** | n/a |
| 5 | Di, 15.09.2026 | 05: AWS Managed AD + 06: RSAT & Admin Center | ⬜ offen |
| 6 | Di, 22.09.2026 | 07: DIT & GPOs + 08: Suche im Directory | ⬜ offen |
| 7 | Di, 29.09.2026 | 09: PowerShell-Debugging + 10: Entra Connect (Start) | ⬜ offen |
| 8 | Di, 20.10.2026 | 10 fertig + 11/12/13 (Rest ggf. Selbstarbeit) | ⬜ offen |

<br>

## 📋 Aufträge: Übersicht

### Block 1: Lokale Umgebung

| # | Auftrag | Status |
|---|---|---|
| [01](./01-planung/) | Planung | 🟡 in Arbeit |
| [02](./02-initial-setup/) | Initial Setup | ⬜ offen |
| [03](./03-gesamtstruktur-dc-client/) | Gesamtstruktur (1. DC) & Client | ⬜ offen |
| [04](./04-freigaben-berechtigungen/) | Freigaben, Laufwerke, Berechtigungen | ⬜ offen |
| [05](./05-aws-managed-ad/) | AWS Managed Microsoft AD | ⬜ offen |
| [06](./06-rsat-admin-center/) | RSAT & Admin Center V2 | ⬜ offen |
| [07](./07-dit-gpos/) | DIT & GPOs | ⬜ offen |
| [08](./08-suche-im-directory/) | Suche im Directory (LDAP) | ⬜ offen |
| [09](./09-identity-mgmt-powershell/) | Identity Management & PowerShell Debugging | ⬜ offen |

### Block 2: Cloud-Integration

| # | Auftrag | Status |
|---|---|---|
| [10](./10-entra-connect/) | MS Entra ID & MS Entra Connect | ⬜ offen |
| [11](./11-benutzerprofile/) | Servergespeicherte Benutzerprofile | ⬜ offen |
| [12](./12-netzlaufwerk-azure/) | Netzlaufwerk to Azure Migration | ⬜ offen |
| [13](./13-sso-python-app/) | SSO Python App | ⬜ offen |

<br>

## 📁 Weitere Ordner

- [`files/`](./files/): allgemeine Unterlagen (Modul-PDFs, Notizen, Sonstiges)
- [`kompetenznachweis/`](./kompetenznachweis/): Vorbereitung mündlicher Nachweis, Gesamt-Reflexion

<br>

## 🤖 KI-Nutzung

Der KI-Einsatz in diesem Projekt folgt dem verbindlichen Rahmen aus `ki-nutzung.md` des Modul-Repositories. Pro Auftrag mit KI-Anteil liegt ein `ki-log.md` mit Prompt, Verifikation und Reflexion vor.
