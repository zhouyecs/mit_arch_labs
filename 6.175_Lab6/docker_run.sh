# delete the running docker container
docker ps -a
docker stop `docker ps -a | grep connectal | awk '{print $1}'`
docker rm   `docker ps -a | grep connectal | awk '{print $1}'`

# run the docker container and detach it
docker run -id --name connectal kazutoiris/connectal
CID=`docker ps -a | grep connectal | awk '{print $1}'`

# 慢慢配环境吧 
# https://github.com/riscv-software-src/riscv-isa-sim （先clone到本地，在复制到docker里）
# https://github.com/stnolting/riscv-gcc-prebuilt

# init
# docker exec -u 0 --workdir / $CID rm -rf 6.175_Lab6
# docker cp ../6.175_Lab6 $CID:/
# docker exec -u 0 --workdir /6.175_Lab6/programs/assembly $CID make
# docker exec -u 0 --workdir /6.175_Lab6/programs/benchmarks $CID make

# Discussion 1
# docker exec -u 0 --workdir /6.175_Lab6 $CID make build.bluesim VPROC=TWOSTAGE
# docker exec -u 0 --workdir /6.175_Lab6 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab6 $CID cat logs/cache.log

# Exercise 1
# docker exec -u 0 --workdir /6.175_Lab6 $CID make build.bluesim VPROC=SIXSTAGE
# docker exec -u 0 --workdir /6.175_Lab6 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab6 $CID ./run_bmarks.sh
# docker cp $CID:/6.175_Lab6/logs ./logs
