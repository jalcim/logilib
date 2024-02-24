
FROM ubuntu:mantic as deps

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \

  && rm -rf /var/lib/apt/lists/*

# FROM deps as yosys-build
# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
#   build-essential clang bison flex \
# 	libreadline-dev gawk tcl-dev libffi-dev git \
# 	graphviz xdot pkg-config python3 libboost-system-dev \
# 	libboost-python-dev libboost-filesystem-dev zlib1g-dev \
#   && rm -rf /var/lib/apt/lists/*
# COPY ./yosys /yosys
# RUN cd /yosys && make -j

FROM deps as build
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  cmake \
  ninja-build \
  libboost-all-dev \
  build-essential \
  verilator \
  yosys \
  libtcl8.6\
  && rm -rf /var/lib/apt/lists/*
WORKDIR /work
COPY Makefile .
COPY ./src ./src
COPY ./scripts ./scripts
COPY ./synth/ ./synth
COPY ./cosim ./cosim
RUN make build -j


# RUN make build
FROM ubuntu:22.04
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*
COPY --from=build /work/build/Vmain /
RUN mkdir cosim
COPY cosim/settings.ini /cosim
ENV LOG_LEVEL=trace
ENTRYPOINT ["/Vmain"]

# ENTRYPOINT ["sh", "-c", "sleep infinity"]
