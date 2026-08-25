<div align="center">

# 📁 M159: Projekt-Setup-Sheet

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-orange?style=flat)
![Domain](https://img.shields.io/badge/Domain-contoso.com-1f6feb?style=flat)

</div>

> ⚠️ Dieses Dokument enthält **keine echten Passwörter/Secrets**, nur Platzhalter. Echte Werte gehören in einen Passwort-Manager, niemals ins Git-Repository (siehe `ki-nutzung.md`, Abschnitt 8).

---

## 1. Übersicht Umgebung

- 1× Windows Server (DC) auf AWS EC2
- 1× Windows Server (Client) auf AWS EC2
- 1× Windows Server (Admin Center) auf AWS EC2
- AWS Managed AD mit Trust zur On-Premises-AD (EC2)
- Entra Connect zur Synchronisation mit Entra ID
- Lokale AD-Domain zu Beginn, später öffentliche Domain als UPN

## 2. Allgemeine Angaben

| Feld | Wert |
|---|---|
| Vorname | Robin |
| Nachname | Nydegger |
| Klasse | PE24c |
| Dokumentation (Git-Repo-Link) | [github.com/TBZ-Rob/M159](https://github.com/TBZ-Rob/M159) |

## 3. Ressourcen

| Feld | Wert |
|---|---|
| AD Second-Level-Domäne | `contoso.com` |
| Geplante öffentliche Domain (UPN) | `contoso-robin.dynv6.net` |
| Azure Education Account | _{{AZURE_ACCOUNT_EMAIL}}_ |
| Azure Education Account Passwort | _siehe Passwort-Manager_ |

## 4. AWS VPC Setup

> Der DC liegt im privaten Subnetz (kein öffentlicher Zugriff), Client und Admin Center liegen im öffentlichen Subnetz mit Elastic IP und RDP (3389) von aussen erreichbar. Alle weiteren Ports nur innerhalb des VPCs offen.

| Komponente | VPC-ID | CIDR | Name |
|---|---|---|---|
| VPC | `vpc-006acd098b2993828` | `10.0.0.0/16` | M159-vpc |
| Subnetz | n/a | `10.0.128.0/20` | M159-subnet-private1-us-east-1a |
| Subnetz | n/a | `10.0.144.0/20` | M159-subnet-private2-us-east-1b |
| Subnetz | n/a | `10.0.0.0/20` | M159-subnet-public1-us-east-1a |
| Subnetz | n/a | `10.0.16.0/20` | M159-subnet-public2-us-east-1b |

## 5. AWS Sicherheitsgruppen

### Sicherheitsgruppe für Domain Controller

| Regeltyp | Port(e) | Quelle |
|---|---|---|
| RDP | 3389 (TCP) | 0.0.0.0/0 |
| LDAP | 389 (TCP/UDP) | VPC-intern |
| LDAPS | 636 (TCP) | VPC-intern |
| Kerberos | 88 (TCP/UDP) | VPC-intern |
| SMB | 445 (TCP) | VPC-intern |
| DNS | 53 (TCP/UDP) | VPC-intern |
| RPC | 135, 49152 bis 65535 (TCP) | VPC-intern |
| ICMP | Alle | VPC-intern |
| Global Catalog | 3268 (TCP) | VPC-intern |
| Global Catalog SSL | 3269 (TCP) | VPC-intern |
| Kerberos Password Change/Set | 464 (TCP/UDP) | VPC-intern |

### Sicherheitsgruppe für Clients

| Regeltyp | Port(e) | Beschreibung | Quelle |
|---|---|---|---|
| RDP | 3389 | Remote Desktop | 0.0.0.0/0 |
| TCP | 88 | Kerberos Authentication | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| TCP | 135 | RPC Endpoint Mapper | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| TCP | 139 | NetBIOS Session Service | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| TCP | 389 | LDAP | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| UDP | 53 | DNS | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| TCP | 445 | SMB/CIFS | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| TCP | 49152 bis 65535 | RPC Ephemeral Ports | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |
| ICMP | Alle | Ping etc. | 10.0.0.0/20, 10.0.128.0/20, 10.0.144.0/20 |

## 6. Active Directory Umgebung

### On-Premises AD (AWS EC2)

| Feld | Wert |
|---|---|
| Third-Level-Domäne | `ad.contoso.com` (erstellt, siehe [Auftrag 03](../03-gesamtstruktur-dc-client/README.md)) |
| NetBIOS-Name | `AD` |
| Öffentlicher UPN-Suffix (später) | `contoso-robin.dynv6.net` |
| DNS-Forwarder | `9.9.9.9` |
| Domänenadministrator | Administrator (`AD\Administrator`) |
| Kennwort Domänenadministrator | _siehe Passwort-Manager_ |
| Kennwort DSRM (Demote) | _siehe Passwort-Manager_ |

### Azure AD (Entra ID)

| Feld | Wert |
|---|---|
| Entra ID Domain | _{{ENTRA_DOMAIN}}_ |
| Azure Global Administrator | _{{ENTRA_ADMIN}}_ |
| Kennwort Azure Administrator | _siehe Passwort-Manager_ |
| Entra Connect Server | _{{ENTRA_CONNECT_SERVER}}_ |

### AWS Managed AD

| Feld | Wert |
|---|---|
| Third-Level-Domäne | `aws.contoso.com` |
| Trust-Typ | Tree-Root Trust |
| AWS Managed Admin User | admin |
| AWS Managed Admin Passwort | _siehe Passwort-Manager_ |
| DNS-Server 1 | _{{DNS1}}_ |
| DNS-Server 2 | _{{DNS2}}_ |
| Trust Passwort | _siehe Passwort-Manager_ |
| Subnetz 1 | M159-subnet-private1-us-east-1a (10.0.128.0/20) |
| Subnetz 2 | M159-subnet-private2-us-east-1b (10.0.144.0/20) |

## 7. EC2-Instanzen

| Komponente | FQDN | Elastic IP | Private IP | Subnetz | DNS-Server 1 | DNS-Server 2 | Lokaler Admin | Kennwort |
|---|---|---|---|---|---|---|---|---|
| IaaS/OnPrem AD DC | `dc.ad.contoso.com` | n/a (kein öffentlicher Zugriff) | `10.0.128.11` | M159-subnet-private1-us-east-1a | n/a | n/a | Administrator | _siehe PM_ |
| Windows Server (Client) | `client.ad.contoso.com` | `52.71.123.76` | `10.0.0.20` | M159-subnet-public1-us-east-1a | n/a | n/a | Administrator | _siehe PM_ |
| Windows Server Admin Center | `admin.ad.contoso.com` | `32.195.165.234` | `10.0.0.30` | M159-subnet-public1-us-east-1a | n/a | n/a | Administrator | _siehe PM_ |

> Hinweis: Der DC hat abweichend vom ursprünglichen Plan die IP `10.0.128.11` statt `10.0.128.10` erhalten (AWS hat beim Erstellen automatisch vergeben statt der manuell gesetzten Adresse). Funktional ohne Unterschied, da weiterhin im geplanten Subnetz.

## 8. Abteilungen & Benutzer

| Abteilung | Name der Abteilung | Benutzername | Vorname | Nachname | Kennwort | Bereiche |
|---|---|---|---|---|---|---|
| 1 | Sekretariat | _{{USER1}}_ | | | _siehe PM_ | intern |
| 2 | Buchhaltung | _{{USER2}}_ | | | _siehe PM_ | intern |
| 3 | GL | _{{USER3}}_ | | | _siehe PM_ | intern |
| 4 | Promoter | _{{USER4}}_ | | | _siehe PM_ | extern |

## 09. Python-App-Registration (Entra-ID)

| Name | Wert |
|---|---|
| Directory (tenant) ID | _siehe .env, nicht hier eintragen_ |
| Application (client) ID | _siehe .env, nicht hier eintragen_ |
| Client Secret ID | _siehe .env, nicht hier eintragen_ |

## 10. Hinweise

- Lokale Domain-Umgebung zuerst, öffentlicher UPN-Suffix folgt später.
- Sicherheitsgruppen-Regeln vor Inbetriebnahme jeder Instanz prüfen.
- Alle IPs/Hostnamen/Usernamen hier konsequent dokumentieren. **Keine Klartext-Passwörter.**

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 01](./README.md) · 🌐 [Architektur-Diagramm](./README.md#️-architektur)

</div>
