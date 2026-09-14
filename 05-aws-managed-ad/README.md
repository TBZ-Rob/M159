<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 05: AWS Managed Microsoft AD (Variante B: Authentik)

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal) · Kompetenzfelder=58a6ff (blau, neutral)
-->

![Phase](https://img.shields.io/badge/Phase-Fertig-1b7f79?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-100%25-1b7f79?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-lightgrey?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8250df?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-B%2C%20C%2C%20G-58a6ff?style=flat)

</div>

---

> ℹ️ **Variante B gewählt statt AWS Managed AD.** Begründung siehe [entscheidungsprotokoll.md](./entscheidungsprotokoll.md). Authentik läuft auf einer eigenen, regulär bepreisten EC2-Instanz statt des teuren AWS-Managed-AD-Dienstes (ca. 18 Dollar pro Woche), das On-Prem-AD (`ad.contoso.com`) bleibt dabei die massgebliche Quelle.

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> Authentik als modernen Identity Provider auf einer eigenen EC2-Instanz einrichten, per LDAP Source mit dem On-Prem-AD synchronisieren und eine Anwendung per SSO anbinden, der Zugriff wird über eine AD-Gruppe gesteuert.

<br>

<h2 id="kernschritte"><font color="#8250df">Kernschritte</font></h2>

- Neue EC2-Instanz für Authentik erstellen, Installation gemäss offizieller Authentik-Dokumentation (Docker Compose).
- LDAP Source in Authentik einrichten, die AD-Benutzer und -Gruppen aus dem On-Prem-AD synchronisiert.
- Eigenes Bind-Konto mit least-privilege-Rechten für die LDAP-Anbindung erstellen (kein Domain Admin), Begründung dokumentieren.
- Anbindung über LDAPS mit Zertifikat statt Klartext-LDAP absichern, Notwendigkeit dokumentieren (LDAP-Signing ist ab Server 2025 verbindlich).
- Login mit einem bestehenden AD-Konto testen, Prüfung erfolgt dabei gegen den DC.
- Eine Anwendung per OIDC/SAML oder Proxy mit funktionierendem SSO anbinden, Zugriff über eine AD-Gruppe steuern.

<br>

<h2 id="stand-der-umsetzung"><font color="#8250df">Stand der Umsetzung</font></h2>

> Auftrag ist abgeschlossen.

**Bereits umgesetzt:**

- Neue EC2-Instanz `Authentik01` (Ubuntu, gleiches privates Subnetz wie DC01) erstellt, Authentik läuft per Docker Compose (`ghcr.io/goauthentik/server:2026.8.2`) mit den Containern `authentik-server-1`, `authentik-worker-1`, `authentik-postgresql-1`.
- DNS-Auflösung von Authentik01 zu DC01 über einen zusätzlichen Nameserver-Eintrag in Netplan sichergestellt.
- LDAP Source in Authentik eingerichtet, verbunden über `ldaps://dc01.ad.contoso.com:636` statt Klartext-LDAP. Erster Sync erfolgreich, Benutzerobjekte kommen an.
- Dediziertes Least-privilege-Bind-Konto für die LDAP-Anbindung in AD angelegt (kein Domain Admin), hinterlegt in Authentik als Bind-Passwort der LDAP Source.
- LDAPS mit selbstsigniertem Zertifikat auf DC01 eingerichtet: AD DS bringt standardmässig kein LDAPS-Zertifikat mit, das Zertifikat musste manuell erstellt und zusätzlich in den lokalen Trusted-Root-Store importiert werden, damit AD DS es akzeptiert. Notwendigkeit: LDAP-Signing ist ab Windows Server 2025 verbindlich, ausserdem verhindert LDAPS, dass die Bind-Credentials im Klartext über das Netzwerk übertragen werden.
- Login-Test mit echtem AD-Konto (`anna.muster`) erfolgreich, Passwortprüfung erfolgt live gegen den DC.
- Proxy Provider und Application ("Windows Admin Center") in Authentik eingerichtet, um WAC per SSO vorzuschalten.
- AD-Sicherheitsgruppe `SSO-WAC-Users` erstellt, aktuell einziges Mitglied `anna.muster`, bewusst nicht `peter.keller` (vorgesehen für einen späteren Negativtest).
- AD-Gruppen-Sync repariert und verifiziert: Ursache war ein zweites, unauffälliges Fehlkonfigurations-Problem (das Active-Directory-Mapping `sAMAccountName`, das das reine User-Feld `username` setzt, war zusätzlich zu den bereits behobenen Mappings in der Gruppen-Mapping-Liste hinterlegt). Nach Entfernen dieses Mappings aus den Gruppen-Property-Mappings synchronisieren jetzt alle 71 AD-Gruppen korrekt, inklusive `SSO-WAC-Users`.
- `SSO-WAC-Users` per Policy/Group-Bindung an die Application "Windows Admin Center" gebunden.
- Zugriffssteuerung zunächst über Authentiks Policy-Engine direkt verifiziert (`anna.muster` erlaubt, `peter.keller` verweigert), danach echten Bug gefunden: die WAC-Proxy-Application war keinem Outpost zugewiesen (`authentik Embedded Outpost` hatte eine leere Provider-Liste), wodurch nie tatsächlich zu WAC durchgeleitet wurde und jeder gültige AD-Benutzer nur bei Authentik selbst landete, ohne dass die Gruppenprüfung überhaupt griff. Nach Zuweisung des Providers zum Embedded Outpost greift die Prüfung jetzt tatsächlich am Proxy.
- Zwei zusätzliche Netzwerk-Fixes für den funktionierenden Proxy-Pfad: Security Group `Authentik-SG` um eine Inbound-Regel für Port 9443 (HTTPS, Quelle `10.0.0.0/16`) ergänzt; Security Group von AdminCenter01 um eine Inbound-Regel für Port 443 (Quelle Authentik01-Subnetz `10.0.128.0/20`) ergänzt, da der Proxy sonst den WAC-Backend-Host nicht erreichen konnte.
- DNS-Auflösung von Authentik01 zu `admincenter01.ad.contoso.com` gefixt (gleiches Muster wie beim DC01-Fix): der AWS-VPC-Resolver beantwortete Anfragen für `contoso.com` autoritativ mit NXDOMAIN, weil dies zufällig eine echte, öffentliche Domain ist (Azure DNS), noch bevor DC01 gefragt wurde. Ein Versuch, dies sauber über eine systemd-resolved Routing-Domain zu lösen, wurde verworfen (hätte die generelle Internet-DNS-Auflösung auf dem Server riskiert), stattdessen analog zu DC01 ein statischer `/etc/hosts`-Eintrag gesetzt.
- **End-to-End-Test im Browser erfolgreich:** `anna.muster` gelangt über `https://10.0.140.253:9443` bis zur WAC-Oberfläche, `peter.keller` wird von Authentik mit "Permission denied" abgewiesen, bevor WAC überhaupt sichtbar wird.

<img src="./00-screenshots/01-login-anna-muster-wac.png" width="700" alt="Login anna.muster gelangt zu WAC">

*`anna.muster` ist Mitglied von `SSO-WAC-Users`, Authentik leitet nach dem Login zur Sign-in-Seite von Windows Admin Center weiter.*

<img src="./00-screenshots/02-login-peter-keller-verweigert.png" width="700" alt="Login peter.keller verweigert">

*`peter.keller` ist nicht Mitglied von `SSO-WAC-Users`, Authentik zeigt "Permission denied" und lässt ihn nicht bis WAC durch.*

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [x] Auftrag gestartet
- [x] EC2-Instanz für Authentik erstellt und läuft
- [x] LDAP Source eingerichtet, AD-Benutzer und -Gruppen synchronisiert (71 Gruppen, 22 Benutzer, verifiziert direkt in der Datenbank)
- [x] Login mit AD-Konto nachgewiesen (Prüfung gegen den DC)
- [x] LDAPS mit Zertifikat eingerichtet, Notwendigkeit dokumentiert
- [x] Least-privilege Bind-Konto verwendet und begründet
- [x] Anwendung per SSO angebunden, Zugriff über AD-Gruppe gesteuert (Gruppen-Bindung erstellt, End-to-End-Test im Browser erfolgreich)
- [x] Umsetzung abgeschlossen
- [x] Screenshots/Nachweise abgelegt
- [x] `ki-log.md` ausgefüllt
- [x] `entscheidungsprotokoll.md` ausgefüllt (Variante A vs. B)

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [entscheidungsprotokoll.md](./entscheidungsprotokoll.md) | Begründung Variante B statt AWS Managed AD |
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/05-aws-managed-microsoft-ad/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/05-aws-managed-microsoft-ad/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 04: Freigaben, Laufwerke, Berechtigungen](../04-freigaben-berechtigungen/README.md) · 🏠 [Übersicht](../README.md) · ➡️ [Auftrag 06: RSAT & Admin Center V2](../06-rsat-admin-center/README.md)

</div>
