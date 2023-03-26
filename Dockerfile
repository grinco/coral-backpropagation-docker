ARG BUILD_FROM="ubuntu:20.04"
FROM ${BUILD_FROM}

WORKDIR /tmp

RUN apt-get update && apt-get install -y gnupg curl
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | tee /etc/apt/sources.list.d/coral-edgetpu.list
RUN echo "deb https://packages.cloud.google.com/apt coral-cloud-stable main" | tee /etc/apt/sources.list.d/coral-cloud.list

RUN apt-get update && apt-get install -y python3 wget unzip python3-pip
RUN apt-get -y install python3-pycoral

RUN apt-get -y install git

RUN mkdir -p /edgetpu/retrain-backprop
WORKDIR /edgetpu/retrain-backprop
ENV WORKDIR=/edgetpu/retrain-backprop

RUN wget http://download.tensorflow.org/example_images/flower_photos.tgz
RUN tar zxf flower_photos.tgz -C $WORKDIR

RUN wget https://github.com/google-coral/test_data/raw/master/mobilenet_v1_1.0_224_quant_embedding_extractor_edgetpu.tflite -P $WORKDIR
RUN wget https://github.com/google-coral/test_data/raw/master/efficientnet-edgetpu-M_quant_embedding_extractor_edgetpu.tflite -P $WORKDIR

RUN git clone https://github.com/google-coral/pycoral.git

CMD [ "/bin/bash" ]

