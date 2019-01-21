FROM base/archlinux

LABEL maintainer.name="an9wer"
LABEL maintainer.email="an9wer@gmail.com"

SHELL ["/bin/bash", "-c"]

USER root:root
ENV SETUP /root/setup
COPY --chown=root:root setup/*.sh ${SETUP}/
RUN pacman -Syu --noconfirm
RUN ${SETUP}/timezone.sh
RUN ${SETUP}/locale.sh
RUN ${SETUP}/ssh.sh
RUN ${SETUP}/user.sh
RUN ${SETUP}/basetools.sh

USER an9wer:wheel
ENV SETUP_AN9WER /home/an9wer/setup
COPY --chown=an9wer:wheel setup_an9wer/*.sh ${SETUP_AN9WER}/
RUN ${SETUP_AN9WER}/verice.sh

EXPOSE 22
