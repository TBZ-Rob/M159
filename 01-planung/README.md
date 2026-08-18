<div align="center">

# 📁 Auftrag 01: Planung

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=orange · review=blueviolet · fertig=brightgreen
-->

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=for-the-badge)
![Fortschritt](https://img.shields.io/badge/Fortschritt-25%25-orange?style=for-the-badge)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1f6feb?style=for-the-badge)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8957e5?style=for-the-badge)

</div>

---

## 🎯 Ziel

> Detaillierte Projektplanung der AD/Cloud-Umgebung erstellen inkl. Definition aller relevanten Parameter und Nachweis der Cloud-Bereitschaft.

<br>

## ✅ Checkliste

- [x] Repo-Grundstruktur angelegt
- [x] Domain-Namensschema festgelegt (Contoso)
- [ ] Setup-Sheet vollständig ausgefüllt
- [ ] Azure for Students aktiviert (Screenshot)
- [ ] Entra-ID-Tenant geprüft (Screenshot)
- [ ] Architektur-Skizze erstellt
- [x] `ki-log.md` angelegt

<br>

## 🧭 Vorgehen

<details open>
<summary><strong>1. Repo & Struktur</strong></summary>

Repo-Grundgerüst mit einheitlichem Schema pro Auftrag (README, ki-log, ggf. Entscheidungsprotokoll, Screenshots) angelegt. Vorlagen (Header, Badges) wiederverwendbar für alle Aufträge.

</details>

<details>
<summary><strong>2. Namensschema festlegen</strong></summary>

Als Domain-Basis wurde **Contoso** gewählt, nämlich die von Microsoft in praktisch jeder AD-/Azure-/Entra-Dokumentation verwendete fiktive Beispielfirma. Vorteil: sofort erkennbares, branchenübliches Namensschema statt modul-spezifischem Namen.

- Second-Level-Domäne (fiktive Firma): `contoso.com`
- On-Prem AD (EC2, Third-Level): `ad.contoso.com`
- AWS Managed AD (Third-Level): `aws.contoso.com`
- Öffentlicher UPN (später, via dynv6.com): `contoso-robin.dynv6.net`

</details>

<details>
<summary><strong>3. Cloud-Bereitschaft prüfen</strong></summary>

Noch ausstehend, Azure for Students und Entra-ID-Tenant müssen heute noch geprüft werden, siehe [cloud-readiness.md](./cloud-readiness.md). Wichtig laut Modulvorgabe: **jetzt prüfen, nicht erst später**, da ein Scheitern des Tenants Zeit kostet, die sich später nicht mehr aufholen lässt.

</details>

<br>

## 🖥️ Geplante Umgebung (Kurzüberblick)

| Feld | Wert |
|---|---|
| On-Prem AD Domäne | `ad.contoso.com` |
| AWS Managed AD Domäne | `aws.contoso.com` |
| Trust-Typ | Tree-Root Trust |
| Öffentlicher UPN (geplant) | `contoso-robin.dynv6.net` |

Details siehe [setup-sheet.md](./setup-sheet.md).

<br>

## 🖼️ Nachweise

<details>
<summary><strong>Screenshots anzeigen</strong></summary>

<br>

| Screenshot | Beschreibung |
|---|---|
| _ausstehend_ | Azure for Students: Aktivierung/Ablehnung |
| _ausstehend_ | Entra-ID-Tenant-Übersicht mit Tenant-ID |

</details>

<br>

## 🔗 Verweise

- [ki-log.md](./ki-log.md)
- [setup-sheet.md](./setup-sheet.md)
- [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/01-planung/)

<br>

<div align="center">

⬅️ [Zurück zur Übersicht](../README.md)

</div>
