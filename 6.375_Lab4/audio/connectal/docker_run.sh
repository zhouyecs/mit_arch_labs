# delete the running docker container
docker ps -a
docker stop `docker ps -a | grep kazutoiris/connectal | awk 'stop {print $1}'`
docker rm   `docker ps -a | grep kazutoiris/connectal | awk 'rm {print $1}'`

# run the docker container and detach it
docker run -id --name connectal kazutoiris/connectal
CID=`docker ps -a | grep connectal | awk '{print $1}'`

# start
# Problem 1
docker cp ../../../6.375_Lab4 $CID:/
docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make -j8 simulation
docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make run_simulation
docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID cmp out.pcm ../data/mitrib_pa8_2_2.pcm
docker cp $CID:/6.375_Lab4/audio/connectal/bluesim ./bluesim/