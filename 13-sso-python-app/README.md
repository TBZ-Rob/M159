<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 13: SSO Python App

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal) · Kompetenzfelder=58a6ff (blau, neutral)
-->

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-d29922?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-40%25-d29922?style=flat)
![Block](https://img.shields.io/badge/Block-2%20Cloud%20Integration-lightgrey?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Ja-8250df?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-B%2C%20C-58a6ff?style=flat)

**[Ziel](#ziel) · [Vorbereitung](#vorbereitung-erledigt) · [Noch zu tun](#noch-zu-tun) · [Nachweise](#nachweise) · [Checkliste](#checkliste)**

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

<h2 id="noch-zu-tun"><font color="#8250df">Noch zu tun</font></h2>

Wartet auf AWS-Verfuegbarkeit (Wartungsunterbruch), danach auf Client01 (Kerberos/WIA-Test braucht das hybrid-verbundene Geraet aus Auftrag 10):

1. Python 3.12 installieren, `.env` mit Client Secret anlegen, `pip install -r requirements.txt`, `flask run` starten
2. **Test 1 (Chrome, manueller Login):** normaler interaktiver Login mit Passwort-Eingabe und Consent
3. **Test 2 (Chrome, token-basiertes SSO):** falls im selben Chrome-Profil bereits eine Entra-ID-Session existiert (z. B. ueber `portal.azure.com` eingeloggt), sollte der Login ohne erneute Passwortabfrage durchlaufen, rein ueber das Browser-Session-Cookie, unabhaengig von AD-Mitgliedschaft des Geraets
4. **Test 3 (Edge, Kerberos/WIA):** auf Client01 (hybrid Azure AD joined seit Auftrag 10) sollte Edge den Login komplett automatisch, ohne jeden Prompt, ueber den Primary-Refresh-Token des Geraets abschliessen. Falls nicht: in `edge://policy` bzw. Windows-Kontoeinstellungen pruefen, ob das Geraetekonto fuer Edge sichtbar ist
5. **Video pflicht:** mindestens Test 3 als Bildschirmaufnahme (Windows: `Win+Alt+R` fuer Game-Bar-Aufnahme, oder Snipping Tool mit Video-Funktion), zeigt, dass kein Passwort-Prompt erscheint

<br>

<h2 id="nachweise"><font color="#8250df">Nachweise</font></h2>

> _Wird nach Durchfuehrung der drei Tests ergaenzt._

<br>

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [x] Auftrag gestartet
- [x] Entra ID App Registration erstellt
- [x] Flask-App-Code vorbereitet
- [ ] App auf Client01 lauffaehig
- [ ] Test 1 (Chrome, manueller Login) durchgefuehrt
- [ ] Test 2 (Chrome, token-basiertes SSO) durchgefuehrt
- [ ] Test 3 (Edge, Kerberos/WIA) durchgefuehrt und per Video belegt
- [ ] Umsetzung abgeschlossen
- [ ] Screenshots/Video als Nachweise abgelegt
- [ ] `ki-log.md` ausgefüllt

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
