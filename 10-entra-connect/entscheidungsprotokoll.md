<div align="center">

# Entscheidungsprotokoll: Auftrag 10

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)

</div>

---

### Entscheid: Eigene UPN-Domain vs. Standard-Tenant-Domain für synchronisierte Benutzer

**Welche Optionen standen zur Wahl?**

_Option A: eine eigene, öffentliche Domain kaufen und im Tenant verifizieren, damit synchronisierte Benutzer eine saubere, produktionsnahe UPN wie `vorname.nachname@contoso-robin.ch` erhalten. Option B: die bereits vorhandene `ad.contoso.com` als UPN-Suffix verwenden, das scheitert aber daran, dass `contoso.com` eine echte, fremde öffentliche Domain mit eigenem DNS ist und sich im eigenen Tenant nicht verifizieren lässt. Option C: keine eigene Domain, synchronisierte Benutzer bleiben unter der automatisch vergebenen Standard-Domain des Tenants (`robinnydeggertbzoutlook.onmicrosoft.com`), mit "Continue without matching all UPN suffixes to verified domains" im Entra-Connect-Installer._

**Wofür habe ich mich entschieden?**

_Für Option C (Standard-Tenant-Domain, keine eigene Domain)._

**Warum, und was sprach dagegen?**

_Eine eigene Domain zu kaufen wäre der einzige Weg zu einer produktionsnahen UPN gewesen, verursacht aber laufende Kosten für ein reines Schulprojekt ohne echten Adressbedarf, und Robin besitzt keine passende Domain, die sich kostenlos hätte verifizieren lassen. Option B (bestehende `ad.contoso.com`) scheidet technisch aus: die Domain gehört nicht Robin, eine Verifizierung im eigenen Tenant ist nicht möglich. Option C erfüllt die eigentliche fachliche Anforderung des Auftrags vollständig: Password Hash Synchronization, Benutzersynchronisation und Hybrid Join funktionieren unabhängig vom UPN-Domain-Namen, geprüft und bestätigt (`dsregcmd /status`, `AzureAdJoined: YES`). Der einzige Nachteil ist rein kosmetisch, die UPN sieht nicht so aus wie in einem echten Firmensetup, das ist für den mündlichen Nachweis klar als bewusste, kostenbedingte Design-Entscheidung zu benennen, nicht als Lücke._

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 10](./README.md)

</div>
