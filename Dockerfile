FROM rocker/tidyverse
MAINTAINER Andrew Heiss andrewheiss@gmail.com

# Install Python and Java
RUN apt-get update \
    && apt-get install -y \
        # Python
        python3-pip python3-dev \
        # Java
        liblzma-dev libbz2-dev default-jre default-jdk \
        # GSL (for topicmodels)
        gsl-bin libgsl0-dev\
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip \
    && R CMD javareconf

# Install spacy
RUN pip install spacy \
    && python -m spacy download en

# Install project-specific packages
RUN install2.r --error --deps TRUE \
        tidytext gutenbergr cleanNLP udpipe \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
