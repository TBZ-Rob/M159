<div align="center">

# 📁 Entscheidungsprotokoll: Auftrag 01

![Phase](https://img.shields.io/badge/Phase-Erledigt-brightgreen?style=flat)

</div>

---

### Entscheid: Domain-Namensschema

**Welche Optionen standen zur Wahl?**
Eigener/modulspezifischer Name (z. B. an TBZ/M159 angelehnt) vs. bekannte, branchenübliche Beispielfirma (Contoso, Fabrikam, Adatum) vs. komplett freier Fantasiename.

**Wofür habe ich mich entschieden?**
Contoso, als Second-Level-Domäne `contoso.com`, On-Prem-AD `ad.contoso.com`, AWS Managed AD `aws.contoso.com`.

**Warum, und was sprach dagegen?**
Contoso ist die von Microsoft in praktisch der gesamten AD-/Azure-/Entra-Dokumentation verwendete Referenzfirma, dadurch bleibt das Namensschema auch ausserhalb des Moduls verständlich und ist klar von M159-spezifischen Namen getrennt. Dagegen spricht, dass der Name keinen persönlichen Bezug hat und in Beispielen/Tutorials mehrfach vorkommt (Verwechslungsgefahr mit fremden Anleitungen); dem wurde mit einer persönlich eindeutigen öffentlichen Domain (`contoso-robin.dynv6.net`) entgegengewirkt.

<br>

<div align="center">

⬅️ [Zurück zu Auftrag 01](./README.md)

</div>
