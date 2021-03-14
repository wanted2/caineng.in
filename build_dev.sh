#!/bin/sh

if [[ -d 'www' ]]; then
    cd www;
    JEKYLL_ENV=development bundle exec jekyll build
else
    exit 1;
fi