FROM registry.gitlab.com/askapsdp/all_yandasoft:base
RUN apt-get update --fix-missing
RUN apt-get upgrade -y
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN apt-get install -y g++ 
RUN apt-get install -y git 
RUN apt-get install -y cmake 
RUN apt-get install -y xsltproc 
RUN apt-get install -y zeroc-ice-all-dev 
RUN apt-get install -y zeroc-ice-all-runtime 
RUN apt-get install -y libczmq-dev
RUN useradd -m user && yes password | passwd user
