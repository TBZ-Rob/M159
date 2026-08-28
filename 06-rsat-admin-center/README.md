<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 06: RSAT & Admin Center V2

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal)
-->

![Phase](https://img.shields.io/badge/Phase-Offen-lightgrey?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-0%25-lightgrey?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1b7f79?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Offen-lightgrey?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-B%2C%20I-d29922?style=flat)

</div>

---

> ⚠️ **Direkt im Anschluss an [Auftrag 05](../05-aws-managed-ad/) durchführen** (gleicher kompakter Zeitraum kurz vor der Schlussbesprechung, siehe [Zeitplan](../README.md#zeitplan)).

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> RSAT-Tools zur Verwaltung installieren, Windows Admin Center V2 auf einer neuen EC2-Client-Instanz einrichten, den EC2-AD-DC hinzufügen und von aussen sicher erreichbar machen.

<br>

<h2 id="kernschritte"><font color="#8250df">Kernschritte</font></h2>

- Neue EC2-Client-Instanz innerhalb AWS Managed AD.
- RSAT installieren, Windows Admin Center V2 installieren (Setup-EXE bei Bedarf suchen):

  ```powershell
  Install-WindowsFeature -Name RSAT -IncludeAllSubFeature -IncludeManagementTools

  Get-ChildItem -Recurse -Path C:\ -Filter *AdminCenter*.exe -ErrorAction SilentlyContinue
  ```

- Nur den EC2-AD-DC zum Admin Center hinzufügen (Managed-AD-DCs können laut AWS nicht direkt hinzugefügt werden).
- WinRM-Ports 5985/5986 nur für die Admin-Center-IP/Subnetz öffnen, **nicht** auf 0.0.0.0/0.
- Admin Center via HTTPS/RDP von aussen erreichbar machen, Sicherheitsmassnahmen dokumentieren.

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [ ] Auftrag gestartet (direkt nach Auftrag 05)
- [ ] RSAT installiert
- [ ] Admin Center V2 eingerichtet
- [ ] EC2-AD-DC hinzugefügt
- [ ] Von aussen erreichbar, WinRM-Regeln eingeschränkt
- [ ] Umsetzung abgeschlossen
- [ ] Screenshots/Nachweise abgelegt
- [ ] `ki-log.md` ausgefüllt
- [ ] AWS Managed AD danach wieder gelöscht (Kosten stoppen)

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/06-rsat-admin-center-v2/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/06-rsat-admin-center-v2/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 05: AWS Managed Microsoft AD](../05-aws-managed-ad/README.md) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 07: DIT & GPOs](../07-dit-gpos/README.md)

</div>
