############################################################################################################################################

FROM ubuntu:18.04 as build

ENV BUILD_PACKAGES ca-certificates git build-essential cmake pkg-config libboost-all-dev libunbound-dev libminiupnpc-dev libunwind8-dev \
                   liblzma-dev libldns-dev libexpat1-dev libssl-dev autoconf automake check libpcre3-dev rapidjson-dev libreadline-dev

RUN apt-get update && apt-get install --no-install-recommends -y $BUILD_PACKAGES

RUN cd /opt && git clone --recursive https://github.com/graft-project/graft-ng.git && \
    cd graft-ng && \
    git checkout alpha3 && \
    git submodule update --init --recursive

RUN cd /opt/graft-ng && mkdir -p build && cd build && cmake -DENABLE_SYSLOG=ON -DBoost_USE_STATIC_LIBS=ON -DBoost_USE_STATIC_RUNTIME=ON .. && make -j$(nproc --all)

RUN mkdir /opt/graft && cp /opt/graft-ng/build/BUILD/cryptonode/bin/* /opt/graft && cp /opt/graft-ng/build/graft_server /opt/graft && cp /opt/graft-ng/build/config.ini /opt/graft

#RUN apt-get remove --purge -y $BUILD_PACKAGES && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

############################################################################################################################################

FROM ubuntu:18.04 as production

RUN apt-get update && apt-get install --no-install-recommends -y supervisor

COPY supervisor/etc/supervisor/ /etc/supervisor

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=build /opt/graft /opt

RUN mkdir /root/.graft

EXPOSE 28690

WORKDIR /opt

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]

############################################################################################################################################
