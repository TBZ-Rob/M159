<div align="center">

# Auftrag 09: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-3-8250df?style=flat)

**📖 [Wie KI in diesem Projekt eingesetzt wird](../00-files/ki-einsatz.md)**

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Systematische Fehleranalyse des vorgegebenen Skripts | "Analysiere dieses Skript und finde die fünf enthaltenen Fehler" | Jede Korrektur einzeln gegen die tatsächliche PowerShell-Semantik geprüft (z. B. Dokumentation zu `ConvertFrom-SecureString` vs. `ConvertTo-SecureString`), danach am echten Domain-Controller ausgeführt statt nur angenommen | Alle fünf Fehler korrekt identifiziert und behoben, Skript lief beim ersten Testlauf fehlerfrei durch |
| Auflösen eines Widerspruchs in der offiziellen Aufgabenstellung (OU-Name) | "Die Aufgabenstellung nennt im selben Abschnitt einmal User und einmal User-ImportUser als OU-Namen, was ist damit gemeint?" | Wortlaut der Aufgabenstellung erneut gezielt abgefragt und wörtlich zitiert, danach mit dem vorgegebenen Skript-Code abgeglichen, der nur eine Ebene verwendet | Entscheidung für eine einzige OU `User` getroffen und im Entscheidungsprotokoll begründet, statt eine zusätzliche Ebene zu raten |
| Implementierung und Test der Vorab-Validierung (Teil B) | "Erweitere das Skript so, dass bereits bestehende Benutzer erkannt und übersprungen werden, mit farbiger Ausgabe" | Skript zweimal hintereinander ausgeführt: erster Lauf legt die User an, zweiter Lauf muss alle als bereits existierend erkennen, beides am echten Domain-Controller verifiziert | Vorab-Prüfung mit `Get-ADUser -Filter` eingebaut, Idempotenz durch den Zweitlauf bestätigt |

### Reflexion

1. **Wo hat die KI geholfen?** Am meisten bei der sauberen Trennung der fünf Fehlerkategorien: statt das Skript nur "irgendwie lauffähig" zu machen, wurde jeder Fehler einzeln benannt, kategorisiert und mit der jeweils korrekten PowerShell-Semantik begründet (z. B. warum `$row.Vorname` in doppelten Anführungszeichen nicht funktioniert, aber `$($row.Vorname)` schon). Das hat die Dokumentation im Error-Log deutlich präziser gemacht, als nur "Bugs gefixt" zu schreiben.
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Bei der ersten Reaktion auf den OU-Namenskonflikt in der Aufgabenstellung hätte die KI beinahe eine eigene Interpretation gewählt (Vermutung, dass eine Zwischenebene gemeint sein könnte), ohne das explizit als Unsicherheit zu kennzeichnen. Erst die Nachfrage, ob das wirklich in der Aufgabenstellung so steht, hat zu einer sauberen Prüfung des exakten Wortlauts geführt, und offengelegt, dass die Aufgabenstellung selbst widersprüchlich ist statt dass eine Zwischenebene übersehen wurde.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 09](./README.md)

</div>
