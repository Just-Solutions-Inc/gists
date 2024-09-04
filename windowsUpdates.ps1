#install pswindowsupdate and install updates ignoring any required reboots
Set-ExecutionPolicy bypass -scope process -force ; install-packageprovider -name nuget -minimumversion 2.8.5.201 -force ; set-psrepository psgallery -installationpolicy trusted ; install-module pswindowsupdate -confirm:$false -force ; hide-windowsupdate -kbarticleID KB5034441 -acceptall ; install-windowsupdate -acceptall -ignorereboot

#install pswindowsupdate and install updates and perform any required reboots
Set-ExecutionPolicy bypass -scope process -force ; install-packageprovider -name nuget -minimumversion 2.8.5.201 -force ; set-psrepository psgallery -installationpolicy trusted ; install-module pswindowsupdate -confirm:$false -force ; hide-windowsupdate -kbarticleID KB5034441 -acceptall ; install-windowsupdate -acceptall -autoreboot



#install windows updates ignoring any required reboots (use if pswindowsupdates is already installed)
Set-ExecutionPolicy bypass -scope process -force ; hide-windowsupdate -kbarticleID KB5034441 -acceptall ; install-windowsupdate -acceptall -ignorereboot

#install windows updates and perform any required reboots (use if pswindowsupdates is already installed)
Set-ExecutionPolicy bypass -scope process -force ; hide-windowsupdate -kbarticleID KB5034441 -acceptall ; install-windowsupdate -acceptall -autoreboot
