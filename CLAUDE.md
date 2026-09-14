# CLAUDE.md

Diese Datei beschreibt die verbindlichen Konventionen fuer dieses Repository (M159: Directoryservices | Projekt Contoso). Sie gilt fuer alle Markdown-Dateien und generierten Inhalte im gesamten Repo.

## Bei Sessionstart

Bevor irgendeine inhaltliche Arbeit an diesem Projekt beginnt: zuerst im Google-Drive-Vault "Claudes Knowledge Base" die Datei "02 Projekte/M159 Directoryservices/05 Infrastruktur-Referenz (M159).md" vollstaendig lesen. Diese Datei enthaelt den aktuellen technischen Stand (AWS-Infrastruktur, Zugriffswege, Credentials-Fundorte, Projektstand), der nicht komplett im Repo selbst steht.

## Schreibkonventionen

- **Keine Gedankenstriche.** Statt `–`/`—` immer Klammern, Doppelpunkt oder einen neuen Satz verwenden.
- **Kein Eszett.** Immer `ss` statt `ß` schreiben (z. B. "dass", "Strasse", "muss").
- **Echte Umlaute verwenden** (ae/oe/ue sind nicht erlaubt), ausser innerhalb von Mermaid-Codebloecken. Dort keine Umlaute und kein Eszett verwenden, da Mermaid diese teils fehlerhaft rendert; stattdessen ae/oe/ue/ss.

## Farbschema

Gilt fuer Badges, Ueberschriften-Farben, Diagramme und Charts im gesamten Repo:

| Farbe | Hex | Bedeutung |
|---|---|---|
| Lila | `#8250df` | Akzent, Ueberschriften, KI-Anteil |
| Teal | `#1b7f79` | Erledigt, positiv |
| Amber | `#d29922` | In Arbeit, Warnung |
| Lightgrey | `lightgrey` bzw. `#6e7681` | Offen, neutral |

Siehe [README.md](./README.md#badges-legende) fuer die vollstaendige Legende.

## TBZ-Logo

Das TBZ-Logo (lila Variante, `./00-files/assets/tbz-logo-purple.png`) steht in jeder Auftrags-README oben rechts:

```html
<div align="right">

<img src="./00-files/assets/tbz-logo-purple.png" alt="TBZ Technische Berufsschule Zuerich" width="190">

</div>
```

## Reihenfolge der Auftraege

Die Auftraege werden strikt sequenziell bearbeitet: **01 bis 04, dann 07 bis 13.**

Auftrag 05 (AWS Managed AD) und Auftrag 06 (RSAT & Admin Center) sind **ans Ende verschoben**, wegen der laufenden AWS-Kosten. Beide werden am Schluss kompakt nachgeholt, in **Variante B**: Authentik statt AWS Managed AD. Bei Verweisen auf 05/06 immer auf diese Verschiebung und Variante B hinweisen.

## Struktur pro Auftrag

Jeder Auftrags-Ordner (`0X-name/`) enthaelt mindestens:

- `README.md`: Dokumentation des Auftrags
- `ki-log.md`: Prompt, Verifikation und Reflexion zum KI-Einsatz
- optional `entscheidungsprotokoll.md`: bei Auftraegen mit dokumentationswuerdigen Entscheidungen
- optional `00-screenshots/`: Screenshots zum Auftrag

## Verlinkung

Alle Weiterleitungen/Links auf Auftraege verlinken **immer direkt auf die `README.md`-Datei**, nie auf den Ordner (also `./0X-name/README.md`, nicht `./0X-name/` oder `./0X-name`).

## Zugriff auf AWS-Maschinen

- **pve** (Proxmox-Host), **client01** und **admincenter01** sind direkt per SSH über Tailscale erreichbar.
- **dc01** ist NICHT direkt über Tailscale erreichbar (der Tailscale-Client dort bleibt bei der Anmeldung hängen, Ursache noch ungeklärt). Zugriff stattdessen über admincenter01 als Jump Host, auf die private VPC-IP `10.0.128.11`:

```bash
ssh -o ProxyJump=Administrator@100.80.194.46 Administrator@10.0.128.11
```

Alle vier Maschinen haben den SSH-Key dieses Servers (claude-code-server) in `administrators_authorized_keys` hinterlegt.
