#!/bin/sh

sudo apt-get install -y emacs terminator gcc gdb valgrind tree bison flex qemu iverilog \
	git python3.7 python3.7-dev graphviz xdot gtkwave python3-venv \
	python3-dev cmake make libboost-python-dev libboost-filesystem-dev \
	libboost-thread-dev libboost-program-options-dev tcl tcl-dev clang clang-format libreadline-dev \
	libboost-iostreams-dev libqt5opengl5-dev libeigen3-dev libudev-dev libboost-all-dev \
	libftdi1 libftdi1-dev python3-pip autoconf gperf tk-dev tk8.5-dev apt-file \
	swig python3-tk libgsl-dev libcurl4-openssl-dev libssl-dev openssl libx11-dev \
	libcairo2-dev libxaw7-dev libtcl8.6 ccache libgoogle-perftools-dev numactl perl-doc \
	asciidoctor lcov libpod-latex-perl texlive-fonts-recommended
	#       csh tcsh shc rc zsh ksh ash

cpan install -y Pod::Perldoc
cpan install -y Parallel::Forker

cd ~/
mkdir .toolchain
cd .toolchain

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
make install
cd ..
