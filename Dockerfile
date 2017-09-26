FROM openwhisk/nodejs6action as nodejs6action

# ----------

FROM node:8.5.0-slim

COPY --from=nodejs6action /nodejsAction  /nodejsAction

WORKDIR /nodejsAction

RUN set -x \
    && yarn install \
    ## - refer  https://github.com/apache/incubator-openwhisk/blob/master/core/nodejs6Action/Dockerfile
    && yarn add \
apn@2.1.2 \
async@2.1.4 \
body-parser@1.15.2 \
btoa@1.1.2 \
cheerio@0.22.0 \
cloudant@1.6.2 \
commander@2.9.0 \
consul@0.27.0 \
cookie-parser@1.4.3 \
cradle@0.7.1 \
errorhandler@1.5.0 \
express@4.14.0 \
express-session@1.14.2 \
glob@7.1.1 \
gm@1.23.0 \
lodash@4.17.2 \
log4js@0.6.38 \
iconv-lite@0.4.15 \
marked@0.3.6 \
merge@1.2.0 \
moment@2.17.0 \
mongodb@2.2.11 \
mustache@2.3.0 \
nano@6.2.0 \
node-uuid@1.4.7 \
nodemailer@2.6.4 \
oauth2-server@2.4.1 \
openwhisk@3.3.2 \
pkgcloud@1.4.0 \
process@0.11.9 \
pug@">=2.0.0-beta6 <2.0.1" \
redis@2.6.3 \
request@2.79.0 \
request-promise@4.1.1 \
rimraf@2.5.4 \
semver@5.3.0 \
sendgrid@4.7.1 \
serve-favicon@2.3.2 \
socket.io@1.6.0 \
socket.io-client@1.6.0 \
superagent@3.0.0 \
swagger-tools@0.10.1 \
tmp@0.0.31 \
twilio@2.11.1 \
underscore@1.8.3 \
uuid@3.0.0 \
validator@6.1.0 \
watson-developer-cloud@2.29.0 \
when@3.7.7 \
winston@2.3.0 \
ws@1.1.1 \
xml2js@0.4.17 \
xmlhttprequest@1.8.0 \
yauzl@2.7.0    

# See app.js
CMD node --expose-gc app.js

## ------------------------------
## Headless chrome / puppeteer
## -------------------------------
RUN set -x \
    ## - chrome dependencies
    && apt-get update \
    && apt-get install -yq \
        libasound2 \
        libatk1.0-0 \
        libcups2 \
        libgconf-2-4 \
        libgtk-3-0 \
        libnss3 \
        libx11-xcb1 \ 
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxi6 \
        libxrandr2 \
        libxss1 \
        libxtst6 \

    ## - noto font cjk
    && apt-get install \
        unzip \
    && mkdir -p \
        /root/.fonts \
        /root/.config/fontconfig \
        /tmp/noto \
    && curl -sSL -o /tmp/noto/noto_sans.zip https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
    && cd /tmp/noto \
    && unzip -o noto_sans.zip \
    && mv *.otf /root/.fonts/ \
    && cd / \
    && rm -rf /tmp/noto \
    && fc-cache -fv \
    && fc-match \

COPY fonts.conf   /root/.config/fontconfig

RUN set -x \
    && yarn add \
        archiver \
        async-await-parallel \
        # commander \
        # express \
        mv \
        progress \
        puppeteer \
        # socket.io \
        split 


# node_modules/puppeteer/.local-chromium/linux-497674/chrome-linux/chrome


ENV PATH         $PATH:/nodejsAction/node_modules/.bin:/node_modules/.bin
# ENV CHROME_PATH  /usr/local/bin/chrome

