get-csonlineuser | foreach {
    $currentuser = $_.userprincipalname
    $CurrentuserACPInfo = Get-CsUserAcp -Identity $currentuser   
    $SplitTollNumber =  $CurrentuserACPInfo.AcpInfo -split("<tollNumber>") -split ("</tollNumber>")
    $CurrentUserTollNumber = $SplitTollNumber[1]
    $SplitParticipantPassCode =  $CurrentuserACPInfo.AcpInfo -split("<participantPassCode>") -split ("</participantPassCode>")
    $CurrentUserParticipantPasscode = $SplitParticipantPassCode[1] 
    $SplitDomain =  $CurrentuserACPInfo.AcpInfo -split("<domain>") -split ("</domain>")
    $CurrentUserDomain = $SplitDomain[1] 
    $SplitName =  $CurrentuserACPInfo.AcpInfo -split("<name>") -split ("</name>")
    $CurrentUserName = $SplitName[1]
    $Spliturl=  $CurrentuserACPInfo.AcpInfo -split("<url>") -split ("</url>")
    $CurrentUserURL = $Spliturl[1]
    # Build Output Object
               $ACPObject = New-Object -TypeName psobject
               Add-Member -InputObject $ACPObject -MemberType NoteProperty -Name 'UserUPN' -Value $currentuser
               Add-Member -InputObject $ACPObject -MemberType NoteProperty -Name 'TollNumber' -Value $CurrentUserTollNumber
               Add-Member -InputObject $ACPObject -MemberType NoteProperty -Name 'Passcode' -Value $CurrentUserParticipantPasscode
               Add-Member -InputObject $ACPObject -MemberType NoteProperty -Name 'Domain' -Value $CurrentUserDomain
               Add-Member -InputObject $ACPObject -MemberType NoteProperty -Name 'Name' -Value $CurrentUserName
               Add-Member -InputObject $ACPObject -MemberType NoteProperty -Name 'URL' -Value $CurrentUserURL 
               [Array] $out += $ACPObject
               clear-variable ACPObject 
               clear-variable CurrentUser
               clear-variable CurrentuserACPInfo
               clear-variable SplitTollNumber
               clear-variable CurrentUserTollNumber
               clear-variable SplitParticipantPassCode
               clear-variable CurrentUserParticipantPasscode
    }
    
$out | Export-csv -Path "C:\Users\markl_000\Documents\ACP3.csv" -NoTypeInformation
Clear-Variable out