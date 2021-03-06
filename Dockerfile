FROM lizkes/vconvert:latest

ARG CLIENT_ID=a
ARG CLIENT_SECRET=a
ARG TOKEN=a
ARG TEAM_DRIVE=a
ARG ROOT_FOLDER=a
RUN apt-get install -y fuse unzip curl && curl https://rclone.org/install.sh | bash
COPY ./rclone.conf /root/.config/rclone/rclone.conf
RUN sed -i 's@CLIENT_ID@'"$CLIENT_ID"'@' /root/.config/rclone/rclone.conf && sed -i 's@CLIENT_SECRET@'"$CLIENT_SECRET"'@' /root/.config/rclone/rclone.conf \
    && sed -i 's@TOKEN@'"$TOKEN"'@' /root/.config/rclone/rclone.conf && sed -i 's@TEAM_DRIVE@'"$TEAM_DRIVE"'@' /root/.config/rclone/rclone.conf \
    && sed -i 's@ROOT_FOLDER@'"$ROOT_FOLDER"'@' /root/.config/rclone/rclone.conf && mkdir -p /vconvert
CMD rclone mount gdrive:/ /vconvert --umask 0000 --default-permissions --allow-other --allow-non-empty --transfers 2 \
    --vfs-cache-mode full --vfs-read-chunk-size-limit 4096M --vfs-cache-max-size 4096M --buffer-size 4096M \
    --drive-chunk-size 4096M --low-level-retries 200 --log-file /rclone.log --log-level DEBUG --drive-acknowledge-abuse --daemon \
    && sleep 3s && python3 -m app.run
