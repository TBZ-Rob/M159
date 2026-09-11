<div align="center">

# Auftrag 11: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-2-1b7f79?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Klärung, ob Auftrag 11 unabhängig von Auftrag 10 umsetzbar ist | Ich habe die offizielle Aufgabenstellung von Auftrag 11 direkt abrufen und wortwörtlich zitieren lassen, um zu prüfen, ob FSLogix wirklich ohne Azure-Tenant funktioniert | Wortwörtlicher Vergleich mit der Original-Aufgabenstellung (Hinweis-Kasten zu OneDrive/FSLogix) | Bestätigt: FSLogix ist die vorgegebene, Azure-unabhängige Variante mit voller Punktzahl |
| Fehlersuche, warum die FSLogix-GPO nicht angewendet wurde | Ich habe die `gpresult`-Ausgabe analysieren lassen, um herauszufinden, warum die GPO trotz korrekter Konfiguration nicht in der Liste der angewendeten Objekte erschien | Direkter Vergleich der Security-Filterung (Benutzergruppe vs. Computerkonto) gegen die tatsächliche `gpresult`-Ausgabe vor und nach der Korrektur | Ursache gefunden und behoben: Computer-Configuration-GPOs brauchen eine Security-Filterung auf Computerkonten/Authenticated Users, nicht auf Benutzergruppen |

### Reflexion

1. **Wo hat die KI geholfen?** Bei der schnellen Eingrenzung des GPO-Anwendungsproblems: die KI hat aus der `gpresult`-Ausgabe sofort erkannt, dass das Computerkonto `CLIENT01$` nicht Mitglied der als Security-Filter verwendeten Benutzergruppe war, und den Zusammenhang zwischen Computer-Configuration und Computer-basierter Filterung erklärt.
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Die KI ging zunächst unhinterfragt von einem bestimmten lokalen Freigabepfad (`C:\Daten\Software`) und einer Beispiel-OU-Struktur aus, die sich beide als leicht abweichend vom tatsächlichen Repo-Stand herausstellten. Das wurde durch tatsächliches Ausführen der Befehle und Abgleich der Fehlermeldungen bemerkt, nicht durch die KI selbst erkannt.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 11](./README.md)

</div>
