<div align="center">

# Auftrag 08: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-3-8250df?style=flat)

**📖 [Wie KI in diesem Projekt eingesetzt wird](../00-files/ki-einsatz.md)**

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Diagnose des fehlerhaften Binding-Aufbaus im ldp.exe Targeting-Editor | "Ich weiss nicht wohin Filter, Binding und Attribute genau gehören, ist das so richtig?" | Testweise verschiedene Kombinationen ausprobiert und die tatsächliche Verhaltensänderung am Client beobachtet, statt blind einer einzigen Vermutung zu folgen | Korrekte Aufteilung auf die drei Felder geklärt, inklusive einer eigenen Fehlkorrektur unterwegs (Vorschlag alles ins Binding-Feld zu packen war falsch und wurde zurückgenommen) |
| Ursachenfindung für ein GPO-Preferences-Item, das trotz jedem Filterinhalt immer zutraf | "Der Shortcut erscheint bei jedem Benutzer, egal was ich im Filter eintrage, sogar bei einem garantiert falschen Wert" | Systematisch einzelne Bestandteile isoliert getestet (Matching-Rule allein, direkte Mitgliedschaft allein, Attribute-Feld leer vs. gesetzt, Binding-Feld mit vollem Pfad), Web-Recherche zur offiziellen LDAP-Query-Targeting-Syntax herangezogen | Zwei unabhängige Ursachen gefunden: fehlende AD-Versions-Synchronisation (bekanntes Muster aus Auftrag 07) und die fehlende `%LogonUser%`-Variable, ohne die die Query nicht auf den aktuellen Benutzer bezogen wird |
| Formulierung des Firewall-Konfigurationsblatts und der Begründungen | "Erstelle ein Konfigurationsblatt mit Begründung für Dienstkonto und Port, da keine offizielle Vorlage vorliegt" | Inhaltlich gegen die Anforderungen der offiziell abgerufenen Aufgabenstellung abgeglichen (Dienstkonto-Optionen, Port-Begründung, Zugriffseinschränkung) | Vollständiges Konfigurationsblatt inklusive beidseitig abgewogener Begründungen für Dienstkonto- und Portwahl |

### Reflexion

1. **Wo hat die KI geholfen?** Am meisten bei der eigentlichen Fehlersuche in Teil 4: Ein Preferences-Item, das trotz offensichtlich falschem Filter immer zutraf, wäre ohne systematisches Eingrenzen (Filter isoliert testen, dann Attribute-Feld, dann Binding-Feld, erst danach die Web-Recherche zur `%LogonUser%`-Variable) vermutlich stundenlang durch reines Ausprobieren zufälliger Filter-Varianten angegangen worden. Die schrittweise Eingrenzung hat die tatsächliche Ursache gezielt gefunden.
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Bei der ersten Erklärung zum Targeting-Editor-Aufbau widersprach sich die KI innerhalb weniger Nachrichten selbst (zuerst "alles ins Binding-Feld", dann "nur ins Filter-Feld"), was erst durch einen Screenshot der eigenen, widersprüchlichen Textantwort auffiel. Ohne dieses genaue Nachprüfen wäre unklar geblieben, welche der beiden Aussagen tatsächlich gilt.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 08](./README.md)

</div>
