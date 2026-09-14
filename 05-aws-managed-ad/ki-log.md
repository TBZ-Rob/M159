<div align="center">

# Auftrag 05: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-In%20Arbeit-d29922?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-9-8250df?style=flat)

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
| Debugging: peter.keller bekam trotz Policy-Engine-Verweigerung im echten Browser-Test Zugriff | "peter.keller konnte sich einloggen, obwohl er nicht in SSO-WAC-Users ist. Warum greift die Policy-Bindung am echten Proxy nicht, obwohl die PolicyEngine ihn korrekt als verweigert auswertet?" | Outpost-Konfiguration per Django-Shell geprueft (`Outpost.objects.all()`), dabei festgestellt, dass die WAC-Proxy-Application keinem Outpost zugewiesen war (`authentik Embedded Outpost` hatte eine leere Provider-Liste). Das erklaerte, warum peter.keller nur beim normalen Authentik-Login landete statt am tatsaechlichen Proxy abgewiesen zu werden. Nach Zuweisung Server-Logs geprueft, ob der Outpost die Application tatsaechlich neu laedt | Erfolgreich: Log zeigte "loaded application ... name: WAC Proxy" fuer den Embedded Outpost |
| Debugging Netzwerkpfad fuer den Proxy (Security Groups, DNS) | "Der Proxy antwortet lokal auf Authentik01 korrekt, aber der Browser-Zugriff von AdminCenter01 aus kommt nicht durch. Was fehlt im Netzwerkpfad?" | Schrittweise per SSH getestet: `ss -tlnp` auf Authentik01 (Dienst lauscht korrekt), danach fehlende Security-Group-Regeln identifiziert (Port 9443 auf Authentik-SG, Port 443 auf AdminCenter01s SG) und nach Freigabe durch den Nutzer erneut mit `curl` verifiziert. Zusaetzlich eine DNS-Namenskollision gefunden (`contoso.com` ist eine echte, oeffentliche Domain, der AWS-VPC-Resolver beantwortete `admincenter01.ad.contoso.com` faelschlich autoritativ mit NXDOMAIN statt DC01 zu fragen), gefixt mit demselben `/etc/hosts`-Muster wie beim urspruenglichen DC01-DNS-Problem | Erfolgreich: `curl` gegen den WAC-Backend-Host liefert jetzt eine gueltige Antwort (WACs eigene Login-Seite) statt Timeout |
| Finaler End-to-End-Login-Test im Browser | Nutzer hat nach den obigen Fixes selbst im Browser getestet (AdminCenter01, `https://10.0.140.253:9443`) | Direkte Rueckmeldung des Nutzers nach echtem Login-Versuch mit beiden Konten | Erfolgreich: `anna.muster` gelangt bis zur WAC-Oberflaeche, `peter.keller` bekommt "Permission denied" von Authentik, bevor WAC sichtbar wird |

### Reflexion

1. **Wo hat die KI geholfen?**

Vor allem beim schnellen Aufsetzen von Authentik per Docker Compose und beim Debugging von Fehlern, die ohne Vorwissen zu Authentik (LDAP-Property-Mappings, Sync-Verhalten) viel Trial-and-Error gekostet hätten. Das Einordnen der Fehlermeldung aus dem Worker-Log (`TypeError` beim Gruppen-Sync) auf die falsch zugeordneten Property-Mappings ging so deutlich schneller.

2. **Wo lag sie falsch, und wie habe ich es gemerkt?**

Die ursprüngliche Property-Mapping-Konfiguration der LDAP Source war fehlerhaft (User-Mappings landeten in der Gruppen-Mapping-Liste), was erst beim tatsächlichen Sync-Lauf als `TypeError` im Worker-Log auffiel, nicht schon beim Einrichten selbst. Das zeigt, dass eine Konfiguration, die in der Authentik-UI plausibel aussieht, trotzdem erst durch einen echten Testlauf (Log prüfen) verifiziert werden muss, statt sich auf die KI-Empfehlung allein zu verlassen. Selbst nach dem ersten Fix (drei offensichtlich falsche Mappings entfernt) blieb ein viertes, unauffälligeres falsches Mapping (`sAMAccountName`, ein Active-Directory-Mapping, das auch bei Gruppen mitgewählt war) in der Liste, das denselben Fehlertyp erneut auslöste. Erst der direkte Blick in den tatsächlichen Expression-Code jedes einzelnen Mappings per Django-Shell (statt nur die Mapping-Namen in der UI zu lesen) zeigte, welches Mapping wirklich `username` statt eines gruppentauglichen Feldes setzt.

Der grössere Fehler lag aber im Verifikationsschritt danach: die Policy-Engine-Prüfung (`anna.muster` erlaubt, `peter.keller` verweigert) wurde als ausreichender Nachweis fuer die funktionierende Gruppensteuerung behandelt, war aber nur eine Verifikation auf Code-Ebene, nicht am tatsächlichen Proxy-Pfad. Dass die WAC-Proxy-Application nie einem Outpost zugewiesen war, wäre so unentdeckt geblieben, es fiel erst auf, weil der Nutzer den echten Browser-Login getestet hat und `peter.keller` durchkam, obwohl er es laut Policy-Engine nicht hätte sollen. Lehre daraus: bei sicherheitsrelevanten Prüfungen (Zugriffssteuerung) reicht eine Verifikation auf der Ebene der Entscheidungslogik nicht aus, wenn nicht auch sichergestellt ist, dass diese Logik am tatsächlichen Endpunkt überhaupt greift.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 05](./README.md)

</div>
