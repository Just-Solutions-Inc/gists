$dateFormat = 'yyyy-MM-dd_HH:mm'
$users = get-aduser -filter {enabled -eq $true} -Properties lastLogonDate,passwordLastSet,whenCreated,whenChanged,lastBadPasswordAttempt,lockedOut,memberOf |
    Sort-Object lastLogonDate

function formatDate($date) {
    if ($date) {
        return $date.ToString($dateFormat)
    }
}

$table = $users | ForEach-Object {
    [pscustomobject]@{
        Name            = $_.Name
        Username        = $_.sAMAccountname
        LastLogin       = formatDate($_.lastLogonDate)
        PasswordLastSet = formatDate($_.passwordLastSet)
        AccountCreated  = formatDate($_.whenCreated)
        LastModified    = formatDate($_.whenChanged)
        LastBadPW       = formatDate($_.lastBadPasswordAttempt)
        AccountLocked   = $_.lockedout
        Groups          = ($_.memberof | Sort-Object) -replace 'cn=|,(ou|cn)=.+|\\' -join ', '
    }
} |
    export-csv "C:\ADUsers_$(Get-Date -format "yyyy-MM-dd").csv" -NoTypeInformation
