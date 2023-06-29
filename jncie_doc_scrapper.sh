#!/bin/bash

mkdir dump 2>/dev/null

# configure first page url
first_page="https://jigsaw.gilmoreglobal.com/books/EDU-JNCIE-SP-1A-E/pages/531297623/content"
# configure last page
last_page=531299032
# configure output file
output_file="jncie-sp_study_guide.pdf"

# generate a cookies.txt using valid credentials (without that will not work)

counter=1
actual_page=0

wget --user-agent="iMozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:76.0) Gecko/20100101 Firefox/76.0" -q --load-cookies cookies.txt ${first_page} -O content

while [[ "${last_page}" != "${actual_page}" ]]; do
	image_uri=$(cat <content | grep image | cut -d'"' -f4 | sed 's/800$/1600/')
	next_page=$(cat <content | grep nextPage | sed 's/.*"nextPage":{"path":"//' | cut -d'"' -f5)
	actual_page=$(cat <content | grep absoluteURL | sed 's/cfi.*//' | sed 's/.*absoluteURL":"//' | cut -d '/' -f5)
	root_uri='https://jigsaw.gilmoreglobal.com/'
	dump_page="dump/page_${counter}_${actual_page}.jpeg"
	if [[ ${actual_page} != "" ]]; then
		wget --user-agent="iMozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:76.0) Gecko/20100101 Firefox/76.0" -q --load-cookies cookies.txt "${root_uri}${image_uri}" -O "${dump_page}"
		counter=$((counter + 1))
		echo "${actual_page} - ${counter}"
		wget --user-agent="iMozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:76.0) Gecko/20100101 Firefox/76.0" -q --load-cookies cookies.txt "${root_uri}${next_page}" -O content
	fi
	random_time=$(echo $RANDOM % 10 + 1 | bc)
	sleep "${random_time}"
done

pages=$(find dump | sort -t'_' -k2 -n | tr '\n' ' ')
convert "$(echo -n "${pages}")" ${output_file}
