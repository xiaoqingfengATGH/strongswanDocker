# strongswanDocker
Docker images for strongswan VPN

Version 5.8.4

Provide IKEv1 with PSK and Xauth and IKEv2 with Mschapv2 support for IPSec VPN Server.

Run a docker container:
```
docker run --name strongswan --privileged -v /mnt/sda3/strongswan/ipsec.d:/etc/ipsec.d -p 500:500/udp -p 4500:4500/udp xiaoqingfeng999/strongswan:5.8.4
```
Notice:
**/mnt/sda3/strongswan/ipsec.d** is an example, change to your path.

ipsec.conf should be placed to **/mnt/sda3/strongswan/ipsec.d**/conf
ipsec.secrets should be placed to **/mnt/sda3/strongswan/ipsec.d**
strongswan.d directory should be placed to **/mnt/sda3/strongswan/ipsec.d**

Pull docker image:
```
docker pull xiaoqingfeng999/strongswan:5.8.4
```

Build a docker image yourself:
```
git clone https://github.com/xiaoqingfengATGH/strongswanDocker
docker build -t xiaoqingfeng999/strongwans:5.8.4 strongwanDocker
```
