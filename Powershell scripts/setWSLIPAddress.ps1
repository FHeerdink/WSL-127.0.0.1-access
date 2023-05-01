# Check if powershell is started with Administrator priviledges
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

New-NetIPAddress -InterfaceAlias 'vEthernet (WSL)' -IPAddress '172.16.250.1' -PrefixLength 24