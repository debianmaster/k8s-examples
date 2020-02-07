FROM dtzar/helm-kubectl:2.16.1
ENV USER_UID=1001
ENV OPERATOR=/tmp/run.sh
RUN set -x && \
    apk add --no-cache curl ca-certificates && \
    adduser kubectl -Du ${USER_UID}
WORKDIR /tmp
COPY run.sh /tmp/run.sh
COPY bin /usr/local/bin
RUN /usr/local/bin/user_setup
#USER ${USER_UID}
ENTRYPOINT ["/usr/local/bin/entrypoint"]



