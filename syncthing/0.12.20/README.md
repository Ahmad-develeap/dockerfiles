# pinterb/syncthing  

[`pinterb/syncthing`][1] is a [docker][2] image that bundles the following:  
* **[Syncthing v0.12.20][3]:** Syncthing replaces proprietary sync and cloud services with something open, trustworthy and decentralized. Your data is your data alone and you deserve to choose where it is stored, if it is shared with some third party and how it's transmitted over the Internet..  

## Details
* The container runs as "dev" user (i.e. UID 5000). *Please keep this in mind as you mount volumes!* 
* The following volumes exist (and are owned by dev):  
  - /data
  - /ops
  - /state
  - /config
  - /home/dev/.ssh
* /data is your default workdir.   
* /home/dev is $HOME  
* ***NOTE:*** If you are not using an existing config.xml, Syncthing will create a config for you.  This is default Syncthing behavior.  

## Usage 
This image can easily be extended.  But to run Syncthing:

````
docker run -it --rm \
	-v $(SSH_DIR):/home/dev/.ssh \
	-v $(CURRENT_DIR):/state:rw \
	-v $(PROVISION_CONFIG_DIR):/config:rw \
	-v $(PROVISION_DATA_DIR):/data:rw \
	-p 8384:8384 \
	-p 22000:22000 \
	pinterb/syncthing:0.12.20 -home /config -gui-address=https://0.0.0.0:8384 -no-browser    
		
````

## Misc. Info 
* Latest version: 0.12.20  
* Built on: 2016-09-13T15:50:32EDT   
* Base image: pinterb/base:alpine   


[1]: https://hub.docker.com/r/pinterb/syncthing/   
[2]: https://docker.com 
[3]: https://syncthing.net/  
