#!/bin/bash
if [[ -d 'www' ]]; then
    cd www;
    echo 'google_analytics: '${GA_STAGING_ID}'' >> _config.yml;
    JEKYLL_ENV=development bundle exec jekyll build;
    export GA=$(grep ${GA_STAGING_ID} _site/index.html)
    if [ "${GA}" == "" ]; then 
        echo ${GA};
        exit 1;
    else
        echo "PASSED";
    fi
    sed -i '$ d' _config.yml
else
    exit 1;
fi
