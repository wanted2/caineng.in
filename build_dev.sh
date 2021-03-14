#!/bin/bash
if [[ -d 'www' ]]; then
    cd www;
    export GA_DEV_ID=G-FAKEID;
    echo 'google_analytics: '${GA_DEV_ID}'' >> _config.yml;
    JEKYLL_ENV=development bundle exec jekyll build;
    export GA_DEV=$(grep ${GA_DEV_ID} _site/index.html)
    if [ "${GA_DEV}" == "" ]; then 
        echo ${GA_DEV};
        exit 1;
    else
        echo "PASSED";
    fi
    sed -i '$ d' _config.yml
else
    exit 1;
fi
