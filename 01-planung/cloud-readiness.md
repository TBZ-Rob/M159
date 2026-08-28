<div align="center">

# Cloud-Bereitschaft: Nachweis

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)

</div>

---

Laut Modulvorgabe muss der Cloud-Zugang **bereits in Auftrag 01** geprüft werden, nicht erst später, da ein nicht funktionierender Tenant sonst Zeit kostet, die sich nicht mehr aufholen lässt.

| Schritt | Nachweis | Status |
|---|---|---|
| Azure for Students aktivieren | Screenshot der Bestätigung | ✅ erfolgreich |
| Entra-ID-Tenant aufrufen | Screenshot der Fehlermeldung | ⚠️ kein Zugriff (siehe unten) |

## Ergebnis

**Azure for Students**: erfolgreich aktiviert mit dem TBZ-Schul-Account (`robin.nydegger@edu.tbz.ch`). $100 von $100 Guthaben verfügbar, gültig 365 Tage (Ablauf 21.08.2027).

![Azure for Students aktiviert](./00-screenshots/01-azure-for-students.png)

**Entra-ID-Tenant**: der TBZ-Schul-Account läuft im organisationsverwalteten Tenant `TBZ.CH`. Der Aufruf von Microsoft Entra ID im Azure-Portal ergibt "You don't have access" (Fehlercode 401, "Insufficient privileges to complete the operation"), da Schüler-Accounts dort keine Admin-Rechte auf die Tenant-Übersicht haben.

![Entra-ID-Tenant kein Zugriff](./00-screenshots/02-entra-id-tenant.png)

## Bei Fehlschlag

Der Entra-ID-Zugriff ist wie oben dokumentiert fehlgeschlagen (kein Admin-Zugriff im TBZ-Tenant). Vorgehen:

1. Screenshot der Fehlermeldung ist oben abgelegt.
2. Für Auftrag 10 (Entra Connect) wird ein eigener, separater Entra-ID-Tenant benötigt, da im TBZ-Tenant keine Admin-Rechte bestehen. Das wird zu Beginn von Auftrag 10 konkret geklärt.
3. Azure for Students selbst ist unabhängig davon erfolgreich aktiviert und für die AWS-fremden Teile (falls benötigt) nutzbar.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 01](./README.md)

</div>
