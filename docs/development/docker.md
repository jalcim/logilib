# Docker & CI/CD

Container build and continuous integration.

## Docker

### Build Image

```bash
docker build -t logilib .
```

### Run Tests

```bash
docker run logilib
```

### Dockerfile

The `Dockerfile` at the repository root contains:
- Base image with Verilator, Icarus, CMake, Ninja
- Boost libraries for co-simulation
- Build and test execution

## GitLab CI/CD

### Pipeline Stages

| Stage | Description |
|-------|-------------|
| `build` | Build Docker image |
| `test` | Run test suite |
| `release` | Tag release image |
| `pages` | Build documentation |

### Configuration

`.gitlab-ci.yml` defines the pipeline:

```yaml
stages:
  - build
  - test
  - release
  - pages
```

### Build Stage

Builds the Docker image and pushes to GitLab Container Registry.

### Test Stage

Runs the test suite inside the container.

### Release Stage

Tags successful builds on `master` as `latest`.

### Pages Stage

Builds MkDocs documentation and deploys to GitLab Pages:

```yaml
pages:
  stage: pages
  image: python:3.11
  script:
    - pip install mkdocs mkdocs-material
    - mkdocs build --site-dir public
  artifacts:
    paths:
      - public
  only:
    - master
```

## Local Development

### Without Docker

```bash
# Install dependencies (Fedora)
sudo dnf install verilator iverilog boost-devel cmake ninja-build

# Build
cmake -S. -Bbuild -GNinja
cmake --build build

# Test
./scripts/run_tests.sh
```

### With Docker

```bash
# Build and run
docker build -t logilib .
docker run -it logilib bash

# Inside container
./scripts/run_tests.sh
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `LOG_LEVEL` | Logging level | `warning` |
| `VERILATOR_TIME_STEP` | Simulation time step | `1000` |
