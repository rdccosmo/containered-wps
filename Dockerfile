FROM rdccosmo/wrf

ENV LD_LIBRARY_PATH_WRF $PREFIX/lib/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH_WRF:$LD_LIBRARY_PATH
ENV NCARG_ROOT=$PREFIX
ENV PATH=$NCARG_ROOT/bin:$PATH
ENV NETCDF $PREFIX
RUN ulimit -s unlimited

RUN wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/libpng-1.2.50.tar.gz && \
    tar -zxvf libpng-1.2.50.tar.gz && \
    rm -f libpng-1.2.50.tar.gz && \
    cd libpng-1.2.50 && \
    CPPFLAGS=-I$PREFIX/include LDFLAGS=-L$PREFIX/lib ./configure --prefix=$PREFIX && \
    make && \
    make install && cd .. && \ 
    wget http://www2.mmm.ucar.edu/wrf/OnLineTutorial/compile_tutorial/tar_files/jasper-1.900.1.tar.gz && \
    tar -zxvf jasper-1.900.1.tar.gz && \
    rm -f jasper-1.900.1.tar.gz && \
    cd jasper-1.900.1 && \
    ./configure --prefix=$PREFIX && \
    make && \
    make install && cd .. && \ 
    wget http://www2.mmm.ucar.edu/wrf/src/WPSV3.7.TAR.gz && \
    tar -zxvf WPSV3.7.TAR.gz && \
    rm -f WPSV3.7.TAR.gz && \
    cd WPS && \
    echo 1 | NCARG_ROOT=$PREFIX PATH=$NCARG_ROOT/bin:$PATH NETCDF=$PREFIX ./configure && \
    ./compile

