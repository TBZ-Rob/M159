<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 05: AWS Managed Microsoft AD

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal)
-->

![Phase](https://img.shields.io/badge/Phase-Offen-lightgrey?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-0%25-lightgrey?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1b7f79?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Offen-lightgrey?style=flat)

</div>

---

> ⚠️ **Zeitlich bewusst ans Ende verschoben.** AWS Managed AD kostet ca. 18 Dollar pro Woche, siehe [Zeitplan](../README.md#zeitplan). Erst kurz vor der Schlussbesprechung starten, direkt mit [Auftrag 06](../06-rsat-admin-center/) weitermachen, danach die Managed-AD-Domain sofort wieder löschen.

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> AWS Managed Microsoft AD einrichten (Domäne, Ports gemäss [Setup-Sheet](../01-planung/setup-sheet.md)), Conditional Forwarder zur eigenen On-Prem-AD einrichten und einen beidseitigen Trust aufbauen und validieren.

<br>

<h2 id="kernschritte"><font color="#8250df">Kernschritte</font></h2>

- AWS Managed AD Domäne erstellen, Passwort im Setup-Sheet (Passwort-Manager) hinterlegen.
- Ports gemäss Setup-Sheet sicherstellen.
- Conditional Forwarder einrichten, damit die EC2-AD die AWS-Managed-Domain aufloesen kann, Test mit `nslookup -type=SOA aws.contoso.com`.
- Trust beidseitig einrichten (EC2-AD über "Active Directory Domains and Trusts" sowie auf AWS-Managed-AD-Seite), danach validieren.
- Sicherheitsdokumentation ergänzen (welche Ports offen, warum).

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [ ] Auftrag gestartet (erst kurz vor Schlussbesprechung)
- [ ] Managed AD Domäne erstellt
- [ ] Conditional Forwarder eingerichtet und getestet
- [ ] Trust eingerichtet und validiert
- [ ] Umsetzung abgeschlossen
- [ ] Screenshots/Nachweise abgelegt
- [ ] `ki-log.md` ausgefüllt
- [ ] Managed AD nach Abschluss von Auftrag 06 wieder gelöscht (Kosten stoppen)

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/05-aws-managed-microsoft-ad/) | Offizielle Aufgabenstellung |

<br>

<div align="center">

⬅️ [Auftrag 04: Freigaben, Laufwerke, Berechtigungen](../04-freigaben-berechtigungen/README.md) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 06: RSAT & Admin Center V2](../06-rsat-admin-center/README.md)

</div>
