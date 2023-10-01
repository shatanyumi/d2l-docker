# d2l-environment
Docker images for "Dive into Deep Learning".

## Overview
This repository provides Docker images to help users easily set up their environment for [Dive into Deep Learning(PyTorch)](https://d2l.ai/). Using Docker ensures that all users, regardless of their local setup, can have a consistent and reproducible environment.

## Tested Environments

This Docker image has been successfully tested on the following hardware configurations:

- **Laptop Model**: Dell 3579
  - **CPU**: Intel® Core™ i5-8300H × 8
  - **GPU**: NVIDIA GTX1050 4G
  - **DRAM**: 8G + 16G

## Setting up Docker for GPU

To utilize the NVIDIA GPU when running the Docker container, you'll need to set up NVIDIA support for Docker.

### Prerequisites

1. Ensure you have an NVIDIA GPU and the [NVIDIA System Management Interface](https://developer.nvidia.com/nvidia-system-management-interface) installed. You can check by running:
   ```
   nvidia-smi
   ```

2. Install the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker):
   ```bash
   # Add the package repositories
   distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
   curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
   curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

   sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
   sudo systemctl restart docker
   ```

### Running the Docker Container with GPU Support

To run the container with NVIDIA GPU support, use the `--gpus` flag:

```bash
docker run --gpus all -it nxhss/d2l-pytorch:latest
```

(optional) I run the container on my labtop:

```bash
sudo docker run --runtime=nvidia --gpus all -d -p 8888:8888 --name d2l nxhss/d2l-pytorch:latest
```

## Getting Started

### Prerequisites

Install [Docker](https://www.docker.com/get-started) on your machine.

### Pulling the Docker Image

To get the latest Docker image, run:

```
docker pull nxhss/d2l-pytorch:latest
```

### Building the Docker Image (Optional)

If you'd like to build the image yourself:

1. Clone this repository:

```
git clone https://github.com/shatanyumi/d2l-environment.git
cd d2l-environment
```

2. Build the Docker image:

```
docker build . --file Dockerfile --tag your-repo-name/d2l-pytorch:latest
```

2. Build the Docker image with proxys:

```
docker build . --file Dockerfile --tag your-repo-name/ --build-arg HTTPS_PROXY="http://IP:PORT" d2l-pytorch:latest
```

## Contributing
We welcome contributions! Please see our [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Note

The content above is written by ChatGPT4. Feel free to laugh about the errors. After all, machines don’t make mistakes(Hahhh).