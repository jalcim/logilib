FROM verilator/verilator:v5.016 as build

RUN apt-get update && apt-get install -y \
  cmake \
  ninja-build \
  libboost-all-dev \
  && rm -rf /var/lib/apt/lists/*

COPY Makefile /work/
COPY ./cosim /work/cosim
COPY ./src /work/src

ENV LOG_LEVEL=trace

RUN make build

ENTRYPOINT ["./build/Vmain"]

# ENTRYPOINT ["sh", "-c", "sleep infinity"]
