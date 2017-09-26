# docker-nodejs8action

[OpenWhisk](https://openwhisk.incubator.apache.org) nodejs8action Dockerfile based on official node:8.5-slim with headless chrome / puppeteer.

## Usage
```
$ wsk action create demo --docker smizy/nodejs8action main.js 
$ wsk action invoke demo --result --param name Akira
{
    "msg": "Hello Akira! version = HeadlessChrome/63.0.3205.0!"
}
```