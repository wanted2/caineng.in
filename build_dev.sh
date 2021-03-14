#!/bin/sh

if [[ -d 'www' ]]; then
    cd www;
    export GA_DEV_ID=G-FAKEID;
    echo '\ngoogle_analytics: '${GA_DEV_ID}'\n' >> _config.yml;
    JEKYLL_ENV=development bundle exec jekyll build
else
    exit 1;
fi