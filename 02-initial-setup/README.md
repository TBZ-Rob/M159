<div align="center">

# 📁 Auftrag 02: Initial Setup

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=orange · review=blueviolet · fertig=brightgreen
-->

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-10%25-orange?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1f6feb?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8957e5?style=flat)

**[Ziel](#-ziel) · [Netzwerk](#-schritt-1-bis-5-netzwerkgrundlage) · [Checkliste](#-checkliste)**

</div>

---

## 🎯 Ziel

> AWS-Netzwerkgrundlage aufbauen (VPC, Subnetze, Security Groups) und die drei EC2-Instanzen gemäss [Setup-Sheet](../01-planung/setup-sheet.md) erstellen.

<br>

> Werte stammen aus dem bereits ausgefuellten [Setup-Sheet](../01-planung/setup-sheet.md). Genaue Klickpfade in der AWS-Konsole koennen sich aendern, im Zweifel an der Oberflaeche orientieren statt stur dieser Anleitung folgen.

## 🧭 Schritt 1 bis 5: Netzwerkgrundlage

<details open>
<summary><strong>Schritt 1: AWS-Zugriff pruefen</strong></summary>

- In der AWS-Konsole einloggen (Education-/Studenten-Account).
- Region auswaehlen und für den Rest des Projekts konsequent dabei bleiben (Setup-Sheet nutzt `us-east-1` als Referenz).
- Pruefen, dass ein Budget/Limit vorhanden ist, das für 3 laufende Windows-EC2-Instanzen reicht.

</details>

<details open>
<summary><strong>Schritt 2: VPC erstellen</strong></summary>

- Neues VPC mit CIDR `10.0.0.0/16` erstellen.
- **Internet Gateway erstellen und am VPC anhaengen**, sonst sind auch die "oeffentlichen" Subnetze von aussen nicht erreichbar (kein RDP moeglich). Das "kein Gateway" aus der Modul-Aufgabenstellung ist so zu verstehen, dass vorerst **kein NAT Gateway** noetig ist (das braucht nur das private Subnetz für ausgehenden Internetzugriff, kostet zusaetzlich und kann bei Bedarf spaeter ergaenzt werden).
- Name z. B. `M159-vpc`, damit es im Setup-Sheet unter VPC-ID nachgetragen werden kann.

</details>

<details open>
<summary><strong>Schritt 3: Subnetze erstellen</strong></summary>

Vier Subnetze gemäss Setup-Sheet, je in einer eigenen Availability Zone:

| Name | CIDR | Typ |
|---|---|---|
| `M159-subnet-private1-us-east-1a` | `10.0.128.0/20` | privat |
| `M159-subnet-private2-us-east-1b` | `10.0.144.0/20` | privat |
| `M159-subnet-public1-us-east-1a` | `10.0.0.0/20` | oeffentlich |
| `M159-subnet-public2-us-east-1b` | `10.0.16.0/20` | oeffentlich |

Fuer die oeffentlichen Subnetze eine eigene Routentabelle mit Route `0.0.0.0/0 -> Internet Gateway` verknuepfen. Die privaten Subnetze bleiben vorerst ohne Route ins Internet.

Instanz-Platzierung gemäss Setup-Sheet Abschnitt 7 (DC bewusst im privaten Subnetz, siehe Hinweis unten):

| Instanz | Subnetz | Grund |
|---|---|---|
| DC (`dc.ad.contoso.com`, `10.0.128.10`) | `M159-subnet-private1-us-east-1a` | Kein direkter Internetzugriff auf den Domain Controller, realistischer/sicherer |
| Client (`client.ad.contoso.com`, `10.0.0.20`) | `M159-subnet-public1-us-east-1a` | Dient spaeter u. a. als Zwischenstation (RDP) zum DC |
| Admin Center (`admin.ad.contoso.com`, `10.0.0.30`) | `M159-subnet-public1-us-east-1a` | Muss von aussen erreichbar sein (Auftrag 06) |

</details>

<details open>
<summary><strong>Schritt 4: Security Groups erstellen</strong></summary>

Zwei Security Groups, Regeln stehen bereits im [Setup-Sheet](../01-planung/setup-sheet.md#5-aws-sicherheitsgruppen):

- **Domain Controller**: RDP, LDAP, LDAPS, Kerberos, SMB, DNS, RPC (inkl. Ephemeral-Port-Bereich 49152 bis 65535), ICMP, Global Catalog, Global Catalog SSL, Kerberos Password Change. Da der DC im privaten Subnetz liegt, kommt RDP darauf ohnehin nur aus dem VPC selbst an (z. B. vom Client aus), die SG-Regel `0.0.0.0/0` schadet trotzdem nicht, weil sie durch das fehlende Routing zum Internet Gateway faktisch nicht von aussen nutzbar ist.
- **Clients**: RDP von aussen, restliche Ports (Kerberos, RPC, NetBIOS, LDAP, DNS, SMB, RPC Ephemeral, ICMP) nur aus dem VPC-Adressbereich.

</details>

<details open>
<summary><strong>Schritt 5: Key Pair erstellen</strong></summary>

- Neues Key Pair erstellen (z. B. `m159-key`), `.pem`-Datei sicher ablegen.
- **Nicht ins Repository committen**, siehe `.gitignore` (`*.pem` ist bereits ausgeschlossen).
- Wird für den ersten Login (Administrator-Passwort entschluesseln) auf jeder neuen Instanz gebraucht.

</details>

<br>

## ✅ Checkliste

- [ ] AWS-Zugriff geprueft
- [ ] VPC erstellt (`10.0.0.0/16`) inkl. Internet Gateway
- [ ] 4 Subnetze erstellt, Routentabellen gesetzt
- [ ] 2 Security Groups erstellt
- [ ] Key Pair erstellt
- [ ] DC erstellt (Core, privates Subnetz)
- [ ] Client erstellt (Desktop, oeffentliches Subnetz)
- [ ] Admin Center erstellt (Desktop, oeffentliches Subnetz)
- [ ] Windows-Grundkonfiguration auf allen drei Instanzen
- [ ] Screenshots/Nachweise abgelegt
- [ ] `ki-log.md` ausgefuellt
- [ ] Setup-Sheet mit effektiven VPC-ID/Elastic IPs nachgefuehrt

<br>

## 🔗 Verweise

| Datei | Inhalt |
|---|---|
| [setup-sheet.md](../01-planung/setup-sheet.md) | Alle geplanten CIDRs, Security-Group-Regeln, Instanz-Daten |
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/02-initial-setup/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/02-initial-setup/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 01: Planung](../01-planung/) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 03: Gesamtstruktur (1. DC) & Client](../03-gesamtstruktur-dc-client/)

</div>
