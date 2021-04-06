#!/bin/sh

sudo apt-get install -y emacs terminator gcc gdb valgrind tree bison flex qemu iverilog \
	git graphviz xdot gtkwave python3-venv python3 \
	python3-dev cmake make libboost-python-dev libboost-filesystem-dev \
	libboost-thread-dev libboost-program-options-dev tcl tcl-dev clang clang-format libreadline-dev \
	libboost-iostreams-dev libqt5opengl5-dev libeigen3-dev libudev-dev libboost-all-dev \
	libftdi1 libftdi1-dev python3-pip autoconf gperf tk-dev tk8.5-dev apt-file \
	swig python3-tk libgsl-dev libcurl4-openssl-dev libssl-dev openssl libx11-dev \
	libcairo2-dev libxaw7-dev libtcl8.6 ccache libgoogle-perftools-dev numactl perl-doc \
	asciidoctor lcov libpod-latex-perl texlive-fonts-recommended libglib2.0-dev libfdt-dev \
	libpixman-1-dev zlib1g-dev git-email libaio-dev libbluetooth-dev libbrlapi-dev libbz2-dev \
	libcap-dev libcap-ng-dev libgtk-3-dev libibverbs-dev \
	libncurses5-dev libnuma-dev librbd-dev librdmacm-dev libsasl2-dev libsdl1.2-dev \
	libseccomp-dev libsnappy-dev libssh2-1-dev libvde-dev libvdeplug-dev \
	libxen-dev liblzo2-dev xfslibs-dev libjpeg62-turbo-dev
#       csh tcsh shc rc zsh ksh ash libjpeg8-dev libcurl4-gnutls-dev

cpan install -y Pod::Perldoc
cpan install -y Parallel::Forker

cd ~/
mkdir .toolchain
cd .toolchain

mkdir python
cd python
wget https://www.python.org/ftp/python/3.9.4/Python-3.9.4.tar.xz
tar -xf Python-3.9.4.tar.xz
cd Python-3.9.4
./configure
make
make test
sudo make install
cd ../..

git clone https://github.com/Kitware/CMake
cd CMake
git pull
./bootstrap
make -j8
sudo make install
sudo rm /usr/bin/cmake
sudo ln -s /usr/local/bin/cmake /usr/bin/cmake
cd ..

git clone --recursive https://github.com/Symbiflow/prjtrellis
git pull
cd prjtrellis/libtrellis
cmake -DCMAKE_INSTALL_PREFIX=/usr .
make -j8
sudo make install
cd ../..

git clone https://github.com/steveicarus/iverilog
git pull
cd iverilog
sh autoconf.sh
./configure
make -j8
make check
sudo make install
cd ..

git clone https://github.com/verilator/verilator
cd verilator
git pull
export VERILATOR_ROOT=`pwd`
export PATH=$VERILATOR_ROOT/bin:$PATH
autoconf
./configure
make -j8
sudo make install
cd ..

git clone https://github.com/YosysHQ/yosys
cd yosys
git pull
make -j8
sudo make install
make test
cd ..

git clone https://github.com/YosysHQ/nextpnr
cd nextpnr
git pull
cmake -DARCH=ecp5 -DTRELLIS_INSTALL_PREFIX=/usr .
make -j8
sudo make install
cd ..

git clone https://github.com/trabucayre/openFPGALoader
cd openFPGALoader
git pull
mkdir build
cd build
cmake ../
make -j8
sudo make install
cd ../..

git clone https://github.com/rubund/graywolf
cd graywolf
git pull
mkdir build
cd build
cmake ..
make -j8
make test
sudo make install
cd ../..

git clone https://github.com/RTimothyEdwards/qrouter/
cd qrouter
git pull
./configure
make -j8
sudo make install
cd ..

git clone https://github.com/The-OpenROAD-Project/OpenSTA
cd OpenSTA
git pull
mkdir build
cd build
cmake ..
make -j8
sudo make install
cd ../..

git clone https://github.com/RTimothyEdwards/netgen
cd netgen
git pull
./configure
make -j8
sudo make install
cd ..

git clone https://github.com/RTimothyEdwards/magic
cd magic
git pull
./configure
make -j8
sudo make install
cd ..

git clone https://github.com/RTimothyEdwards/qflow
cd qflow
git pull
./configure
make -j8
sudo make install
cd ..

git clone git://opencircuitdesign.com/open_pdks
cd open_pdks
git pull
./configure --enable-sky130-pdk
make -j8
sudo make install
cd ..

git clone git://opencircuitdesign.com/xcircuit
cd xcircuit
git pull
./configure
make -j8
sudo make install
cd ..

git clone git://opencircuitdesign.com/irsim
cd irsim
git pull
./configure
make -j8
sudo make install 
cd ..

git clone git://opencircuitdesign.com/pcb
cd pcb
git pull
./configure
make -j8
sudo make install
cd ..

git clone https://github.com/ninja-build/ninja
cd ninja
cmake -Bbuild-cmake -H.
cmake --build build-cmake
cd build-cmake
sudo ln ninja /usr/bin/ninja
cd ../..

git clone https://github.com/qemu/qemu
cd qemu
mkdir build
cd build
../configure
make -j8
cd ../..
