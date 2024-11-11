# davydany/sidecar

A sidecar container for debugging and troubleshooting in Kubernetes.

**Website:** https://github.com/davydany/sidecar

## Usage

**Docker:**

```bash
docker run -it --rm davydany/sidecar bash
```

**Kubernetes:**

```bash
kubectl run -it --rm --image=davydany/sidecar sidecar -- bash
```

## What's in the sidecar?
### Supported Clients:
* Official PostgreSQL Client (psql)
* PostgreSQL CLI (pgcli)
  - Pgcli is a command line interface for Postgres with auto-completion and syntax highlighting. (https://www.pgcli.com/)
* Official Redis Client (redis-cli)
* Official Elasticsearch Client (curl - 😬)
* Kafkacat (kafkacat)

### Supported Languages:
* Python 3 (Python 3.12.7)
* OpenJDK 11 JRE (openjdk 11.0.25 2024-10-15)
* Go (go version go1.22.8 linux/arm64)

### Supported Text Editors
* Vim
* Nano

### Supported Shells
* Bash
* Zsh

### Supported Tools
* curl (`curl` - https://curl.se/)
* jq (`jq` - https://stedolan.github.io/jq/)
* kubectl (`kubectl` - https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* awscli (`aws` - https://aws.amazon.com/cli/)
* httpie (`http` or `https` - https://httpie.io/docs/cli/examples)
* kaf (`kaf` - https://github.com/birdayz/kaf)

## Build Locally

**Build the image**

```bash
make build
```

**Build and Run the container**

```bash
make build-and-run
```

**Test Locally**

```bash
make up
```

**Stop the container**

```bash
make down
```

**Access the container**

```bash
make exec
```

# Support and Contribution

* If you need help, please reach out to me at `davydany@gmail.com`
* If you have a feature request, please open an issue.
* If you want to contribute, please submit a pull request.
* If you found a bug, please open an issue.

**More Details:** https://github.com/davydany/sidecar
