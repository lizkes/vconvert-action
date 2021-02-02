apt-get install -y fuse unzip 
curl https://rclone.org/install.sh | bash

mkdir -p ~/.config/rclone/
cat <<EOT >~/.config/rclone/rclone.conf
[gdrive]
type = drive
client_id = $client_id
client_secret = $client_secret
scope = drive
token = $token
team_drive = $team_drive
root_folder_id = 
EOT

mkdir -p /mnt/gdrive
rclone mount gdrive:/ /mnt/gdrive --umask 0000 --default-permissions --allow-other --allow-non-empty --transfers 2 --buffer-size 512M --low-level-retries 200 --daemon