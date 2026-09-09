<div align="center">

# Auftrag 07: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-5-8250df?style=flat)

**📖 [Wie KI in diesem Projekt eingesetzt wird](../00-files/ki-einsatz.md)**

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| OU-Struktur und DIT-Diagramm entwerfen | "Wie sollte der DIT für acht Abteilungen aussehen, inklusive Benutzer-/Computer-Trennung, und erstelle dazu ein Diagramm im Stil des Repos." | Struktur mit den bestehenden Abteilungsgruppen aus Auftrag 04 abgeglichen, Diagramm optisch mit bestehenden Repo-Bildern verglichen | OU-Baum mit acht Abteilungen, je einer Benutzer- und Computer-Unter-OU, plus PNG-Diagramm in Hell und Dunkel |
| Fehlersuche bei fehlender GPO-Anwendung (Desktop-Link-CRM) | "Die GPO mit Security Filtering auf die Gruppe Intern wird bei anna.muster gar nicht angewendet, obwohl ihr Token die Gruppe enthält, woran kann das liegen?" | Event-Log (Event ID 5312) und `gpresult` auf dem Client direkt geprüft, Hypothesen einzeln mit PowerShell-Befehlen verifiziert oder verworfen | Ursache gefunden (verschachtelte Gruppenmitgliedschaft in Security Filtering wird nicht zuverlässig aufgelöst), Filterung auf direkte Gruppen umgestellt, danach reproduzierbar funktionierend |
| Diagnose leerer GPO-Versionsattribute (Drucker-Verteilung) | "SYSVOL-Inhalt der Drucker-GPO ist korrekt, aber UserVersion bleibt leer, wie finde ich die Ursache?" | `versionNumber` in AD und `Version` in `gpt.ini` direkt miteinander verglichen, nach dem Fix am echten Client (nicht nur in der GPMC-Anzeige) getestet | Rohwert-Abweichung zwischen AD und SYSVOL gefunden und synchronisiert, Druckerverteilung funktioniert nachweislich |
| Umsetzungsweg für Item-Level-Targeting ohne "Applications" unter Computer Configuration | "Applications gibt es bei uns nur unter User Configuration, die Aufgabe verlangt aber Computer Configuration, welche Alternative erreicht dasselbe Item-Level-Targeting?" | GPMC-Baum selbst durchsucht (Screenshot für Screenshot), um zu bestätigen dass kein Computer-Configuration-Pendant existiert, danach den Scheduled-Tasks-Ansatz am Client getestet | Scheduled Task mit demselben Item-Level-Targeting-Mechanismus verwendet, 7-Zip-Installation über Ereignisprotokoll bestätigt |
| Fehlende Preferences-Erweiterung reparieren | "Die Applications-Erweiterung fehlt in der Registry, aber die zugehörige DLL ist vorhanden, kann ich den Registry-Eintrag manuell nachtragen?" | Vorhandensein der DLL vor dem Eingriff geprüft, nach dem Eintrag den Registry-Schlüssel mit `Get-ItemProperty` kontrolliert | Fehlender Registry-Schlüssel unter `GPExtensions` erfolgreich nachgetragen (am Ende für diesen Auftrag nicht mehr gebraucht, da auf Scheduled Tasks umgestiegen wurde) |

### Reflexion

1. **Wo hat die KI geholfen?** Vor allem bei der systematischen Fehlersuche: Statt bei den ersten fehlgeschlagenen Tests aufzugeben oder wahllos etwas anderes zu probieren, wurden Hypothesen einzeln formuliert und mit konkreten PowerShell-Befehlen überprüft oder verworfen (zum Beispiel beim Security-Filtering-Problem oder bei der leeren GPO-Version). Das hat mehrfach Stunden gespart, weil die eigentliche Ursache jeweils tiefer lag als der erste Verdacht.
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Bei Teil 6 ging die KI zunächst davon aus, dass das Preferences-Element "Applications" wie bei anderen Preferences-Typen sowohl unter Computer- als auch unter User Configuration existiert, und schlug entsprechend vor, es einfach unter Computer Configuration zu suchen. Erst als ich mehrfach Screenshots vom tatsächlichen GPMC-Baum geschickt habe, wurde klar, dass es dieses Element dort schlicht nicht gibt. Ohne die eigenen Screenshots als Gegenprobe wäre unnötig lange am falschen Ort gesucht worden.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 07](./README.md)

</div>
