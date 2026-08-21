<div align="center">

# 📁 Auftrag 01: Planung

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=orange · review=blueviolet · fertig=brightgreen
-->

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-25%25-orange?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1f6feb?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8957e5?style=flat)

**[Ziel](#-ziel) · [Checkliste](#-checkliste) · [Namensschema](#2-namensschema-festlegen) · [Architektur](#️-architektur) · [Begriffe](#-begriffsklärungen) · [Nachweise](#️-nachweise)**

</div>

---

## 🎯 Ziel

> Detaillierte Projektplanung der AD/Cloud-Umgebung erstellen inkl. Definition aller relevanten Parameter und Nachweis der Cloud-Bereitschaft.

<br>

## ✅ Checkliste

- [x] Repo-Grundstruktur angelegt
- [x] Domain-Namensschema festgelegt (Contoso)
- [ ] Setup-Sheet vollständig ausgefüllt (Platzhalter wie Klasse, Repo-Link, EIPs folgen in Auftrag 02)
- [x] Azure for Students aktiviert (Screenshot)
- [x] Entra-ID-Tenant geprüft (Screenshot, Ergebnis: kein Admin-Zugriff im TBZ-Tenant, dokumentiert)
- [x] Architektur-Skizze erstellt (siehe unten)
- [x] `ki-log.md` angelegt

<br>

## 🧭 Vorgehen

<details open>
<summary><strong>1. Repo & Struktur</strong></summary>

Repo-Grundgerüst mit einheitlichem Schema pro Auftrag (README, ki-log, ggf. Entscheidungsprotokoll, Screenshots) angelegt. Vorlagen (Header, Badges) wiederverwendbar für alle Aufträge. Details zur Wahl siehe [ki-log.md](./ki-log.md).

</details>

<details open>
<summary><strong>2. Namensschema festlegen</strong></summary>

Als Domain-Basis wurde **Contoso** gewählt, nämlich die von Microsoft in praktisch jeder AD-/Azure-/Entra-Dokumentation verwendete fiktive Beispielfirma. Vorteil: sofort erkennbares, branchenübliches Namensschema statt modul-spezifischem Namen. Abwägung siehe [entscheidungsprotokoll.md](./entscheidungsprotokoll.md).

- Second-Level-Domäne (fiktive Firma): `contoso.com`
- On-Prem AD (EC2, Third-Level): `ad.contoso.com` → [Auftrag 03](../03-gesamtstruktur-dc-client/)
- AWS Managed AD (Third-Level): `aws.contoso.com` → [Auftrag 05](../05-aws-managed-ad/)
- Öffentlicher UPN (später, via dynv6.com): `contoso-robin.dynv6.net` → [Auftrag 13](../13-sso-python-app/)

</details>

<details open>
<summary><strong>3. Cloud-Bereitschaft prüfen</strong></summary>

Azure for Students ist erfolgreich aktiviert. Der Entra-ID-Tenant lässt sich mit dem TBZ-Schul-Account nicht als Admin einsehen (kein Zugriff, dokumentiert), dafür wird in Auftrag 10 ein eigener Tenant benötigt. Details siehe [cloud-readiness.md](./cloud-readiness.md). Wichtig laut Modulvorgabe: **jetzt prüfen, nicht erst später**, da ein Scheitern des Tenants Zeit kostet, die sich später nicht mehr aufholen lässt, genau das haben wir hier frühzeitig erkannt.

</details>

<br>

## 🖥️ Architektur

Erster Entwurf der Zielumgebung. Details (genaue CIDRs/IPs) folgen in [Auftrag 02](../02-initial-setup/) und stehen im [Setup-Sheet](./setup-sheet.md).

```mermaid
flowchart TB
    subgraph AWS["AWS VPC 10.0.0.0/16"]
        DC["🖥️ DC EC2<br/>dc.ad.contoso.com<br/>ad.contoso.com"]
        CLIENT["💻 Client EC2<br/>client.ad.contoso.com"]
        ADMIN["🛠️ Admin Center EC2<br/>admin.ad.contoso.com"]
        MAD["☁️ AWS Managed AD<br/>aws.contoso.com"]
        DC --- CLIENT
        DC --- ADMIN
    end

    ENTRA["🔷 Microsoft Entra ID<br/>contoso.com Tenant"]
    UPN["🌐 Öffentlicher UPN<br/>contoso-robin.dynv6.net"]

    DC -- "Tree-Root Trust" --> MAD
    DC -- "Entra Connect (Sync)" --> ENTRA
    ENTRA --- UPN

    click DC "../03-gesamtstruktur-dc-client/" "Auftrag 03 Gesamtstruktur und Client"
    click MAD "../05-aws-managed-ad/" "Auftrag 05 AWS Managed AD"
    click ENTRA "../10-entra-connect/" "Auftrag 10 Entra Connect"
    click UPN "../13-sso-python-app/" "Auftrag 13 SSO Python App"
```

| Feld | Wert | Details |
|---|---|---|
| On-Prem AD Domäne | `ad.contoso.com` | [Auftrag 03](../03-gesamtstruktur-dc-client/) |
| AWS Managed AD Domäne | `aws.contoso.com` | [Auftrag 05](../05-aws-managed-ad/) |
| Trust-Typ | Tree-Root Trust | [Setup-Sheet](./setup-sheet.md#6-active-directory-umgebung) |
| Entra ID Sync | Entra Connect | [Auftrag 10](../10-entra-connect/) |
| Öffentlicher UPN (geplant) | `contoso-robin.dynv6.net` | [Auftrag 13](../13-sso-python-app/) |

<br>

## 📖 Begriffsklärungen

Kurze, selbst recherchierte Erklärungen zu Begriffen aus dem Modul.

<details open>
<summary><strong>VPC (Virtual Private Cloud)</strong></summary>

Eine VPC ist kein physisches Gerät, sondern ein isolierter, privater Netzwerkabschnitt in der Cloud (z. B. bei AWS oder Google Cloud), in dem eigene virtuelle Maschinen (Instanzen) laufen. Sie verhalten sich wie normale Server, sind aber durch Firewalls und private IP-Adressen vom öffentlichen Internet abgeschottet. Selbst recherchiert am 19.08.2026.

</details>

<br>

## 🖼️ Nachweise

<details>
<summary><strong>Screenshots anzeigen</strong></summary>

<br>

| Screenshot | Beschreibung |
|---|---|
| [01-azure-for-students.png](./00-screenshots/01-azure-for-students.png) | Azure for Students: erfolgreich aktiviert |
| [02-entra-id-tenant.png](./00-screenshots/02-entra-id-tenant.png) | Entra-ID-Tenant: kein Admin-Zugriff im TBZ-Tenant (dokumentierter Fehlschlag) |

Details und Vorgehen bei Fehlschlag: [cloud-readiness.md](./cloud-readiness.md)

</details>

<br>

## 🔗 Verweise

| Datei | Inhalt |
|---|---|
| [setup-sheet.md](./setup-sheet.md) | Vollständige Ressourcen-, Netzwerk- und Zugangsdaten-Übersicht |
| [cloud-readiness.md](./cloud-readiness.md) | Cloud-Bereitschaft-Check (Azure/Entra) |
| [entscheidungsprotokoll.md](./entscheidungsprotokoll.md) | Begründung Domain-Namensschema |
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/01-planung/) | Offizielle Aufgabenstellung |

<br>

<div align="center">

🏠 [Übersicht](../README.md) · ➡️ [Weiter zu Auftrag 02](../02-initial-setup/)

</div>
