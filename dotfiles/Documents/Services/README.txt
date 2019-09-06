## Systemd service/timer files are located in:
/usr/lib/systemd/system/

## Create serivce/timer files:
/usr/lib/systemd/system/SERVICE.timer
/usr/lib/systemd/system/SERVICE.service


## Ensure [INSTALL] sections are defined correctly and then enable:
sudo systemctl enable SERVICE.timer

## Note: DO NOT enable oneshot services
#sudo systemctl start SERVICE.service
#sudo systemctl enable SERVICE.service

## Check service output 
sudo journalctl -u SERVICE
