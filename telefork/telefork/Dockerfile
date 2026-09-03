FROM rust:1.41

RUN apt-get update
RUN apt-get install rr --yes
RUN apt-get install psmisc htop tmux
RUN rustup component add rust-src

RUN mkdir -p /workspace
RUN ln -s /usr/src/telefork /workspace/telefork

VOLUME /usr/src/telefork
WORKDIR /usr/src/telefork
