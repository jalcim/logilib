FROM verilator/verilator:v5.016

RUN apt-get update && apt-get install -y \
  cmake \
  && rm -rf /var/lib/apt/lists/*

COPY ./scripts /work/scripts
COPY ./cosim /work/cosim
COPY ./src /work/src


RUN ./scripts/verilator.sh

ENTRYPOINT ["sh", "-c", "./build/Vmain"]
