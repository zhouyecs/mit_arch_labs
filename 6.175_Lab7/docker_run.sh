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
# docker exec -u 0 --workdir / $CID rm -rf 6.175_Lab7
# docker cp ../6.175_Lab7 $CID:/
# docker exec -u 0 --workdir /6.175_Lab7/programs/assembly $CID make
# docker exec -u 0 --workdir /6.175_Lab7/programs/benchmarks $CID make

# Exercise 1 & Discussion 1
# docker exec -u 0 --workdir /6.175_Lab7 $CID make build.bluesim VPROC=WITHOUTCACHE
# docker exec -u 0 --workdir /6.175_Lab7 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab7 $CID ./run_bmarks.sh

# Exercise 2 & Discussion 2
# docker exec -u 0 --workdir /6.175_Lab7 $CID make build.bluesim VPROC=WITHCACHE
# docker exec -u 0 --workdir /6.175_Lab7 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab7 $CID ./run_bmarks.sh
