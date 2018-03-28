# swagger2html

This Dockerfile create a [Docker](http://docker.com) image to convert swagger yaml to html.

## Description

The docker container which is run from this image convert the swagger 2.0 yaml file to html file using below:

* [swagger2markup-cli](https://github.com/Swagger2Markup/swagger2markup-cli.git)
* [Asciidoctor](https://asciidoctor.org)

## Install

Pull `nmatsui/swagger2html` from DockerHub:

```bash
docker pull nmatsui/swagger2html
```

Or build `nmatsui/swagger2html` from Dockerfile:

```bash
git clone https://github.com/nmatsui/swagger2html.git
cd swagger2html
docker build -t nmatsui/swagger2html .
```

## Usage

In the directory of swagger file, run this image with mounting current directory and with swagger filename as a command argument:

```bash
docker run --volume $(pwd):/mnt nmatsui/swagger2html swagger_filename.yaml
```

## License

[MIT License](/LICENSE)

## Copyright
Copyright (c) 2018 Nobuyuki Matsui <nobuyuki.matsui@gmail.com>

