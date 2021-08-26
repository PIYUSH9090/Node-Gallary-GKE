#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED BuildNodeGallaryLogicDocker ***
***************
'
    echo "An error occurred BuildNodeGallaryLogicDocker . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e
# TODO make this as bash variable.
# TODO Make this on every file ?
LEVEL=NONDEBUG
if [ "$LEVEL" == "DEBUG" ]; then
	echo "Level is DEBUG.Press Enter to continue."
	read levelIsDebug	
else
	echo "Level is NOT DEBUG. There will be no wait."	
fi
#InstallNodeGallaryLogicLocally.sh
#Kill the process
unset DOCKER_HOST
unset DOCKER_TLS_VERIFY
unset DOCKER_TLS_PATH
echo "Trying to login. If you are NOT logged in, there will be a prompt"
docker login


# It will print the log folder wise
echo "Building node-gallary-logic"
docker build -f Dockerfile -t piyush9090/node-gallary-logic .
# Now image building is done 
# So now we will push that image to dockerhub
echo "Pushing node-gallary-logic"
docker push piyush9090/node-gallary-logic
# Here we run the container with that port 5050:5050
echo "Running node-gallary-logic"
# Do not run when building it takes a port away
docker run -d -p 5050:5050 piyush9090/node-gallary-logic &
sleep 5
echo "List of containers running now"
docker container ls -a

NodeGallaryLogicId="$(docker container ls -f ancestor="piyush9090/node-gallary-logic" -f status=running -aq)"
echo " The one we just started is : $NodeGallaryLogicId"

if [ -n "$NodeGallaryLogicId" ]; then
  echo "node-gallary container is running $(docker container ls -f ancestor=piyush9090/node-gallary-logic -f status=running -aq) :) "
else
  echo "ERROR: node-gallary is NOT running. :(  . Please Check logs/NodeGallary-logic.log"
  exit 1
fi

trap : 0

echo >&2 '
************
*** DONE BuildNodeGallaryLogicDocker ***
************'