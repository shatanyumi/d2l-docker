# 使用官方的 CUDA 镜像作为基础
FROM nvidia/cuda:11.3.1-base-ubuntu20.04

# 设置非交互模式，避免安装过程中的交互式提示
ENV DEBIAN_FRONTEND=noninteractive

# 设置时区为上海
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 使用 USTC 源
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 安装 Python 3.8 和必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    make \
    python3 \
    python3-dev \
    python3-pip \
    gdb \
    curl \
    unzip \
    wget \
    jupyter

# 安装 miniconda

# 下载并安装Miniconda
RUN mkdir -p ~/miniconda3 && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh &&\
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 &&\
    rm -rf ~/miniconda3/miniconda.sh && \
    ~/miniconda3/bin/conda init bash

# 将conda的bin目录添加到PATH中
ENV PATH="/root/miniconda3/bin:${PATH}"

# 安装环境
RUN /root/miniconda3/bin/conda create --name d2l python=3.9 -y
RUN /bin/bash -c "source /root/miniconda3/bin/activate d2l && python --version"

# CUDA 11.3
RUN pip3 install torch && \
    pip3 install torchvision && \
    pip3 install d2l

# 创建工作目录
RUN mkdir -p /workspace

# 清理不必要缓存文件
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 下载《动手学深度学习》的 Jupyter 笔记本文件
WORKDIR /workspace
RUN mkdir d2l-zh && cd d2l-zh && \
    curl https://zh-v2.d2l.ai/d2l-zh-2.0.0.zip -o d2l-zh.zip && \
    unzip d2l-zh.zip && rm d2l-zh.zip && \
    rm -rf /workspace/d2l-zh/mxnet && \
    rm -rf /workspace/d2l-zh/paddle && \
    rm -rf /workspace/d2l-zh/tensorflow

# 设置启动命令 指定目录
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--notebook-dir='/workspace/d2l-zh/pytorch'"]
