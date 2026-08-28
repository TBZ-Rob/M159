<div align="center">

# KI-Einsatz im Projekt

![Gültig für](https://img.shields.io/badge/Gültig%20für-Gesamtes%20Repo-8250df?style=flat)

**Zentrale Übersicht, wie KI in diesem Projekt eingesetzt wird.**

</div>

---

## Zweck dieser Seite

Der verbindliche Rahmen für KI-Nutzung in diesem Modul steht in [`ki-nutzung.md`](https://ch-tbz-it.gitlab.io/Stud/m159/ki-nutzung.html) des Modul-Repositories: KI darf als Tutor, Sparringpartner und Reviewer eingesetzt werden, nicht um Arbeit zu übernehmen, die selbst gemacht werden muss. Diese Seite beschreibt konkret, in welchen Bereichen dieses Projekts KI wie genau eingesetzt wurde, damit das nicht in jedem `ki-log.md` einzeln neu erklärt werden muss.

<br>

## Einsatzbereiche

<details open>
<summary><strong>📝 Dokumentation (README, Vorgehen-Texte)</strong></summary>

Die KI hat die README-Texte pro Auftrag formuliert, und zwar auf Basis von tatsächlich selbst ausgeführten PowerShell-Befehlen, Konsoleneinstellungen und Testergebnissen, die jeweils zurückgemeldet wurden. Die KI hat nichts an Handlungen erfunden oder als erledigt markiert, das nicht tatsächlich durchgeführt wurde. Struktur (Badges, `<details>`-Blöcke, Verweise-Tabellen, Breadcrumbs) wurde einmal in Auftrag 01 festgelegt und danach konsequent für alle weiteren Aufträge wiederverwendet, damit das Repo einheitlich aussieht.

</details>

<details open>
<summary><strong>📊 Diagramme (Mermaid: Architektur, Gantt, AGDLP-Gruppendiagramme)</strong></summary>

Alle Mermaid-Diagramme im Repo (Architektur-Übersicht in Auftrag 01, Zeitplan-Gantt im Root-README, AGDLP-Gruppendiagramme in Auftrag 04) wurden von der KI aus den bereits umgesetzten/geplanten Strukturen abgeleitet, nicht frei erfunden. Bei den AGDLP-Diagrammen gab es mehrere Iterationen, bis Linienführung und Lesbarkeit passten (Layout-Renderer, Linienfarben, Aufteilung in mehrere kleinere Diagramme statt einem unübersichtlichen grossen), das lief über direktes Feedback zu Screenshots des gerenderten Ergebnisses.

</details>

<details open>
<summary><strong>🔄 Status-Updates (Badges, Checklisten, Fortschritt)</strong></summary>

Phase-Badges, Fortschritt-Prozentzahlen und Checklisten-Häkchen werden von der KI nur gesetzt, wenn der entsprechende Schritt tatsächlich (durch Rückmeldung, Screenshot oder Testresultat) bestätigt wurde. Bei mehreren repo-weiten Konsistenz-Checks wurden veraltete oder falsch gesetzte Status gefunden (z. B. Auftrag 01 im Root-README fälschlich als erledigt markiert, während die eigene README noch offene Punkte zeigte) und korrigiert, indem der dokumentierte Ist-Zustand aus den bisherigen Gesprächen und Dateien mit dem tatsächlichen Stand abgeglichen wurde.

</details>

<details open>
<summary><strong>📋 Anleitungen (PowerShell-Befehle, Schritt-für-Schritt-Vorgehen)</strong></summary>

Konkrete Befehle (z. B. `New-ADGroup`, `icacls`, `Set-SmbShare`) wurden von der KI basierend auf der jeweiligen Aufgabenstellung und den offiziellen Berechtigungsmatrizen vorgeschlagen, aber immer selbst auf den Servern ausgeführt, nie automatisiert im Hintergrund. Jeder Befehl wurde nach der Ausführung mit seinem tatsächlichen Ergebnis (Output, Fehlermeldung, Screenshot) zurückgemeldet, sodass Fehler in der Anleitung (z. B. eine falsch übertragene Zeile aus der Berechtigungsmatrix in Auftrag 04, ein PTR-Record in der falschen DNS-Zone in Auftrag 03) direkt am echten System auffielen und nicht unbemerkt blieben.

</details>

<details open>
<summary><strong>🖼️ Screenshots (Benennung, Einordnung, Ablage)</strong></summary>

Screenshots werden ausschliesslich selbst erstellt (Konsole, PowerShell, RDP-Sitzungen), die KI kann keine eigenen Screenshots der AWS-/AD-Umgebung machen. Die KI übernimmt das Umbenennen nach dem Repo-Schema, das Verschieben in den korrekten `00-screenshots`-Ordner des jeweiligen Auftrags sowie die inhaltliche Prüfung (passt der Screenshot zum behaupteten Ergebnis, ist der richtige Befehl/Server sichtbar), bevor er im README verlinkt wird.

</details>

<br>

## Wichtig: Was die KI nicht tut

- Keine Befehle direkt auf den AWS-/AD-Systemen ausführen (kein Zugriff), alles wird selbst ausgeführt und der KI zurückgemeldet.
- Keine Screenshots oder Testergebnisse erfinden oder Schritte als erledigt markieren, die nicht tatsächlich durchgeführt wurden.
- Keine git-Operationen (commit, push) durchführen, das bleibt Handarbeit.
- Keine Dateien auf dem lokalen Rechner löschen (technische Einschränkung der Geräte-Anbindung), auch das bleibt Handarbeit.
- Bei Entscheidungen, die inhaltliches Wissen über den bisherigen Projektverlauf voraussetzen (z. B. welcher Auftrag tatsächlich fertig ist), soll die KI das selbst anhand der Dokumentation und des bisherigen Gesprächsverlaufs bestimmen, statt bei jeder Kleinigkeit nachzufragen.

<br>

## Verweise

| Datei | Inhalt |
|---|---|
| [ki-nutzung.md (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/ki-nutzung.html) | Verbindlicher Rahmen für KI-Nutzung im Modul |
| [README.md](./README.md) | Projektübersicht |

<br>

<div align="center">

🏠 [Übersicht](./README.md)

</div>
