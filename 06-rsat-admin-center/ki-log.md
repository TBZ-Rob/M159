<div align="center">

# Auftrag 06: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-3-8250df?style=flat)

**📖 [Wie KI in diesem Projekt eingesetzt wird](../00-files/ki-einsatz.md)**

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| RSAT- und Windows-Admin-Center-Stand verifizieren, GUI-Anleitung für die fehlenden Schritte | "Machen wir Auftrag 06 jetzt, gib mir konkrete Anleitung" | `Get-WindowsFeature RSAT-AD*`-Ausgabe und WAC-About-Dialog jeweils per Screenshot geprüft, bevor als erledigt markiert | RSAT-AD-Tools vollständig installiert bestätigt (Nebenprodukt aus Auftrag 08), WAC-Version 2606/Build 2.7.5.21 (Gateway-Modus V2) bestätigt |
| DC01-Verbindung im Admin Center verifizieren, WinRM-Security-Group-Regeln einschränken | "Was soll ich ändern" (zu den Security-Group-Regeln) | Vorher/Nachher-Screenshot der Inbound Rules verglichen, danach DC01-Overview im Admin Center neu geladen um zu bestätigen, dass Zugriff trotz Einschränkung noch funktioniert | Ports 5985/5986 von `10.0.0.0/16` (ganzes VPC) auf `10.0.0.30/32` (nur AdminCenter01) eingeschränkt, Verbindung weiterhin funktionsfähig |
| Externe Erreichbarkeit über Authentik SSO nachweisen, inkl. Gegentest mit nicht berechtigtem Benutzer | "Zeig mir die Authentik-SSO-URL für WAC" | Screenshot-Kette geprüft: erst nur Authentik-Dashboard (Zugriffskontrolle sichtbar), fehlenden Schritt (Klick auf WAC-Kachel) selbst bemängelt und nachgefordert, bevor als vollständig akzeptiert | URL `https://10.0.140.253:9443` ermittelt, Zugriff von Client01 aus bestätigt: anna.muster (SSO-WAC-Users) kommt bis zur WAC-Login-Seite, peter.keller sieht die Anwendung gar nicht erst |

### Reflexion

1. **Wo hat die KI geholfen?** Beim schrittweisen Vorgehen ohne alles auf einmal zu erklären, jeder Schritt einzeln mit GUI-Anleitung und Kontrolle des Screenshots, bevor es weiterging. Dadurch fiel auf, dass ein Nachweis unvollständig war (SSO-Test zeigte zunächst nur die Zugriffsliste, nicht den tatsächlichen Durchgriff bis zur WAC-Seite), das wurde direkt nachgefordert statt übersehen.
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Die KI konnte nicht selbst prüfen, von welcher Maschine (AdminCenter01 oder Client01) ein Screenshot stammt, das mussten explizite Rückfragen klären. Ohne diese Rückfrage wäre der Aussen-Erreichbarkeits-Nachweis möglicherweise fälschlich von einer bereits internen Sitzung aus akzeptiert worden.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 06](./README.md)

</div>
