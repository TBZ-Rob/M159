<div align="center">

# 📁 Auftrag 04: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-2-1f6feb?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Anleitung für Gruppen, Freigaben, NTFS-Berechtigungen (icacls), ABE und Testszenarien erstellen | "Mach die Anleitung für Auftrag 04, ich schicke dir die Berechtigungstabelle als Screenshot" | Jede `icacls`-Ausgabe nach dem Setzen kontrolliert, die drei geforderten Testszenarien tatsächlich über RDP mit echten Testbenutzern durchgeführt statt nur simuliert, dabei einen Fehler in der Matrix-Übertragung (fehlende Rechte bei Buchhaltung) selbst entdeckt | Acht Abteilungsgruppen, acht Testbenutzer, fünf Freigaben mit vollständiger NTFS-Matrix und ABE umgesetzt, alle drei Tests erfolgreich verifiziert |
| AGDLP Group Nesting für mindestens zwei Abteilungen umsetzen, inklusive Auswahlbegründung und Visualisierung | "Welche zwei Abteilungen würden sich realistisch für AGDLP eignen, und setze das um" | Auswahl anhand der Matrix selbst begründet (Buchhaltung und Sekretariat sind die einzigen Ordner mit echtem Mehrfach-Lesezugriff durch andere Abteilungen), Domain-Local-Gruppen erstellt, globale Gruppen verschachtelt, NTFS-Rechte umgehängt und Test 1 aus Schritt 4 erneut erfolgreich durchgeführt, um zu bestätigen, dass sich am effektiven Zugriff nichts geändert hat | Vier neue Domain-Local-Gruppen (`DL-Buchhaltung-Modify/Read`, `DL-Sekretariat-Modify/Read`), NTFS-Rechte auf Buchhaltung und Sekretariat laufen jetzt über AGDLP statt direkter Vergabe, Mermaid-Diagramm zur Visualisierung im README |

### Reflexion

1. **Wo hat die KI geholfen?** Beim systematischen Übertragen der Berechtigungsmatrix in konkrete `icacls`-Befehle, das wäre von Hand fehleranfälliger und langsamer gewesen bei 8 Abteilungen und 8 Unterordnern.
2. **Wo lag sie falsch, und wie habe ich es gemerkt?** Beim Ablesen der Berechtigungsmatrix aus dem Screenshot hat die KI eine Zeile falsch übertragen (Sekretariat und Aussendienst fehlten bei den Leserechten auf `Buchhaltung`), das ist erst beim tatsächlichen Testzugriff aufgefallen (Ordner war für Sekretariat nicht sichtbar), danach korrigiert und erneut getestet.
3. **Wie wurde die Abteilungsauswahl für AGDLP begründet?** Die KI hat nicht einfach zwei beliebige Abteilungen vorgeschlagen, sondern anhand der bereits umgesetzten Matrix selbst hergeleitet, welche Ordner echten Mehrfach-Lesezugriff durch andere Abteilungen haben, das war nachvollziehbar und musste nicht separat verifiziert werden, da die Matrix bereits bekannt und getestet war.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 04](./README.md)

</div>
