<div align="center">

# Auftrag 12: KI-Einsatz

![Phase](https://img.shields.io/badge/Phase-Erledigt-1b7f79?style=flat)
![Einträge](https://img.shields.io/badge/Eintr%C3%A4ge-3-8250df?style=flat)

</div>

---

| Wofür eingesetzt | Prompt (sinngemäss) | Wie verifiziert | Ergebnis |
|---|---|---|---|
| Ursachenanalyse Region-Restriktion | `az storage account create` schlug in sieben verschiedenen Regionen mit `RequestDisallowedByAzure` fehl | Websuche zu Azure-for-Students-Region-Restriktionen, danach `az policy assignment list` auf dem eigenen Tenant ausgefuehrt statt weiter zu raten | Feste, kontoindividuelle Region-Whitelist gefunden (5 Regionen: germanywestcentral, italynorth, denmarkeast, spaincentral, belgiumcentral), Storage Account erfolgreich in `germanywestcentral` erstellt |
| Ursachenanalyse Az-PowerShell-Login-Fehler | `Connect-AzAccount` schlug mit kryptischem `.NET MethodNotFound`-Fehler zur MSAL-Extensions-DLL fehl | Vollstaendige Fehlermeldung analysiert statt nur Kurztext, installierte Module auf dem Server geprueft (`AWSPowerShell` gefunden), Ursache als bekannten Modul-Assembly-Konflikt eingeordnet | Fix gefunden und verifiziert: `powershell -NoProfile` verhindert das automatische Laden des kollidierenden AWS-Moduls, Login funktioniert danach |
| Ursachenanalyse ADWS-Verbindungsfehler | `Join-AzStorageAccount` schlug mit "Active Directory Web Services" Verbindungsfehler fehl | ADWS-Dienststatus direkt auf DC01 per SSH geprueft (lief bereits), danach Netzwerkverbindung von AdminCenter01 zu Port 9389 gezielt getestet statt den Dienst grundlos neu zu starten | Firewall-Ursache bestaetigt (Port 9389 nie geoeffnet gewesen), nach Security-Group-Anpassung durch den Nutzer erfolgreich |

### Reflexion

1. **Wo hat die KI geholfen?**

Beim schnellen Eingrenzen mehrerer, technisch sehr unterschiedlicher Fehlerquellen (Azure-Policy-Restriktion, PowerShell-Modul-Assemblykonflikt, Netzwerk/Firewall) durch gezieltes Nachschauen (Policy-Abfrage, Dienststatus, Portverbindungstest) statt durch Ausprobieren auf Verdacht. Besonders beim MSAL-Fehler waere ein oberflaechlicher Blick auf die Fehlermeldung allein nicht zielfuehrend gewesen, das Wissen um bekannte AWS/Az-Modul-Konflikte kam aus gezielter Recherche zur exakten Fehlermeldung.

2. **Wo lag sie falsch, und wie habe ich es gemerkt?**

Die ersten sechs Versuche, den Storage Account in gaengigen Regionen (eastus, westeurope usw.) zu erstellen, gingen implizit davon aus, dass irgendeine Standardregion funktionieren wuerde. Erst nach mehreren identischen Fehlschlaegen wurde die Region-Restriktion als eigentliche, kontoindividuelle Ursache erkannt und gezielt per Policy-Abfrage geloest, statt weiter Regionen durchzuprobieren.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 12](./README.md)

</div>
