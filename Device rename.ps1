# Function to Authenticate and get Token
function Get-GraphApiToken {
    param (
        [string]$ApplicationID,
        [string]$TenantDomainName,
        [string]$AccessSecret
    )
    $body = @{
        Grant_Type    = "client_credentials"
        Scope         = "https://graph.microsoft.com/.default"
        client_Id     = $ApplicationID
        Client_Secret = $AccessSecret
    }
    $response = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantDomainName/oauth2/v2.0/token" `
    -Method POST -Body $body
    return $response.access_token
}

# Setting variables for connecting to the MS API 
$ApplicationID = "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
$TenantDomainName = "contoso.com"
$AccessSecret = Read-Host "Enter Secret"

# Authenticate and get token
$token = Get-GraphApiToken -ApplicationID $ApplicationID -TenantDomainName $TenantDomainName -AccessSecret $AccessSecret

# Importing the CSV of device information
$csvfile = "C:\<Path to file>"
$deviceInfo = Import-Csv $csvfile

foreach ($device in $deviceInfo) {
    $serialNumber = $device.serialNumber
    $tag = $device.tag
    Write-Host "Renaming machine from: $serialNumber to: $tag" -ForegroundColor Cyan

    $uri = "https://graph.microsoft.com/beta/deviceManagement/managedDevices('$serialNumber')/setDeviceName"

    $JSONPayload = @{
        "@odata.type" = "#microsoft.graph.managedDevice"
        "actionName"  = "setDeviceName"
        "deviceName"  = $tag
    } | ConvertTo-Json

    try {
        Invoke-RestMethod -Headers @{Authorization = "Bearer $token"} -Uri $uri -Method PATCH -Body $JSONPayload -ContentType "application/Json"  -Verbose
    } catch {
        Write-Host "Error renaming device $serialNumber. StatusCode: $($_.Exception.Response.StatusCode.value__) StatusDescription: $($_.Exception.Response.StatusDescription)"
    }
}