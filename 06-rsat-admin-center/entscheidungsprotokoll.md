<div align="center">

# Entscheidungsprotokoll: Auftrag 06

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)

</div>

---

### Entscheid: Bestehende Infrastruktur wiederverwenden statt Aufgabenstellung wörtlich umzusetzen

**Welche Optionen standen zur Wahl?**

_Option A: die offizielle Aufgabenstellung wörtlich umsetzen, das setzt eine neue EC2-Client-Instanz innerhalb eines echten AWS-Managed-Microsoft-AD-Verzeichnisses voraus, inklusive eigener Subnetz-Entscheidung (public/private), gegebenenfalls NAT-Gateway für Internetzugriff, und einen dort neu installierten Windows Admin Center. Option B: die bereits bestehende Infrastruktur aus Auftrag 05 und Auftrag 08 (Variante B) weiterverwenden, AdminCenter01 hat Windows Admin Center bereits laufen (samt SSO-Proxy über Authentik), RSAT-AD-Tools waren dort für `ldp.exe` bereits installiert, DC01 ist der bestehende, selbstverwaltete Domain Controller._

**Wofür habe ich mich entschieden?**

_Für Option B (bestehende Infrastruktur wiederverwenden)._

**Warum, und was sprach dagegen?**

_Eine neue EC2-Instanz nur für diesen Auftrag hätte zusätzliche laufende Kosten verursacht, genau der Grund, aus dem 05 und 06 überhaupt ans Ende verschoben und in Variante B umgesetzt wurden (siehe [Auftrag 05](../05-aws-managed-ad/entscheidungsprotokoll.md)). Da in Variante B kein echter AWS-Managed-Microsoft-AD-Dienst existiert, entfällt auch das offizielle Konzept "EC2-AD-DC zum Admin Center hinzufügen" in seiner ursprünglichen Form, es gibt keinen separaten Managed-AD-DC, nur den einen selbstverwalteten DC01. Das fachliche Lernziel des Auftrags (RSAT-Verwaltungswerkzeuge, Windows Admin Center V2 mit einem Domain Controller verbinden, WinRM-Zugriff einschränken, sichere externe Erreichbarkeit) wird durch die bestehende Infrastruktur vollständig erreicht, nur eben mit dem einen vorhandenen DC01 statt einem zusätzlichen Managed-AD-DC. Dagegen spricht, dass diese Interpretation weiter von der ursprünglichen Aufgabenstellung abweicht als bei den meisten anderen Aufträgen, das ist für den mündlichen Nachweis explizit zu benennen und zu begründen, nicht zu verschweigen._

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 06](./README.md)

</div>
