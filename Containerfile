FROM python:3.11-slim-bullseye as build
ARG UID=1000
ARG GID=1000
ENV SETUP_UID=${UID}
ENV SETUP_GID=${GID}
ADD --chown=root:root conf/container/system /root/conf
RUN bash /root/conf/system.sh


FROM build as user
USER app:app
ENV HOME=/home/app
ENV VENV=$HOME/venv
ENV PATH=$VENV/bin:$PATH
ADD --chown=app:app conf/container/user $HOME/conf
RUN bash $HOME/conf/user.sh


FROM user as dev
VOLUME [ "/home/app/repo" ]
WORKDIR $HOME/repo
CMD bash


FROM user as app
RUN mkdir -p $HOME/log
VOLUME [ "/home/app/log" ]
# Copy source
ADD --chown=app:app . $HOME/repo
ENV DEBUG=False
# Setup venv
RUN python -m venv $VENV
# Setup Python path
RUN echo "$HOME/repo/src" > $VENV/lib/python3.11/site-packages/repo.pth
WORKDIR $HOME/repo
RUN pip install -r requirements.txt
CMD bash
