FROM alpine/git:2.40.1 AS git-clone

RUN mkdir /repos; \
    git clone https://github.com/bebbo/amiga-gcc.git /repos/amiga-gcc --depth 1; \
    git clone https://github.com/BartmanAbyss/vscode-amiga-debug.git /repos/vscode-amiga-debug --depth 1

# The ubuntu:latest tag points to the "latest LTS", since that's the version recommended for general use.
# FROM ubuntu:latest AS builder

# ARG DEBIAN_FRONTEND=noninteractive
# # ARG GCC_VER
# ARG REPOS_PATH
# # ARG FILES_PATH
# # ARG CLIB2_REPO

# COPY --from=walkero/lha-on-docker /usr/bin/lha /usr/bin/lha

# ENV PACKAGES="autoconf \
#     automake \
#     autopoint \
#     bison \
#     ca-certificates \
#     curl \
#     dejagnu \
#     dh-autoreconf \
#     expect \
#     flex \
#     g++-10 \
#     gettext \
#     git \
#     gperf \
#     libfl2 \
#     libgmp-dev \
#     libmpc3 \
#     libmpc-dev \
#     libtool \
#     make \
#     mc \
#     nano \
#     patch \
#     python3 \
#     rsync \
#     texinfo \
#     wget \
#     xz-utils"

# RUN apt-get update && \
#     apt-get -y --no-install-recommends install ${PACKAGES}; \
#     ln -s /usr/bin/g++-10 /usr/bin/g++; \
#     rm /usr/bin/gcc; \
#     ln -s /usr/bin/gcc-10 /usr/bin/gcc;


# # Add necessary repos
# COPY --from=git-clone /repos/vscode-amiga-debug /opt/vscode-amiga-debug

# WORKDIR /opt/vscode-amiga-debug

# RUN ci/binutils-gdb/clone.sh; \
#     ci/binutils-gdb/download-prerequisites.sh; \
#     ci/binutils-gdb/configure-linux.sh; \
#     ci/binutils-gdb/build-linux.sh; \
#     ci/gcc/download.sh; \
#     ci/gcc/patch.sh; \
#     ci/gcc/download-prerequisites.sh; \
#     # TODO: Change the prefix below
#     ci/gcc/configure-linux.sh; \ 
#     ci/gcc/build.sh;

# UP TO HERE TO compile vscode-amiga-debug
################################################################################

# WORKDIR /tmp
# RUN curl -fsSL "https://github.com/BartmanAbyss/vscode-amiga-debug/archive/refs/tags/1.7.2.tar.gz" -o /tmp/vscode-amiga-debug.tar.gz 

# RUN tar xzvpf vscode-amiga-debug.tar.gz && \
#     cp -r ./vscode-amiga-debug-*/bin/linux /opt/m68k-amiga; 

# && \
# 		lha -xfq2 FlexCat.lha && \
# 		cp ./FlexCat/Linux-i386/flexcat /usr/bin/ && \
# 		rm -rf /tmp/*;

# ENV PACKAGES="autoconf \
#     automake \
#     autopoint \
#     bison \
#     ca-certificates \
#     curl \
#     dh-autoreconf \
#     flex \
#     g++-10 \
#     gettext \
#     git \
#     gperf \
#     libfl2 \
#     libgmp-dev \
#     libmpc3 \
#     libmpc-dev \
#     libtool \
#     make \
#     mc \
#     nano \
#     patch \
#     python3 \
#     rsync \
#     texinfo \
#     wget \
#     xz-utils"

# RUN dpkg --add-architecture i386 && apt-get update && \
#     apt-get -y --no-install-recommends install ${PACKAGES}; \
#     ln -s /usr/bin/g++-10 /usr/bin/g++; \
#     rm /usr/bin/gcc; \
#     ln -s /usr/bin/gcc-10 /usr/bin/gcc;

# # Add necessary repos
# ADD ${REPOS_PATH}/adtools /opt/adtools
# ADD ${REPOS_PATH}/binutils-gdb /opt/adtools/binutils/repo
# ADD ${REPOS_PATH}/coreutils /opt/adtools/coreutils/repo
# ADD ${REPOS_PATH}/gnulib /opt/adtools/gnulib/repo
# ADD ${REPOS_PATH}/misc /opt/misc

# # Get custom makefiles before we compile GCC
# COPY ${FILES_PATH}/native-build/makefile /opt/adtools/native-build/makefile

# # Compile gcc
# WORKDIR /opt/adtools
# RUN git config --global user.email "walkero@gmail.com"; \
#     git config --global user.name "Georgios Sokianos"; \
#     git submodule init && \
#     git submodule update && \
#     gild/bin/gild checkout binutils 2.23.2 && \
#     gild/bin/gild checkout gcc ${GCC_VER} && \
#     make -C native-build gcc-cross CROSS_PREFIX=/opt/ppc-amigaos \
#     CLIB2_REPO=${CLIB2_REPO} -j4; \
#     apt-get -y remove ${PACKAGES} \
#         curl \
#         python3; \
#     apt-get -y autoremove; \
#     apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /opt/adtools /opt/misc;

FROM ubuntu:latest
LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"
COPY --from=git-clone /repos/vscode-amiga-debug/bin/linux/opt /opt/m68k-amigaos

RUN mv /opt/m68k-amigaos/m68k-amiga-elf/sys-include /opt/m68k-amigaos/m68k-amiga-elf/sys-include_bak

COPY --from=git-clone /repos/amiga-gcc/sys-include /opt/m68k-amigaos/m68k-amiga-elf/sys-include
