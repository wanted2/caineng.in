#!/bin/sh

if [[ -d 'www' ]]; then
    cd www;
    echo '\ngoogle_analytics: '${GA_STAGING_ID}'\n' >> _config.yml;
    JEKYLL_ENV=staging bundle exec jekyll build
else
    exit 1;
fi