<div align="center">

# Entscheidungsprotokoll: Auftrag 09

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)

</div>

---

### Entscheid: OU-Namenskonflikt in der Aufgabenstellung

**Welche Optionen standen zur Wahl?**

Die offizielle Aufgabenstellung enthält im Abschnitt zur Umgebungsvorbereitung eine widersprüchliche Formulierung: sie verlangt zuerst die Erstellung einer OU namens `User` direkt unter der Domain-Wurzel, spricht im unmittelbar folgenden Satz aber von der OU `User-ImportUser` als Elternteil der drei Abteilungs-OUs (`IT`, `Marketing`, `Support`), ohne diese zweite Ebene vorher einzuführen. Zur Wahl standen damit zwei Lesarten: entweder wird `User-ImportUser` als reiner Tippfehler behandelt und nur eine einzige OU `User` angelegt, oder der Text wird wörtlich genommen und zusätzlich eine Zwischen-OU `User-ImportUser` unterhalb von `User` erstellt.

**Wofür habe ich mich entschieden?**

Für die einfachere Lesart: nur die OU `User` wird angelegt, mit den drei Abteilungs-OUs direkt darunter, ohne zusätzliche Zwischenebene.

**Warum, und was sprach dagegen?**

Der übrige Text der Aufgabenstellung erwähnt an keiner weiteren Stelle eine zweistufige OU-Hierarchie, und auch die spätere Verwendung im Skript (`$targetOU = "OU=$row.Abteilung,OU=User,..."`) geht nur von einer einzigen Ebene `User` aus, ohne `User-ImportUser` einzubauen. Das legt nahe, dass es sich um einen Kopier- oder Formulierungsfehler im Originaltext handelt, vermutlich aus einer früheren Version der Aufgabenstellung, in der die OU noch anders benannt war. Gegen diese Lesart spricht, dass eine wörtliche Umsetzung sicherer gewesen wäre, falls die Zwischenebene doch beabsichtigt war und nur unklar beschrieben wurde. Da aber sowohl der Fliesstext als auch der vorgegebene Skript-Code konsistent nur eine Ebene verwenden, überwiegt die Wahrscheinlichkeit eines Tippfehlers deutlich, weshalb auf die zusätzliche Ebene verzichtet wurde. Sollte sich das im Nachhinein als falsch herausstellen, liesse sich die zusätzliche OU-Ebene jederzeit mit einem einzigen `New-ADOrganizationalUnit`-Befehl nachträglich einfügen, ohne bereits angelegte Benutzer zu beeinträchtigen.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 09](./README.md)

</div>
