FROM alpine:3.7
MAINTAINER Nobuyuki Matsui <nobuyuki.matsui@gmail.com>

RUN apk update && apk upgrade && \
    apk --no-cache add bash git openjdk8 ruby && \
    git clone https://github.com/Swagger2Markup/swagger2markup-cli.git /opt/swagger2markup-cli && \
    cd /opt/swagger2markup-cli && \
    ./gradlew jar && \
    mv /opt/swagger2markup-cli/build/libs/swagger2markup-*.jar /usr/local/lib/swagger2markup-cli.jar && \
    ./gradlew clean && \
    cd / && \
    rm -rf /root/.gradle && \
    rm -rf /opt/swagger2markup-cli && \
    gem install -N asciidoctor

WORKDIR /opt
RUN echo $'swagger2markup.generatedExamplesEnabled=true\n\
swagger2markup.tagOrderBy=AS_IS\n\
swagger2markup.operationOrderBy=AS_IS\n\
swagger2markup.definitionOrderBy=AS_IS\n\
swagger2markup.parameterOrderBy=AS_IS\n\
swagger2markup.propertyOrderBy=AS_IS\n\
swagger2markup.responseOrderBy=AS_IS\n\
swagger2markup.pathsGroupedBy=TAGS' > /opt/swagger2markup.properties
RUN echo $'#!/bin/sh \n\
if [ $# -ne 1 ]; then\n\
  echo "usage: docker run --volume \$(pwd):/mnt nmatsui/swagger2html swagger_filename.yaml"\n\
  exit 1\n\
fi\n\
YAML_FILE=$1\n\
BASE_NAME=${YAML_FILE%.*}\n\
if [ ! -e /mnt/${YAML_FILE} ]; then\n\
  echo "${YAML_FILE} not found"\n\
  exit 1\n\
fi\n\
PROPERTIES="/opt/swagger2markup.properties"\n\
if [ -e /mnt/swagger2markup.properties ]; then\n\
  echo "use custom properties"\n\
  PROPERTIES="/mnt/swagger2markup.properties"\n\
fi\n\
java -jar /usr/local/lib/swagger2markup-cli.jar convert -c ${PROPERTIES} -i /mnt/${YAML_FILE} -f /mnt/${BASE_NAME}\n\
asciidoctor -a toc=left -a toclevels=3 /mnt/${BASE_NAME}.adoc\n\
exit 0' > /opt/entrypoint.sh && chmod 755 /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
