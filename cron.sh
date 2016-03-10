RUBY=/usr/bin/ruby2.0
SCRIPT=generate.rb
OUTPUT_DIR=/usr/share/nginx/html
FILE_NAME=ip-feed.txt
TIMESTAMP=`date +%Y%m%d-%H%M%S`

cd `dirname $0`

$RUBY $SCRIPT > $OUTPUT_DIR/$FILE_NAME.$TIMESTAMP && \
ln -f -s $OUTPUT_DIR/$FILE_NAME.$TIMESTAMP $OUTPUT_DIR/$FILE_NAME
