#!/bin/sh /etc/rc.common
# Cloudflared tunnel service script
# Script run cloudflared as a service 
# Copyright (C) 2022 C. Brown (dev@coralesoft)
# GNU General Public License
# Last revised 16/06/2022
# version 1.1
# 
# Revision history
# 15/06/2022 Inital release
# 16/06/2022 Rewrote using procd
#######################################################################
##					
##	IMPORTANT this needs to be copied into the /etc/init.d/  
##	folder with no file extention (remove the.sh) rename this file 
##      from cloudflared-service.sh and save as just cloudlfared 	
##							
##	https://github.com/Coralesoft/PiOpenwrtCloudflare
##							
#######################################################################
USE_PROCD=1

START=38
STOP=50
RESTART=55

# fix the cf buffer issues
sysctl -w net.core.rmem_max=2500000

start_service() {
    procd_open_instance
    procd_set_param command /usr/sbin/cloudflared tunnel --config /root/.cloudflared/config.yml run OpenTun
    procd_set_param stdout 1
    procd_set_param stderr 1
    procd_set_param respawn ${respawn_threshold:-3600} ${respawn_timeout:-5} ${respawn_retry:-5}
    procd_set_param user
    procd_close_instance
}



# end of script
