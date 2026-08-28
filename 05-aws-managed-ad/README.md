<div align="right">

<img src="../00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zürich" width="190">

</div>

<div align="center">

# Auftrag 05: AWS Managed Microsoft AD (Variante B: Authentik)

<!--
Farblogik (Phase): offen=lightgrey · in-arbeit=d29922 (amber) · fertig=1b7f79 (teal)
-->

![Phase](https://img.shields.io/badge/Phase-Offen-lightgrey?style=flat)
![Fortschritt](https://img.shields.io/badge/Fortschritt-0%25-lightgrey?style=flat)
![Block](https://img.shields.io/badge/Block-1%20Lokale%20Umgebung-1b7f79?style=flat)
![KI--Anteil](https://img.shields.io/badge/KI--Anteil-Offen-lightgrey?style=flat)
![Kompetenzfelder](https://img.shields.io/badge/Kompetenzfelder-B%2C%20C%2C%20G-d29922?style=flat)

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

<h2 id="checkliste"><font color="#8250df">Checkliste</font></h2>

- [ ] Auftrag gestartet
- [ ] EC2-Instanz für Authentik erstellt und läuft
- [ ] LDAP Source eingerichtet, AD-Benutzer und -Gruppen synchronisiert
- [ ] Login mit AD-Konto nachgewiesen (Prüfung gegen den DC)
- [ ] LDAPS mit Zertifikat eingerichtet, Notwendigkeit dokumentiert
- [ ] Least-privilege Bind-Konto verwendet und begründet
- [ ] Anwendung per SSO angebunden, Zugriff über AD-Gruppe gesteuert
- [ ] Umsetzung abgeschlossen
- [ ] Screenshots/Nachweise abgelegt
- [ ] `ki-log.md` ausgefüllt
- [ ] `entscheidungsprotokoll.md` ausgefüllt (Variante A vs. B)

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
