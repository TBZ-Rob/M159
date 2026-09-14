<div align="center">

# Auftrag 05: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-d29922?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-6-8250df?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Authentik-Installation auf neuer EC2-Instanz | "Richte auf einer neuen Ubuntu-EC2-Instanz Authentik gemäss offizieller Dokumentation per Docker Compose ein." | `docker ps` auf Authentik01 geprüft (drei laufende Container: `authentik-server-1`, `authentik-worker-1`, `authentik-postgresql-1`), Web-UI im Browser erreichbar | Erfolgreich, Instanz läuft |
| DNS-Auflösung Authentik01 zu DC01 | "Authentik01 kann `dc01.ad.contoso.com` nicht auflösen, wie binde ich DC01 als DNS-Server ein?" | `nslookup dc01.ad.contoso.com` von Authentik01 aus erfolgreich, LDAP Source verbindet danach | Erfolgreich, Netplan-Eintrag mit DC01 als zusätzlichem Nameserver behoben das Problem |
| LDAPS-Zertifikat auf DC01 einrichten | "AD DS hat kein LDAPS-Zertifikat, wie erstelle ich eines und mache es für die LDAP Source in Authentik vertrauenswürdig?" | LDAP Source in Authentik erfolgreich über `ldaps://dc01.ad.contoso.com:636` verbunden statt Klartext-Port 389 | Erfolgreich, Zertifikat musste zusätzlich manuell in den lokalen Trusted-Root-Store importiert werden |
| Debugging Gruppen-Sync-Fehler | "Der LDAP-Gruppen-Sync in Authentik wirft einen TypeError, wie finde ich die Ursache?" | Worker-Log auf Authentik01 nach dem Fix erneut geprüft, lief fehlerfrei durch (Verifikation der tatsächlich synchronisierten Gruppen steht aber noch aus) | Ursache identifiziert (User-Property-Mappings fälschlich der Gruppen-Mapping-Liste zugeordnet) und behoben |
| Debugging Gruppen-Sync-Fehler (Fortsetzung) | "Der Gruppen-Sync schlaegt immer noch fehl, jetzt mit TypeError: Group() got unexpected keyword arguments: 'username', obwohl die Mapping-Liste in der UI korrekt aussieht. Wie pruefe ich das direkt in der Datenbank statt nur in der UI?" | Property-Mappings der LDAP Source direkt per Django-Shell abgefragt (`s.group_property_mappings.all()`), Expression-Code jedes Mappings einzeln ausgegeben, fehlerhaftes Mapping (`authentik default Active Directory Mapping: sAMAccountName`, setzt `username`, ein reines User-Feld) identifiziert und aus der Gruppen-Mapping-Liste entfernt (User-Mapping-Liste blieb unveraendert). Nach erneutem Sync direkt die Group-Objekte in der DB gezaehlt | Erfolgreich: Gruppen-Sync funktioniert jetzt vollstaendig, 71 Gruppen synchronisiert (inkl. `SSO-WAC-Users`) |
| Gruppen-Bindung an Application + End-to-End-Zugriffstest | "Binde die AD-Gruppe SSO-WAC-Users an die Policy/Group-Bindung der Application Windows Admin Center und pruefe, dass anna.muster Zugriff bekommt, peter.keller aber nicht." | `PolicyBinding` per Django-Shell erstellt (Group SSO-WAC-Users auf Application Windows Admin Center), danach die Zugriffsentscheidung direkt mit Authentiks eigener `PolicyEngine`-Klasse fuer beide Benutzer ausgewertet (dieselbe Klasse, die auch der Proxy-Outpost fuer echte Zugriffsentscheidungen verwendet) | Erfolgreich: `anna.muster` passing=True, `peter.keller` passing=False. Ein vollstaendiger interaktiver Browser-Login-Test steht noch aus |

### Reflexion

1. **Wo hat die KI geholfen?**

Vor allem beim schnellen Aufsetzen von Authentik per Docker Compose und beim Debugging von Fehlern, die ohne Vorwissen zu Authentik (LDAP-Property-Mappings, Sync-Verhalten) viel Trial-and-Error gekostet hätten. Das Einordnen der Fehlermeldung aus dem Worker-Log (`TypeError` beim Gruppen-Sync) auf die falsch zugeordneten Property-Mappings ging so deutlich schneller.

2. **Wo lag sie falsch, und wie habe ich es gemerkt?**

Die ursprüngliche Property-Mapping-Konfiguration der LDAP Source war fehlerhaft (User-Mappings landeten in der Gruppen-Mapping-Liste), was erst beim tatsächlichen Sync-Lauf als `TypeError` im Worker-Log auffiel, nicht schon beim Einrichten selbst. Das zeigt, dass eine Konfiguration, die in der Authentik-UI plausibel aussieht, trotzdem erst durch einen echten Testlauf (Log prüfen) verifiziert werden muss, statt sich auf die KI-Empfehlung allein zu verlassen. Selbst nach dem ersten Fix (drei offensichtlich falsche Mappings entfernt) blieb ein viertes, unauffälligeres falsches Mapping (`sAMAccountName`, ein Active-Directory-Mapping, das auch bei Gruppen mitgewählt war) in der Liste, das denselben Fehlertyp erneut auslöste. Erst der direkte Blick in den tatsächlichen Expression-Code jedes einzelnen Mappings per Django-Shell (statt nur die Mapping-Namen in der UI zu lesen) zeigte, welches Mapping wirklich `username` statt eines gruppentauglichen Feldes setzt.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 05](./README.md)

</div>
