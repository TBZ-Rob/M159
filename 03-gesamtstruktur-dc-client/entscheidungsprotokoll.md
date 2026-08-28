<div align="center">

# Entscheidungsprotokoll: Auftrag 03

![Phase](https://img.shields.io/badge/Phase-Erledigt-brightgreen?style=flat)

</div>

---

### Entscheid: RDP-Konzept

**Welche Optionen standen zur Wahl?**

_Option A: Eine Gruppe `RDP-Admins` mit Zugriff auf alle Server (DC01, Client01, AdminCenter01), eine Gruppe `RDP-Users` nur mit Zugriff auf die Client-Rechner, nicht auf DC01. Option B: `RDP-Admins` überall, `RDP-Users` nirgends, also nur Admins erhalten überhaupt Fernzugriff._

**Wofür habe ich mich entschieden?**

_Für Option A: `RDP-Admins` mit Zugriff auf alle drei Server, `RDP-Users` nur auf Client01 und AdminCenter01, nicht auf DC01._

**Warum, und was sprach dagegen?**

_Normale Benutzer haben in der Praxis meist einen legitimen Grund, sich auf einem Client-Rechner anzumelden, aber keinen, um direkt auf den Domain Controller zuzugreifen, das ist sensibler und sollte Admins vorbehalten bleiben. Option B wäre zwar noch strikter, hätte aber normale Benutzer komplett von jedem Fernzugriff ausgeschlossen, was am realen Alltag vorbeigeht und den Unterschied zwischen den beiden Gruppen weniger sichtbar gemacht hätte._

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 03](./README.md)

</div>
