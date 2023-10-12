FROM verilator/verilator:v5.016 as build

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  cmake \
  ninja-build \
  libboost-all-dev \
  git \
  build-essential clang bison flex \
	libreadline-dev gawk tcl-dev libffi-dev git \
	graphviz xdot pkg-config python3 libboost-system-dev \
	libboost-python-dev libboost-filesystem-dev zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN cd / && git clone https://github.com/anonkey/yosys
RUN cd /yosys && make -j && make install

COPY Makefile /work/
COPY ./src /work/src
COPY ./scripts /work/scripts
COPY ./synth/alu/arithm/verilog/CMakeLists.txt /work/synth/alu/arithm/verilog/CMakeLists.txt
RUN make synthesis


ENV LOG_LEVEL=trace

COPY ./cosim /work/cosim
RUN make build

ENTRYPOINT ["./build/Vmain"]

# ENTRYPOINT ["sh", "-c", "sleep infinity"]
