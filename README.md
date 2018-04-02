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
docker run --rm --volume $(pwd):/mnt nmatsui/swagger2html swagger_filename.yaml
```

### the properties of swagger2markup

Default properties of swagger2markup are below:

```properties
swagger2markup.generatedExamplesEnabled=true
swagger2markup.tagOrderBy=AS_IS
swagger2markup.operationOrderBy=AS_IS
swagger2markup.definitionOrderBy=AS_IS
swagger2markup.parameterOrderBy=AS_IS
swagger2markup.propertyOrderBy=AS_IS
swagger2markup.responseOrderBy=AS_IS
```

If you put a `swagger2markup.properties` file at the same directory of target yaml file, you can customize the properties of swagger2markup.

Show below to understand the properties of swagger2markup:
[Swagger2Markup API Usage](https://github.com/Swagger2Markup/swagger2markup/blob/master/src/docs/asciidoc/usage_guide.adoc)

## License

[MIT License](/LICENSE)

## Copyright
Copyright (c) 2018 Nobuyuki Matsui <nobuyuki.matsui@gmail.com>
