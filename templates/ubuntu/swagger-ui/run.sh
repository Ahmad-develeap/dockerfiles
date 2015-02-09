#!/bin/sh

# vim: filetype=sh:tabstop=2:shiftwidth=2:expandtab

readonly PROGNAME=$(basename $0)
readonly PROJECTDIR="$( cd "$(dirname "$0")" ; pwd -P )"
readonly PROJECT=$(basename $PROJECTDIR)

readonly NGINX_CMD=$(which nginx)
readonly NGINX_ROOT_DIR="/swagger"
readonly SWAGGER_DATA_DIR="/swagger-data"
readonly SWAGGER_SPEC_FILE="$SWAGGER_DATA_DIR/swagger.json"

readonly SWAGGER_TEMPLATE_DIR="/swagger-ui-templates"
readonly SWAGGER_ORIG_INDEX_FILE="$SWAGGER_TEMPLATE_DIR/index.orig"
readonly SWAGGER_TMPL_INDEX_FILE="$SWAGGER_TEMPLATE_DIR/index.tmpl"

readonly WHOAMI=$(whoami)

prereq()
{

  if [ -z "$NGINX_CMD" ]; then
  	echo "The nginx runtime does not appear to be installed. Please install and re-run this script."
  	exit 1
  fi
  
  if [ -d "$NGINX_ROOT_DIR" ]; then
  	echo "The '$NGINX_ROOT_DIR' directory does not exist. Content from this directory is served up by nginx."
  	exit 1
  fi
  
  if [ -d "$SWAGGER_TEMPLATE_DIR" ]; then
  	echo "The '$SWAGGER_TEMPLATE_DIR' directory does not exist. This directory and it's templates are required to render content correctly."
  	exit 1
  fi
  
  if [ -d "$SWAGGER_DATA_DIR" ]; then
  	echo "The '$SWAGGER_DATA_DIR' directory does not exist. This directory can be empty, but it must exist."
  	exit 1
  fi
  
}

run()
{
 
  if [ -f "$SWAGGER_SPEC_FILE" ]; then

    cp $SWAGGER_ORIG_INDEX_FILE $SWAGGER_ROOT_DIR/index.html
    touch -d '-15 seconds' /tmp/limit $SWAGGER_ROOT_DIR/index.html
    echo "No $SWAGGER_SPEC_FILE found.  Refreshing with $SWAGGER_ORIG_INDEX_FILE"
    
  else
    
    touch -d '-15 seconds' /tmp/limit
    if [ /tmp/limit -ot $SWAGGER_SPEC_FILE ]; then
      local spec_file_contents=$(cat $SWAGGER_SPEC_FILE)
      cp $SWAGGER_TMPL_INDEX_FILE $SWAGGER_ROOT_DIR/index.html
      sed -i 's/###-->ZZZ_URL_SPEC_NOTATION<--###/spec/g' $SWAGGER_ROOT_DIR/index.html
      sed -i 's/###-->ZZZ_URL_SPEC_CONTENT<--###/$spec_file_content/g' $SWAGGER_ROOT_DIR/index.html
      echo "$SWAGGER_SPEC_FILE found.  Refreshing nginx content."
    else
      echo "$SWAGGER_SPEC_FILE found.  No need to refresh nginx content."
    fi
   
  fi
}

clean()
{
  echo ""
  echo "Removing any crusty temp file"
  rm -rf /tmp/limit
}

main()
{
  prereq
  
  while true, do
    run 
    sleep 5 
  done

  clean
}

main
