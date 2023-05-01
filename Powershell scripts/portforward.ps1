# Check if powershell is started with Administrator priviledges
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
  $arguments = "& '" + $myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

# Static IP address on the WSL Guest
$remoteport = '172.16.250.2';
# Ports you want to have 127.0.0.1 respond to. (in my case I want it to respond to Apache,NGIX)
$ports = @(80, 443);

for ($i = 0; $i -lt $ports.length; $i++) {
  $port = $ports[$i];
  Invoke-Expression "netsh interface portproxy delete v4tov4 listenport=$port";
  Invoke-Expression "netsh advfirewall firewall delete rule name=$port";
  # Add portforwarding to it responds only to 127.0.0.1 
  # If you want to make the ports available publicly just remove the listenaddress=127.0.0.1 bit
  Invoke-Expression "netsh interface portproxy add v4tov4 listenport=$port listenaddress=127.0.0.1 connectport=$port connectaddress=$remoteport";
  Invoke-Expression "netsh advfirewall firewall add rule name=$port dir=in action=allow protocol=TCP localport=$port";
}

# Just to double check view all portforwarding
Invoke-Expression "netsh interface portproxy show v4tov4";