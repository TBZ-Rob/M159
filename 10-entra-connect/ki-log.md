<div align="center">

# Auftrag 10: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Blockiert-lightgrey?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-2-8250df?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Ursachenanalyse Azure-for-Students-Verifizierungsfehler | "Ich bekomme 'This email account has already been used for verification this year', obwohl ich noch kein Konto habe. Was bedeutet das?" | Websuche zu offiziellen Microsoft-Q&A-Quellen zum SheerID-Verifizierungssystem | Ursache gefunden: SheerID sperrt eine Mail-Adresse 12 Monate nach dem ersten Verifizierungsversuch, auch bei einem scheinbaren Fehlschlag, kein Self-Service-Reset moeglich |
| Abgleich mit bereits dokumentiertem Wissen aus dem eigenen Vault | "Gibt es Infos, was beim allerersten Azure-Versuch verwendet wurde?" | Google-Drive-Vault und Repo (Auftrag 01, `cloud-readiness.md`, Modul-Wissen-Datei) durchsucht statt neu zu raten | Wichtiger Fund: der TBZ-Schul-Account hat zwar aktives Guthaben, laeuft aber im organisationsverwalteten Tenant `TBZ.CH` ohne Admin-Rechte, das Modul-Wissen empfiehlt explizit eine nicht-TBZ-Mail fuer Auftrag 10. Direkter Login-Check im Azure-Portal mit dem fuer diesen Auftrag erstellten Account bestaetigte zusaetzlich: kein eigenes Entra-ID-Verzeichnis vorhanden |

### Reflexion

1. **Wo hat die KI geholfen?**

Beim Einordnen mehrerer, auf den ersten Blick unzusammenhängender Fehlermeldungen (GitHub-Domain-Fehler, Azure-Verifizierungsfehler, Entra-ID-Zugriffsfehler) zu einem gemeinsamen Bild: Es handelt sich um zwei unabhängige Probleme (TBZ-Tenant ohne Adminrechte einerseits, gesperrte Verifizierungs-Mail andererseits), die leicht hätten vermischt werden können. Das gezielte Durchsuchen des eigenen Vaults und Repos statt neu zu raten brachte den entscheidenden Fund (TBZ-Account läuft im Schul-Tenant), der die ganze bisherige Fehlersuche in einen sinnvollen Kontext gesetzt hat.

2. **Wo lag sie falsch, und wie habe ich es gemerkt?**

Beim ersten Blick auf den "no active sponsorship"-Nebenbefund im Vault wurde dieser fälschlich als Beleg dafür interpretiert, dass ein bereits funktionierendes Konto für Auftrag 10 existiert, dabei bezog sich dieser Fund auf den TBZ-Account aus Auftrag 01, nicht auf den separaten, neuen Account-Versuch für Auftrag 10. Erst die Nutzerrückfrage ("das hast du falsch verstanden") deckte die Verwechslung auf. Zeigt: bei mehreren ähnlich klingenden Konten/Versuchen im selben Kontext muss die Quelle jeder Information genau geprüft werden, bevor sie als Antwort auf eine konkrete Frage verwendet wird.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 10](./README.md)

</div>
