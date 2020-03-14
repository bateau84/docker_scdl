From ubuntu:18.04

ADD buildconfig /tmp/buildconfig
ADD prepare.sh /tmp/prepare.sh
ADD cleanup.sh /tmp/cleanup.sh
ADD --chown=1000:1000 scdl.cfg /.config/scdl/scdl.cfg
ADD --chown=1000:1000 scdl.sh /scdl.sh

RUN chmod +x /tmp/prepare.sh /tmp/cleanup.sh /scdl.sh \
    && /tmp/prepare.sh \
    && /tmp/cleanup.sh

USER scdl
ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "/scdl.sh" ]
