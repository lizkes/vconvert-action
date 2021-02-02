FROM lizkes/vconvert:latest

SHELL ["/bin/bash", "-c"]
COPY rclone.conf ~/.config/rclone/rclone.conf
RUN sed 's@CLIENT_ID@'"$CLIENT_ID"'@' ~/.config/rclone/rclone.conf && sed 's@CLIENT_SECRET@'"$CLIENT_SECRET"'@' ~/.config/rclone/rclone.conf \
    && sed 's@TOKEN@'"$TOKEN"'@' ~/.config/rclone/rclone.conf && sed 's@TEAM_DRIVE@'"$TEAM_DRIVE"'@' ~/.config/rclone/rclone.conf \
    && sed 's@ROOT_FOLDER@'"$ROOT_FOLDER"'@' ~/.config/rclone/rclone.conf
RUN apt-get install -y fuse unzip curl && https://rclone.org/install.sh | bash \
    && mkdir -p /mnt/gdrive && rclone mount gdrive:/ /mnt/gdrive --umask 0000 --default-permissions --allow-other --allow-non-empty \
    --transfers 2 --buffer-size 512M --drive-chunk-size 32M --low-level-retries 200 --drive-acknowledge-abuse --daemon