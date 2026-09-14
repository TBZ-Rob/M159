<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 10: MS Entra ID & MS Entra Connect

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal) · Kompetenzfelder=58a6ff (blau, neutral)
-->

![Phase](https://img.shields.io/badge/Phase-Blockiert-lightgrey?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-0%25-lightgrey?style=flat)
![Block](https://img.shields.io/badge/Block-2%20Cloud%20Integration-lightgrey?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Offen-lightgrey?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-G%2C%20B-58a6ff?style=flat)

</div>

---

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> _Noch zu ergänzen, sobald der Auftrag gestartet wird._

<br>

<h2 id="blocker"><font color="#8250df">Aktueller Blocker: eigener Azure-Tenant</font></h2>

> Auftrag 10 kann inhaltlich erst starten, sobald ein eigener, nicht TBZ-verwalteter Azure/Entra-Tenant mit Admin-Rechten existiert. Der TBZ-Schul-Account (`robin.nydegger@edu.tbz.ch`, aktiviert in Auftrag 01) hat zwar aktives Azure-for-Students-Guthaben, läuft aber im organisationsverwalteten Tenant `TBZ.CH`, dort keine Admin-Rechte auf Microsoft Entra ID (Fehler 401 "Insufficient privileges"). Fuer Entra Connect wird zwingend Global-Admin-Zugriff auf einen eigenen Tenant benötigt.

**Bisher unternommene Versuche (Stand 14.09.2026), alle bisher ohne eigenen nutzbaren Tenant:**

1. Neues Konto mit TBZ-Mail fuer Azure for Students verifiziert: Fehler "no active sponsorship" auf der separaten Balance-Seite. Vermutlich ein reiner Anzeige-Bug (siehe Punkt 2), aber dadurch fälschlich als Fehlschlag interpretiert.
2. Erneuter Verifizierungsversuch (vermutlich wieder mit derselben Mail): Fehler "This email account has already been used for verification this year." SheerID (Microsofts Verifizierungs-Backend) sperrt eine Mail-Adresse 12 Monate lang nach dem ersten Versuch, auch wenn dieser fehlgeschlagen wirkte. Kein Self-Service-Reset möglich, nur ueber Microsoft Support.
3. GitHub Student Developer Pack als Alternativweg probiert: GitHub verlangt fuer TBZ zwingend eine `@giacal.ch`-Mailadresse (offenbar eine fehlerhafte/veraltete Eintragung in GitHubs Schul-Datenbank, TBZ nutzt eigentlich `edu.tbz.ch`). `robin.nydegger@giacal.ch` wurde testweise zum GitHub-Account hinzugefügt, aber keine Bestätigungsmail erhalten, es existiert vermutlich gar kein Postfach fuer diese Domain.
4. Login-Check im Azure-Portal mit dem ersten neu erstellten Account (fuer diesen Auftrag, nicht der TBZ-Account) bestätigt: kein eigenes Entra-ID-Verzeichnis vorhanden, Azure-for-Students-Aktivierung ist bei diesem Account nie durchgelaufen. Beim Versuch, Microsoft Entra ID zu öffnen: Fehler "Selected user account does not exist in tenant 'Microsoft Services' ... The account needs to be added as an external user in the tenant first."

**Empfohlener nächster Schritt:** Ein komplett neues Konto mit einer privaten, nicht-TBZ-Mail-Adresse (z. B. Gmail) anlegen. Das Modul-Wissen selbst empfiehlt das explizit ("Freischaltung mit nicht TBZ E-Mail empfohlen"). Bei der Studierendenverifizierung direkt die Dokumenten-Upload-Option probieren (Lehrvertrag/Ausweis), statt E-Mail- oder GitHub-Verifizierung, das umgeht sowohl die TBZ-Mail-Sperre als auch das GitHub-Domain-Problem. Alternativ: Microsoft Support kontaktieren, um die Sperre auf der bereits verwendeten Mail zurücksetzen zu lassen (langsamer).

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [ ] Auftrag gestartet
- [ ] Umsetzung abgeschlossen
- [ ] Screenshots/Nachweise abgelegt
- [ ] `ki-log.md` ausgefüllt

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [entscheidungsprotokoll.md](./entscheidungsprotokoll.md) | Begründung des Entscheids in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/10-ms-entra-id-ms-entra-connect/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/10-ms-entra-id-ms-entra-connect/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 09: Identity Management & PowerShell Debugging](../09-identity-mgmt-powershell/README.md) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 11: Servergespeicherte Benutzerprofile](../11-benutzerprofil/README.md)

</div>
