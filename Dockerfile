FROM ubuntu:18.04

ENV PATH /usr/local/texlive/2019/bin/x86_64-linux:$PATH
COPY texlive.profile /tmp/texlive-install/

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        curl \
        perl \
        make \
        ca-certificates \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L ftp://tug.org/historic/systems/texlive/2019/install-tl-unx.tar.gz \
  | tar -zxv --strip-components=1 --directory=/tmp/texlive-install && \
    /tmp/texlive-install/install-tl --profile=/tmp/texlive-install/texlive.profile && \
    rm -rf /tmp/texlive-install
RUN tlmgr install \
        collection-langjapanese \
        collection-latexrecommended

CMD [ "/bin/bash" ]
