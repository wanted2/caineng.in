#!/bin/sh

if [[ -d 'www' ]]; then
    cd www;
    export GA_DEV_ID=G-FAKEID;
    echo '\ngoogle_analytics: '${GA_DEV_ID}'\n' >> _config.yml;
    JEKYLL_ENV=development bundle exec jekyll build;
    export GA_DEV=$(grep -e ${GA_DEV_ID} -f _site/index.html)
    if [ "${GA_DEV}" -eq "" ]; then 
        echo ${GA_DEV};
        exit 1;
    fi
else
    exit 1;
fi