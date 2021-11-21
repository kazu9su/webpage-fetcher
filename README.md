# WebpageFetcher

## How to run fetch command on Docker

```shell
$ docker-compose up
$ docker exec -it webpage_fetcher bash
$ ./fetch --metadata https://google.com
```

## Assets download - how to do -
First of all, I would need to consider to save each url contents to independent directories because the name conflicts would happen.
Also, I would need to care some implied files, like index.html.

The result would be like this diagram.

```
./
 └ www.google.com
    ├ js/...
    ├ images/...
    └ index.html
```
