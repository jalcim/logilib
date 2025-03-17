
FROM ubuntu:latest as deps

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*

FROM deps as yosys-build

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y git \
  build-essential clang bison flex \
  libreadline-dev gawk tcl-dev libffi-dev git \
  graphviz xdot pkg-config python3 libboost-system-dev \
  libboost-python-dev libboost-filesystem-dev zlib1g-dev \
  libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/yosysHQ/yosys /yosys
RUN cd /yosys && git submodule init && git submodule update --init && make -j 4

FROM deps as build
COPY --from=yosys-build /yosys/yosys /usr/local/bin/yosys
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cmake \
  ninja-build \
  build-essential \
  verilator \
  # yosys \
  libtcl8.6\
  && rm -rf /var/lib/apt/lists/*
WORKDIR /work
COPY CMakeLists .
COPY src ./src
COPY scripts ./scripts
COPY synth/ ./synth
COPY cosim ./cosim
COPY veriform ./veriform
RUN make build


# RUN make build
FROM deps
COPY --from=build /work/build/Vmain /
RUN mkdir cosim
COPY cosim/settings.ini /cosim
RUN apt install libboost-log1.83.0 \
&& rm -rf /var/lib/apt/lists/*

ENV LOG_LEVEL=trace
ENTRYPOINT ["/Vmain"]

# ENTRYPOINT ["sh", "-c", "sleep infinity"]
