
# https://github.com/jawg/docker-mapnik3/blob/master/v3.0.16/Dockerfile
FROM jawg/mapnik3:3.0.16

ENV PYTHON_MAPNIK_VERSION v3.0.16

ENV MAPNIK_BUILD_DEPENDENCIES="libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-thread-dev \
    libboost-system-dev \
    libcairo-dev \
    libfreetype6-dev \
    libgdal-dev \
    libharfbuzz-dev \
    libicu-dev \
    libjpeg-dev \
    libpq-dev \
    libproj-dev \
    librasterlite-dev \
    libsqlite3-dev \
    libtiff-dev \
    libwebp-dev"

ENV BUILD_DEPENDENCIES="build-essential \
    ca-certificates \
    git \
		python3-dev \
		python3-setuptools \
    libboost-python-dev \
    $MAPNIK_BUILD_DEPENDENCIES"

ENV DEPENDENCIES="python3 \
    libboost-python1.55.0"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        $BUILD_DEPENDENCIES $DEPENDENCIES \
    && git clone https://github.com/mapnik/python-mapnik.git \
    && cd python-mapnik \
    && git checkout $PYTHON_MAPNIK_VERSION \
    && python3 setup.py install \
		&& cd - \
		&& rm -r python-mapnik \
    && apt-get autoremove -y --purge $BUILD_DEPENDENCIES \
    && rm -rf /var/lib/apt/lists/*