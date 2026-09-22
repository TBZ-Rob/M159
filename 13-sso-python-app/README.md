<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 13: SSO Python App

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal) · Kompetenzfelder=58a6ff (blau, neutral)
-->

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-100%25-1b7f79?style=flat)
![Block](https://img.shields.io/badge/Block-2%20Cloud%20Integration-lightgrey?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8250df?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-B%2C%20C-58a6ff?style=flat)

**[Ziel](#ziel) · [Vorbereitung](#vorbereitung-erledigt) · [Umsetzung](#umsetzung-auf-client01) · [Nachweise](#nachweise) · [Checkliste](#checkliste)**

</div>

---

<h2 id="ziel"><font color="#8250df">Ziel</font></h2>

> Eine lokale Python-Flask-App bauen, die sich per OAuth2/OpenID Connect gegen Microsoft Entra ID authentifiziert (Single Sign-On). Die App wird in drei Szenarien getestet, um verschiedene SSO-Mechanismen zu zeigen: manueller Login, token-basiertes SSO ohne AD-Mitgliedschaft, und Kerberos/WIA-basiertes SSO auf einem hybrid-verbundenen Geraet. Ein Video ist Pflicht, da SSO per Printscreen schlecht nachweisbar ist ("man sieht", dass kein Passwort-Prompt erscheint).

<br>

<h2 id="vorbereitung-erledigt"><font color="#8250df">Vorbereitung (bereits erledigt)</font></h2>

**Entra ID App Registration** (per Azure CLI erstellt, unabhaengig von AWS, da rein Azure-seitig):

| Feld | Wert |
|---|---|
| App-Name | `M159-SSO-App` |
| Application (Client) ID | `aa711816-d496-44b3-8e40-50f1d7cc62aa` |
| Tenant ID | `ef4925a6-ccf7-4f72-932f-0bbd2fc319c7` |
| Redirect URI | `http://localhost:5000/getAToken` |
| API-Permission | Microsoft Graph `User.Read` (delegated), Admin-Consent erteilt (`AllPrincipals`, kein Consent-Prompt beim Login noetig) |
| Client Secret | erstellt, gueltig 1 Jahr, Wert nicht hier dokumentiert (siehe Passwort-Manager/`.env` auf dem Client) |

**Code vorbereitet** (in diesem Ordner):

- [`app.py`](./app.py): Flask-App mit Authlib-OAuth-Client, Routen `/` (Status), `/login`, `/getAToken` (Redirect-Ziel), `/logout`
- [`requirements.txt`](./requirements.txt): `flask`, `authlib`, `python-dotenv`, `requests`
- [`.env.example`](./.env.example): Vorlage mit `CLIENT_ID`/`TENANT_ID` bereits ausgefuellt, `CLIENT_SECRET` muss lokal ergaenzt werden (nicht committen, `.env` ist in `.gitignore`)

<br>

<h2 id="umsetzung"><font color="#8250df">Umsetzung auf Client01</font></h2>

**Installation:** Python 3.12.1 installiert, venv erstellt, `pip install -r requirements.txt`, `.env` mit Client Secret angelegt (siehe Passwort-Manager). App gestartet (`python app.py`), erreichbar unter `http://localhost:5000`.

**Stolperstein: Prozess ueberlebt SSH-Session-Ende nicht.** Ein per `Start-Process` oder Scheduled Task im Hintergrund gestarteter Flask-Prozess wurde beendet, sobald die SSH-Verbindung schloss (Windows OpenSSH terminiert alle Kindprozesse der Session ueber ein Job-Object). Fix: SSH-Verbindung bewusst offengehalten (Hintergrund-Task ohne Timeout), dadurch blieb der Flask-Prozess am Leben, waehrend Robin die Browser-Tests durchfuehrte.

**Testergebnis, alle drei Szenarien ohne Passwort-Prompt:**

- **Test 1 (Chrome, "manueller" Login):** lief ohne Passwortabfrage durch. Grund: im selben Chrome-Profil bestand bereits eine gueltige Microsoft-Session (von vorherigem Arbeiten im Azure-Portal in derselben RDP-Sitzung), dadurch verhielt sich der erste Login faktisch bereits wie token-basiertes SSO.
- **Test 2 (Chrome, token-basiertes SSO):** wie erwartet ohne Passwortabfrage, bestaetigt dieselbe Browser-Session-basierte SSO wie Test 1.
- **Test 3 (Edge, Kerberos/WIA):** auf dem seit Auftrag 10 hybrid Azure AD gejointen Client01 komplett automatischer Login ueber den Primary-Refresh-Token des Geraets, kein Prompt. Einziger Klick: "Login mit Microsoft", danach direkt eingeloggt. Per Bildschirmaufnahme belegt (siehe Nachweise).

<br>

<h2 id="nachweise"><font color="#8250df">Nachweise</font></h2>

<details open>
<summary><strong>Video anzeigen</strong></summary>

<br>

| Datei | Beschreibung |
|---|---|
| [01-app-registration-overview.png](./00-screenshots/01-app-registration-overview.png) | App Registration Overview, `M159-SSO-App` |
| [02-authentication-callback.png](./00-screenshots/02-authentication-callback.png) | Authentication-Blade, konfigurierte Redirect URI (Callback) |
| [03-client-secret-erstellt.png](./00-screenshots/03-client-secret-erstellt.png) | Client Secret erstellt (Wert geschwärzt) |
| [04-env-datei.png](./00-screenshots/04-env-datei.png) | `.env`-Datei mit `CLIENT_ID`/`CLIENT_SECRET`/`TENANT_ID` (Werte geschwärzt) |
| [05-test1-start.png](./00-screenshots/05-test1-start.png) | Test 1: App-Startseite vor Login |
| [06-test1-eingeloggt.png](./00-screenshots/06-test1-eingeloggt.png) | Test 1: erfolgreich eingeloggter Zustand |
| [03-edge-kerberos-wia-sso.mp4](./00-screenshots/03-edge-kerberos-wia-sso.mp4) | Bildschirmaufnahme Test 3: Login in Edge auf Client01 (hybrid Azure AD joined), zeigt Klick auf "Login mit Microsoft" bis zur eingeloggten Seite, ohne jeden Passwort- oder Consent-Prompt dazwischen |

</details>

> ⚠️ **Nachweise fehlen:** die offizielle Aufgabenstellung verlangt zusätzlich Screenshots für Test 2 (Chrome token-basiertes SSO: bestehende M365-Session + erfolgreicher Login) und für Test 3 (Edge Kerberos/WIA: kein Passwort-Prompt + erfolgreicher Login, zusätzlich zum bereits vorhandenen Video). AWS-Guthaben am 22.09.2026 aufgebraucht (50.9/50 Dollar), Client01 nicht mehr erreichbar, um diese vier Screenshots nachzutragen.

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [x] Auftrag gestartet
- [x] Entra ID App Registration erstellt
- [x] Flask-App-Code vorbereitet
- [x] App auf Client01 lauffaehig
- [x] Test 1 (Chrome, Login) durchgefuehrt
- [x] Test 2 (Chrome, token-basiertes SSO) durchgefuehrt
- [x] Test 3 (Edge, Kerberos/WIA) durchgefuehrt und per Video belegt
- [x] Umsetzung abgeschlossen
- [x] Video als Nachweis abgelegt
- [x] `ki-log.md` ausgefüllt

<br>

<h2 id="verweise"><font color="#8250df">Verweise</font></h2>

| Datei | Inhalt |
|---|---|
| [app.py](./app.py) | Flask-App mit Microsoft-Entra-ID-Login |
| [requirements.txt](./requirements.txt) | Python-Abhaengigkeiten |
| [ki-log.md](./ki-log.md) | KI-Nutzung in diesem Auftrag |
| [Auftragsstellung (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/13-sso-python-app/) | Offizielle Aufgabenstellung |
| [Fragenkatalog (Modul-Repo)](https://ch-tbz-it.gitlab.io/Stud/m159/03-auftraege/13-sso-python-app/fragen.html) | Vorbereitung mündlicher Nachweis |

<br>

<div align="center">

⬅️ [Auftrag 12: Netzlaufwerk to Azure Migration](../12-netzlaufwerk-azure/README.md) · 🏠 [Übersicht](../README.md)

</div>
