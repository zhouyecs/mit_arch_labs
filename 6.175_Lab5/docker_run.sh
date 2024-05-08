# delete the running docker container
docker ps -a
docker stop `docker ps -a | grep connectal | awk '{print $1}'`
docker rm   `docker ps -a | grep connectal | awk '{print $1}'`

# run the docker container and detach it
docker run -id --name connectal kazutoiris/connectal
CID=`docker ps -a | grep connectal | awk '{print $1}'`

docker cp ../6.175_Lab5 $CID:/

# start
# Problem 1 & 2
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=ONECYCLE
# docker cp $CID:/6.175_Lab5./bluesim/
