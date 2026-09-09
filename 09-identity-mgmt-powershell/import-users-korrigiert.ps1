# BUG-REPORT: Dieses Skript sollte User aus einer CSV importieren
# Korrigierte und um Teil B erweiterte Version - siehe error-log.md fuer Details zu allen behobenen Fehlern
Import-Module ActiveDirectory

$csvPath = "C:\Temp\mitarbeiter.csv"
$users = Import-CSV $csvPath -Delimiter ","

foreach ($row in $users) {

    $sAMAccountName = $row.Vorname.Substring(0,1) + $row.Nachname
    $userPrincipalName = "$sAMAccountName@ad.contoso.com"
    $targetOU = "OU=$($row.Abteilung),OU=User,DC=ad,DC=contoso,DC=com"

    Write-Host "Erstelle User: $sAMAccountName in OU: $targetOU"

    # Teil B: Vorab-Pruefung, ob der sAMAccountName bereits existiert
    $existingUser = Get-ADUser -Filter "SamAccountName -eq '$sAMAccountName'" -ErrorAction SilentlyContinue

    if ($existingUser) {
        Write-Host "User $sAMAccountName existiert bereits - wird uebersprungen." -ForegroundColor Yellow
    }
    else {
        New-ADUser -Name "$($row.Vorname) $($row.Nachname)" `
                   -SamAccountName $sAMAccountName `
                   -UserPrincipalName $userPrincipalName `
                   -Path $targetOU `
                   -AccountPassword (ConvertTo-SecureString "Schule123" -AsPlainText -Force) `
                   -Enabled $true

        Write-Host "User $sAMAccountName erfolgreich erstellt." -ForegroundColor Green
    }
}
