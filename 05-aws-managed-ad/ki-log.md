<div align="center">

# Auftrag 05: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-d29922?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-4-8250df?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Authentik-Installation auf neuer EC2-Instanz | "Richte auf einer neuen Ubuntu-EC2-Instanz Authentik gemäss offizieller Dokumentation per Docker Compose ein." | `docker ps` auf Authentik01 geprüft (drei laufende Container: `authentik-server-1`, `authentik-worker-1`, `authentik-postgresql-1`), Web-UI im Browser erreichbar | Erfolgreich, Instanz läuft |
| DNS-Auflösung Authentik01 zu DC01 | "Authentik01 kann `dc01.ad.contoso.com` nicht auflösen, wie binde ich DC01 als DNS-Server ein?" | `nslookup dc01.ad.contoso.com` von Authentik01 aus erfolgreich, LDAP Source verbindet danach | Erfolgreich, Netplan-Eintrag mit DC01 als zusätzlichem Nameserver behoben das Problem |
| LDAPS-Zertifikat auf DC01 einrichten | "AD DS hat kein LDAPS-Zertifikat, wie erstelle ich eines und mache es für die LDAP Source in Authentik vertrauenswürdig?" | LDAP Source in Authentik erfolgreich über `ldaps://dc01.ad.contoso.com:636` verbunden statt Klartext-Port 389 | Erfolgreich, Zertifikat musste zusätzlich manuell in den lokalen Trusted-Root-Store importiert werden |
| Debugging Gruppen-Sync-Fehler | "Der LDAP-Gruppen-Sync in Authentik wirft einen TypeError, wie finde ich die Ursache?" | Worker-Log auf Authentik01 nach dem Fix erneut geprüft, lief fehlerfrei durch (Verifikation der tatsächlich synchronisierten Gruppen steht aber noch aus) | Ursache identifiziert (User-Property-Mappings fälschlich der Gruppen-Mapping-Liste zugeordnet) und behoben |

### Reflexion

1. **Wo hat die KI geholfen?**

Vor allem beim schnellen Aufsetzen von Authentik per Docker Compose und beim Debugging von Fehlern, die ohne Vorwissen zu Authentik (LDAP-Property-Mappings, Sync-Verhalten) viel Trial-and-Error gekostet hätten. Das Einordnen der Fehlermeldung aus dem Worker-Log (`TypeError` beim Gruppen-Sync) auf die falsch zugeordneten Property-Mappings ging so deutlich schneller.

2. **Wo lag sie falsch, und wie habe ich es gemerkt?**

Die ursprüngliche Property-Mapping-Konfiguration der LDAP Source war fehlerhaft (User-Mappings landeten in der Gruppen-Mapping-Liste), was erst beim tatsächlichen Sync-Lauf als `TypeError` im Worker-Log auffiel, nicht schon beim Einrichten selbst. Das zeigt, dass eine Konfiguration, die in der Authentik-UI plausibel aussieht, trotzdem erst durch einen echten Testlauf (Log prüfen) verifiziert werden muss, statt sich auf die KI-Empfehlung allein zu verlassen.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 05](./README.md)

</div>
