FROM debian:buster
ARG VARIANT=2019

COPY texlive.profile /tmp/texlive-install/

# add non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME}

# dependency
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        curl \
        perl \
        make \
        ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# texlive
RUN curl -L ftp://tug.org/historic/systems/texlive/${VARIANT}/tlnet-final/install-tl-unx.tar.gz \
  | tar -zxv --strip-components=1 --directory=/tmp/texlive-install \
    && /tmp/texlive-install/install-tl \
        --profile=/tmp/texlive-install/texlive.profile \
        --repository "ftp://tug.org/historic/systems/texlive/${VARIANT}/tlnet-final" \
    && rm -rf /tmp/texlive-install
ENV PATH="/usr/local/texlive/${VARIANT}/bin/x86_64-linux:${PATH}"
RUN tlmgr install \
        collection-langjapanese \
        collection-latexrecommended

CMD [ "/bin/bash" ]
