<div align="center">

# Auftrag 13: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-3-8250df?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Aufbau der Flask-OAuth-App | "Bereite Auftrag 13 vor: Entra-ID-App-Registration und Flask-Code fuer die drei SSO-Testszenarien" | Code gegen die offizielle Aufgabenstellung (Routen-Namen `/getAToken`, `localhost:5000` statt `127.0.0.1`) und gegen Authlib-Dokumentation abgeglichen | App Registration und `app.py` erfolgreich erstellt, unabhaengig von AWS (waehrend AWS-Wartungsunterbruch), erster Start auf Client01 ohne Codeaenderung erfolgreich |
| Ursachenanalyse Prozessabbruch beim Hintergrundstart | Flask-Prozess verschwand jedes Mal sofort nach Start per `Start-Process`/Scheduled Task, Logs blieben leer | Synchronen Testlauf mit kurzem Timeout gemacht, dabei bestaetigt dass der Prozess an sich fehlerfrei laeuft (durch Timeout, nicht Absturz beendet), Ursache dann auf Windows-OpenSSH-Job-Object-Verhalten bei Sitzungsende eingegrenzt | SSH-Verbindung bewusst dauerhaft offengehalten statt Hintergrund-Trick, Flask-Prozess blieb waehrend der gesamten Testphase erreichbar |
| Einordnung des Testergebnisses (alle 3 Szenarien ohne Prompt) | Nutzer bestaetigte: bei allen drei Tests nur Login/Logout geklickt, nirgends ein Passwort-Prompt | Rueckfrage gestellt, ob das am Vorhandensein einer bereits bestehenden Browser-Session lag statt das unkommentiert als "SSO funktioniert ueberall gleich gut" zu dokumentieren | Bestaetigt: Chrome hatte bereits eine gueltige Microsoft-Session aus vorherigem Arbeiten in der RDP-Sitzung, dadurch verhielten sich Test 1 und Test 2 technisch identisch (beide token-basiertes SSO), nur Test 3 (Edge/Kerberos-WIA) ist der eigentliche Nachweis fuer geraetebasiertes SSO |

### Reflexion

1. **Wo hat die KI geholfen?**

Beim schnellen Eingrenzen des Prozessabbruch-Problems (SSH-Job-Object-Verhalten von Windows), das auf den ersten Blick wie ein Absturz der Flask-App aussah, aber tatsaechlich ein reines Session-Handling-Problem war. Ausserdem beim kritischen Nachfragen zum Testergebnis: statt die Aussage "lief ueberall ohne Prompt" unreflektiert als vollstaendigen Erfolg aller drei unterschiedlichen SSO-Mechanismen zu dokumentieren, wurde gezielt nachgefragt, warum das so war, was den eigentlich relevanten Unterschied (Browser-Session-SSO vs. geraetebasiertes Kerberos/WIA-SSO) sichtbar gemacht hat.

2. **Wo lag sie falsch, und wie habe ich es gemerkt?**

Beim Versuch, einen von Google Drive heruntergeladenen Screenshot direkt ins Repo zu uebernehmen, wurde die sehr lange Base64-Zeichenkette beim Kopieren zwischen Tool-Aufrufen wiederholt fehlerhaft uebertragen (unterschiedliche, falsche Dateigroessen bei mehreren Versuchen), das PNG war danach jedes Mal beschaedigt. Erkannt durch `file`/PIL-Validierung nach dem Dekodieren, die "broken data stream" meldete. Statt es ohne Erfolgskontrolle einfach zu committen, wurde stattdessen ein zuverlässigerer Weg gesucht (Video per SCP direkt vom Client statt per Drive-Download).

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 13](./README.md)

</div>
