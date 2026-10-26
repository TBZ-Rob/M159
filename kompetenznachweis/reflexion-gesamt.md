<div align="center">

# Gesamt-Reflexion

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)

</div>

---

Rückblick über den gesamten Lernprozess von Auftrag 01 (18.08.2026) bis zum Abschluss aller 13 Aufträge, Umgang mit KI, grösste Learnings.

<h2 id="umgang-mit-ki"><font color="#8250df">Umgang mit KI</font></h2>

KI kam in praktisch jedem Auftrag zum Einsatz, dokumentiert jeweils im `ki-log.md` des Auftrags (siehe [ki-einsatz.md](../00-files/ki-einsatz.md) für den verbindlichen Rahmen). Am meisten geholfen hat KI bei drei wiederkehrenden Aufgaben: beim Strukturieren und einheitlichen Formatieren der Dokumentation über alle 13 Aufträge hinweg (damit README, ki-log und Entscheidungsprotokoll immer demselben Schema folgen, auch nach Wochen Pause), beim schnellen Einordnen unbekannter Fehlermeldungen (zum Beispiel `AADSTS50020` bei Auftrag 10 oder die MSAL-Assembly-Kollision bei Auftrag 12), und beim Gegenlesen von Begründungstexten (Entscheidungsprotokolle, Firewall-Konfigurationsblatt) auf Vollständigkeit und Klarheit. Falsch lag die KI selten grundlegend, aber wiederholt bei Details, die sich erst beim tatsächlichen Testen zeigten, zum Beispiel bei der Annahme, eine GUI-Änderung an einer GPO werde automatisch sofort wirksam, obwohl mehrfach (Auftrag 07, Auftrag 08) ein AD-interner Versionsabgleich zwischen `gpt.ini` und `versionNumber` hakte und zusätzlich manuell behoben werden musste. Jede KI-gestützte technische Behauptung wurde deshalb nach Möglichkeit am System selbst verifiziert (Screenshot, Terminal-Ausgabe), nicht blind übernommen, das zieht sich durch alle Aufträge als feste Regel.

<br>

<h2 id="groesste-learnings"><font color="#8250df">Grösste Learnings</font></h2>

**Fachlich:** Das Konzept, das am meisten Aha-Momente brachte, war die Kombination aus AGDLP (Auftrag 04) und transitiver Gruppenauflösung per `LDAP_MATCHING_RULE_IN_CHAIN` (Auftrag 08), weil beide dasselbe Grundproblem (Berechtigungen wachsen nicht linear mit der Anzahl Gruppen/Abteilungen) aus zwei verschiedenen Richtungen lösen, einmal strukturell über Gruppenverschachtelung, einmal abfragetechnisch über eine LDAP-Vergleichsregel. Ebenso lehrreich war, wie oft ein und dasselbe zugrunde liegende Problem in verschiedenen Aufträgen in neuer Verkleidung wieder auftauchte: der AD-interne Versionsabgleich zwischen SYSVOL und `versionNumber` sorgte gleich dreimal (Passwortrichtlinie, Druckerverteilung in Auftrag 07, LDAP-Query-Targeting in Auftrag 08) für denselben Fehlerklasse "Änderung liegt korrekt vor, wird aber nicht erkannt", was zeigt, wie wichtig es ist, bei scheinbar unterschiedlichen Symptomen zuerst auf bereits bekannte Fehlerklassen zu prüfen, statt jedes Mal bei null anzufangen.

**Technisch/betrieblich:** Die grösste wiederkehrende Stolperquelle war nicht AD selbst, sondern die Umgebung drumherum: Windows-OpenSSH terminiert Hintergrundprozesse beim Schliessen der Session (betraf Auftrag 13), Azure-for-Students-Subscriptions haben eine feste, nicht dokumentierte Regionen-Whitelist (Auftrag 12), und vorinstallierte AWS-Module kollidieren mit frisch installierten Azure-Modulen (Auftrag 12). Keines dieser Probleme stand in der Aufgabenstellung, alle kosteten überproportional viel Zeit im Verhältnis zur eigentlichen fachlichen Aufgabe. Das grösste Learning daraus: früh und bewusst Zeit für Cloud-Bereitschaft und Infrastruktur-Eigenheiten einplanen, nicht erst wenn der fachliche Teil ansteht, genau das wurde in Auftrag 01 vorausschauend als eigener Prüfschritt eingebaut und hat sich ausgezahlt (der Azure-Tenant-Blocker vor Auftrag 10 wurde dadurch früh erkannt, nicht erst mitten in Auftrag 10 entdeckt).

**Organisatorisch:** Die bewusste Verschiebung von Auftrag 05/06 ans Ende und der Wechsel auf Variante B (Authentik statt AWS Managed AD) war die wichtigste Einzelentscheidung des ganzen Projekts für die Kostenkontrolle, hat aber letztlich das Guthaben nur aufgeschoben, nicht verhindert: das AWS-Guthaben war direkt nach Abschluss von Auftrag 06 vollständig aufgebraucht (51.96 von 50 Dollar). Rückblickend wäre ein noch früherer, kontinuierlicher Blick aufs verbleibende Guthaben sinnvoll gewesen, statt es erst bei Auftrag 02 und erneut bei Auftrag 06 konkret zum Thema zu machen, dann hätten die zwei offen gebliebenen Nachweis-Lücken (Desktop-/Tastatureinstellungen in Auftrag 02, `dsregcmd`-Beleg in Auftrag 12) vermutlich vermieden werden können.

<br>

<h2 id="bekannte-luecken"><font color="#8250df">Bekannte, bewusst offen gelassene Lücken</font></h2>

Ehrlich benannt statt verschwiegen, für die Schlussbesprechung:

- **Auftrag 02:** Desktop-/Tastatureinstellungen nicht einzeln mit Screenshot belegt, AWS-Guthaben war zum Zeitpunkt des Nachtragens bereits aufgebraucht.
- **Auftrag 12:** kein separater `dsregcmd /status`-Beleg in diesem Auftragsordner, inhaltlich aber bereits über Auftrag 10 (gleiches Gerät, gleicher Zustand) nachgewiesen.
- **Auftrag 13:** Screenshots zu Test 2 (Chrome, token-basiertes SSO) und Test 3 (Edge, Kerberos/WIA) fehlen einzeln, Test 3 ist aber per Video vollständig belegt.
- **Kompetenzfeld F (LDIF):** durch keinen Auftrag praktisch abgedeckt, das Feld kommt auch in keinem der 13 offiziellen Fragenkataloge vor, siehe [Hinweis in der Fragenkatalog-Vorbereitung](./fragenkatalog-vorbereitung.md#kompetenzfeld-f-ldif) für eine konzeptionelle Reserve-Antwort.

Alle vier Lücken sind durch das Ende des AWS-Guthabens entstanden und lassen sich mit der aktuellen Infrastruktur nicht mehr nachträglich schliessen, sie sind deshalb nicht Aufgabenstellung-, sondern budgetbedingt.

<br>

<div align="center">

⬅️ [Zurück zur Übersicht](../README.md)

</div>
