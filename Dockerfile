FROM verilator/verilator:v5.016 as build

RUN apt-get update && apt-get install -y \
  cmake \
  ninja-build \
  && rm -rf /var/lib/apt/lists/*

COPY Makefile /work/
COPY ./cosim /work/cosim
COPY ./src /work/src

ENV COMPILE_STATIC=true

RUN make build

FROM scratch

COPY --from=build /work/build/Vmain /Vmain

ENTRYPOINT ["/Vmain"]

# ENTRYPOINT ["sh", "-c", "sleep infinity"]
