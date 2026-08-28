<div align="center">

# Entscheidungsprotokoll: Auftrag 05

![Phase](https://img.shields.io/badge/Phase-Offen-lightgrey?style=flat)

</div>

---

### Entscheid: AWS Managed AD (Variante A) vs. Authentik als moderner IdP (Variante B)

**Welche Optionen standen zur Wahl?**

_Variante A: AWS Managed Microsoft AD mit beidseitigem Trust zum On-Prem-AD, wie ursprünglich in der Auftragsstellung beschrieben, kostet ca. 18 Dollar pro Woche während der Laufzeit. Variante B: Authentik als moderner Identity Provider auf einer eigenen, regulär bepreisten EC2-Instanz, angebunden per LDAP Source ans On-Prem-AD, mit SSO für eine Anwendung._

**Wofür habe ich mich entschieden?**

_Für Variante B (Authentik)._

**Warum, und was sprach dagegen?**

_Variante B deckt laut Kompetenzmatrix zusätzlich das Feld C (LDAP als Protokoll) ab und spart die laufenden Kosten des AWS-Managed-AD-Dienstes, eine reguläre EC2-Instanz ist deutlich günstiger. Ausserdem zeigt Variante B den Kontrast zwischen einem klassischen AD-Trust und einer modernen Föderationslösung, wie sie in der Praxis zunehmend eingesetzt wird. Dagegen spricht, dass Variante A näher an der ursprünglichen Modulaufgabe liegt und den klassischen Trust-Mechanismus direkt übt, der in vielen bestehenden Unternehmensumgebungen noch die Realität ist._

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 05](./README.md)

</div>
