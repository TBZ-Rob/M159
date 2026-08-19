<div align="center">

# 📁 Auftrag 05: AWS Managed Microsoft AD

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=orange · review=blueviolet · fertig=brightgreen
-->

![Phase](https://img.shields.io/badge/Phase-Offen-lightgrey?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-0%25-lightgrey?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1f6feb?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Offen-lightgrey?style=flat)

</div>

---

> ⚠️ **Zeitlich bewusst ans Ende verschoben.** AWS Managed AD kostet ca. 18 Dollar pro Woche, siehe [Zeitplan](../README.md#️-zeitplan). Erst kurz vor der Schlussbesprechung starten, direkt mit [Auftrag 06](../06-rsat-admin-center/) weitermachen, danach die Managed-AD-Domain sofort wieder loeschen.

## 🎯 Ziel

> AWS Managed Microsoft AD einrichten (Domaene, Ports gemaess [Setup-Sheet](../01-planung/setup-sheet.md)), Conditional Forwarder zur eigenen On-Prem-AD einrichten und einen beidseitigen Trust aufbauen und validieren.

<br>

## 🧭 Kernschritte

- AWS Managed AD Domaene erstellen, Passwort im Setup-Sheet (Passwort-Manager) hinterlegen.
- Ports gemaess Setup-Sheet sicherstellen.
- Conditional Forwarder einrichten, damit die EC2-AD die AWS-Managed-Domain aufloesen kann, Test mit `nslookup -type=SOA aws.contoso.com`.
- Trust beidseitig einrichten (EC2-AD ueber "Active Directory Domains and Trusts" sowie auf AWS-Managed-AD-Seite), danach validieren.
- Sicherheitsdokumentation ergaenzen (welche Ports offen, warum).

<br>

## ✅ Checkliste

- [ ] Auftrag gestartet (erst kurz vor Schlussbesprechung)
- [ ] Managed AD Domaene erstellt
- [ ] Conditional Forwarder eingerichtet und getestet
- [ ] Trust eingerichtet und validiert
- [ ] Umsetzung abgeschlossen
- [ ] Screenshots/Nachweise abgelegt
- [ ] `ki-log.md` ausgefuellt
- [ ] Managed AD nach Abschluss von Auftrag 06 wieder geloescht (Kosten stoppen)

<br>

## 🔗 Verweise

| Datei | Inhalt |
|---|---|
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/05-aws-managed-microsoft-ad/) | Offizielle Aufgabenstellung |

<br>

<div align="center">

⬅️ [Auftrag 04: Freigaben, Laufwerke, Berechtigungen](../04-freigaben-berechtigungen/) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 06: RSAT & Admin Center V2](../06-rsat-admin-center/)

</div>
