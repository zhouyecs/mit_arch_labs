# delete the running docker container
docker ps -a
docker stop `docker ps -a | grep connectal | awk '{print $1}'`
docker rm   `docker ps -a | grep connectal | awk '{print $1}'`

# run the docker container and detach it
docker run -id --name connectal kazutoiris/connectal
CID=`docker ps -a | grep connectal | awk '{print $1}'`

docker cp ../../../6.375_Lab4 $CID:/

# start
# Problem 1 & 2
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make -j8 simulation
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make run_simulation
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID cmp out.pcm ../data/mitrib_pa8_2_2.pcm
# docker cp $CID:/6.375_Lab4/audio/connectal/bluesim ./bluesim/

# Problem 3, no vivado so skip
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make -j8 fpga
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make -j8 fpgaUpdateSW
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make program_fpga
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make run_fpgaSW
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make run_fpga

# Problem 7
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID make -j8 simulation
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID bluesim/bin/ubuntu.exe 2.0
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID cmp out.pcm ../data/mitrib_pa8_2_2.pcm
# no vivado so skip
# docker exec -u 0 --workdir /6.375_Lab4/audio/connectal $CID ARG1=2.0 make run_simulation