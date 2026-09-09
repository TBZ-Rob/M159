<div align="center">

# Auftrag 09: Error-Log (Teil A)

</div>

---

| Nr. | Fehlerbeschreibung | Ursprünglicher Code | Fehlerkategorie | Korrektur |
|---|---|---|---|---|
| 1 | Falsches CSV-Trennzeichen | `Import-CSV $csvPath -Delimiter ";"` | Delimiter-Mismatch | `Import-CSV $csvPath -Delimiter ","` |
| 2 | Objekteigenschaft im String nicht als Sub-Expression referenziert | `"$row.Vorname $row.Nachname"` | String-Interpolation | `"$($row.Vorname) $($row.Nachname)"` |
| 3 | Distinguished Name entspricht nicht der echten Domäne | `DC=it-tbz,DC=local` | Fehlerhafte Umgebungsangabe | `DC=ad,DC=contoso,DC=com` |
| 4 | Falsches Cmdlet zur Passwort-Konvertierung | `ConvertFrom-SecureString "Schule123" -AsPlainText -Force` | Falsches Cmdlet | `ConvertTo-SecureString "Schule123" -AsPlainText -Force` |
| 5 | OU-Pfad kombiniert fehlende Sub-Expression und falsche Domäne | `"OU=$row.Abteilung,OU=User,DC=it-tbz,DC=local"` | String-Interpolation + Umgebungsangabe | `"OU=$($row.Abteilung),OU=User,DC=ad,DC=contoso,DC=com"` |

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 09](./README.md)

</div>
