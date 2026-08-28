<div align="center">

# Auftrag 03: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-brightgreen?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-1-1f6feb?style=flat)

**📖 [Wie KI in diesem Projekt eingesetzt wird](../ki-einsatz.md)**

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Anleitung für Forest-Erstellung, DNS-Konfiguration, AD Recycle Bin, Client-Beitritt und RDP-Konzept erstellen | "Mach die Anleitung für Auftrag 03" | Jeden Schritt einzeln in PowerShell ausgeführt, Ergebnisse (Fehler, Outputs, Screenshots) zurückgemeldet und von der KI auswerten lassen, bei Fehlern (z. B. PTR-Record in falscher Zone, RDP-Gruppe auf DC nicht gefunden) gezielt nachgefragt und korrigiert, RDP-Konzept mit zwei Testbenutzern selbst durchgetestet | Domäne `ad.contoso.com` erstellt, DNS vollständig konfiguriert und getestet, AD Recycle Bin aktiv, beide Clients der Domäne beigetreten, RDP-Konzept mit zwei AD-Gruppen umgesetzt und erfolgreich verifiziert |

### Reflexion

1. **Wo hat die KI geholfen?** Beim strukturierten Vorgehen in kleinen, nachvollziehbaren Schritten und beim schnellen Eingrenzen von Fehlerursachen (z. B. Kerberos-Zeitabweichung als möglicher Grund bei fehlgeschlagenem Login, auch wenn es am Ende die falsche Ursache war).
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Der PTR-Record für Client01 wurde zuerst mit dem Befehl für die falsche Zone (die von DC01) vorgeschlagen, das ist erst aufgefallen, weil die Abfrage in der neuen Zone leer blieb, danach wurde es korrigiert.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 03](./README.md)

</div>
