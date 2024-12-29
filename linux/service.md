## systemctl
```sh
sudo systemctl status $service_name
# or 
sudo systemctl status

# Restart the service ,If the service fails to restart, inspect logs and configuration files in `/etc`.
sudo systemctl restart $service_name

```