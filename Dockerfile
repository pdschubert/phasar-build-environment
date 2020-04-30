FROM ubuntu:latest

LABEL Name=phasar Version=1.0.0

RUN apt-get -y update && apt-get install bash sudo -y

WORKDIR /usr/src/phasar
RUN mkdir -p /usr/src/phasar/utils

COPY ./utils/InitializeEnvironment.sh /usr/src/phasar/utils/
RUN ./utils/InitializeEnvironment.sh

COPY ./utils/InstallAptDependencies.sh /usr/src/phasar/utils/
RUN ./utils/InstallAptDependencies.sh

RUN pip3 install Pygments pyyaml

# installing boost
RUN apt-get install libboost-all-dev -y

# installing LLVM
COPY utils/install-llvm.sh /usr/src/phasar/utils/install-llvm.sh
RUN ./utils/install-llvm.sh $(nproc) . "/usr/local/" "llvmorg-10.0.0"

# install Z3
COPY utils/install-z3.sh /usr/src/phasar/utils/install-z3.sh
RUN ./utils/install-z3.sh $(nproc) . "z3-4.8.7"

# installing wllvm
RUN pip3 install wllvm

ENV CC /usr/local/bin/clang
ENV CXX /usr/local/bin/clang++

# COPY . /usr/src/phasar
# 
# RUN mkdir -p build &&                       \
#     cd build &&                             \
#     cmake -DCMAKE_BUILD_TYPE=Release .. &&  \
#     make -j $(nproc) &&                     \
#     make install &&                         \
#     ldconfig
# 
# ENTRYPOINT [ "./build/tools/phasar-llvm/phasar-llvm" ]