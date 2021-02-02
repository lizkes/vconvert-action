FROM lizkes/vconvert:latest

SHELL ["/bin/bash", "-c"]
ARG CLIENT_ID=a
ARG CLIENT_SECRET=a
ARG TOKEN=a
ARG TEAM_DRIVE=a
ARG ROOT_FOLDER=a
COPY ./rclone.conf /root/.config/rclone/rclone.conf
RUN sed 's@CLIENT_ID@'"$CLIENT_ID"'@' /root/.config/rclone/rclone.conf && sed 's@CLIENT_SECRET@'"$CLIENT_SECRET"'@' /root/.config/rclone/rclone.conf \
    && sed 's@TOKEN@'"$TOKEN"'@' /root/.config/rclone/rclone.conf && sed 's@TEAM_DRIVE@'"$TEAM_DRIVE"'@' /root/.config/rclone/rclone.conf \
    && sed 's@ROOT_FOLDER@'"$ROOT_FOLDER"'@' /root/.config/rclone/rclone.conf
RUN apt-get install -y fuse unzip curl && curl https://rclone.org/install.sh | bash \
    && mkdir -p /mnt/gdrive && rclone mount gdrive:/ /mnt/gdrive --umask 0000 --default-permissions --allow-other --allow-non-empty \
    --transfers 2 --buffer-size 512M --drive-chunk-size 32M --low-level-retries 200 --drive-acknowledge-abuse --daemon