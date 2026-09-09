<div align="center">

# Entscheidungsprotokoll: Auftrag 08

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)

</div>

---

### Entscheid: Dienstkonto für Applikationsanbindung

**Welche Optionen standen zur Wahl?**

Für die LDAP-Abfrage, die eine Firewall pro VPN-Login gegen den Domänencontroller ausführt, standen drei Optionen zur Wahl: die Verwendung eines bereits bestehenden administrativen Kontos (z. B. Administrator), ein eigens dafür erstelltes, dediziertes Dienstkonto mit minimalen Rechten, oder anonymer LDAP-Zugriff ohne jede Authentifizierung.

**Wofür habe ich mich entschieden?**

Für ein dediziertes Dienstkonto (`svc-firewall-ldap`) mit reinem Lesezugriff, beschränkt auf die für den Filter tatsächlich benötigten Attribute (`sAMAccountName`, `memberOf`, `userAccountControl`).

**Warum, und was sprach dagegen?**

Anonymer Zugriff wurde verworfen, weil moderne Active-Directory-Umgebungen ihn standardmässig deaktivieren, und eine nachträgliche Aktivierung ein erhebliches Sicherheitsrisiko wäre: jeder Client im Netzwerksegment könnte dann ohne jede Authentifizierung Verzeichnisdaten auslesen, nicht nur die Firewall. Ein bestehendes administratives Konto wäre technisch die einfachste Lösung gewesen, da keine neue Kontoverwaltung nötig wäre, hätte aber der Firewall-Anwendung weit mehr Rechte gegeben als für eine reine Mitgliedschaftsabfrage nötig ist. Bei einer kompromittierten oder fehlerhaft konfigurierten Firewall-Integration hätte ein Angreifer dann potenziell vollen administrativen Zugriff auf die Domäne erlangen können, was in keinem Verhältnis zum eigentlichen Zweck (einer einzelnen Lesefreigabe) steht.

Das dedizierte Dienstkonto folgt stattdessen dem Prinzip der geringsten Rechte: es kann ausschliesslich lesen, keine administrativen Gruppen enthalten, und lässt sich bei Bedarf (z. B. bei Verdacht auf Missbrauch, oder bei einem Wechsel der Firewall-Lösung) unabhängig von allen anderen Konten und Diensten deaktivieren oder anpassen, ohne andere Systeme zu beeinträchtigen. Der einzige Nachteil dieser Lösung ist der zusätzliche Verwaltungsaufwand, ein weiteres Konto muss angelegt, dokumentiert und dessen Passwort periodisch gewechselt werden, was bei den beiden Alternativen entfallen wäre. Dieser Mehraufwand steht aber in keinem Verhältnis zum Sicherheitsgewinn.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 08](./README.md)

</div>
