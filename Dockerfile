FROM lizkes/vconvert:latest

SHELL ["/bin/bash", "-c"]
COPY setup.sh /setup.sh
RUN /setup.sh && rm /setup.sh