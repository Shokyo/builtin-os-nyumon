FROM ubuntu:22.04
RUN apt update

RUN apt install sudo build-essential cu m4 wget
RUN mkdir source && cd source

RUN wget https://ftp.gnu.org/gnu/binutils/binutils-2.36.tar.xz
RUN tar xf binutils-2.36.tar.xz && cd binutils-2.36/
RUN ./configure --prefix=/usr/local --target=h8300-elf --disable-nls
RUN make && make install && cd ../

RUN wget https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz  && tar xvf gmp-6.2.1.tar.xz && cd gmp-6.2.1
RUN ./configure && make && make check && sudo make install && sudo ldconfig
RUN cd ../

RUN wget https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.xz && tar xf mpfr-4.1.0.tar.xz && cd mpfr-4.1.0
RUN ./configure && make && make check && sudo make install && sudo ldconfig
RUN cd ../

RUN wget https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz && tar xf mpc-1.2.1.tar.gz && cd mpc-1.2.1
RUN ./configure && make && make check && sudo make install && sudo ldconfig
RUN cd ../

RUN wget https://ftp.gnu.org/gnu/gcc/gcc-10.2.0/gcc-10.2.0.tar.xz && tar xf gcc-10.2.0.tar.xz
RUN mkdir build && cd build
RUN ../gcc-10.2.0/configure --target=h8300-elf --disable-nls --disable-threads --disable-shared --enable-languages=c --disable-libssp
RUN make -j4 && sudo make install
RUN cd ../
