In order to make it possible to make WSL respond to 127.0.0.1 (WSL only responds to localhost by default), 
We need to make these steps.

In the wsl.conf under [boot] add
command=ip address add 172.16.250.2/24 brd + dev eth0;

This is so we have a static IP assigned to our WSL instance.

Then copy and paste the setwSLIPAddress.ps1 script to a folder (for example: C:/Scripts).
Put the setip.sh script in /usr/local/bin and make it executable (chmod -R u=rwX,go=rX). 
Then edit the script so it points to the correct location. 

Once that is done, restart the WSL instance, and from the WSL instance type setip.sh so the 
Windows side also has a static IP address on the WSL adapter. 

Now you can use and alter the portforward.ps1 script to start forwarding all the ports to the WSL ip address.

Happy coding! 

P.S> I'm using a custom .dev domain pointing towards 127.0.0.1 that wouldn't work otherwise.
