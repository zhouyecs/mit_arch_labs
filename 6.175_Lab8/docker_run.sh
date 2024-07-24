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
# docker exec -u 0 --workdir / $CID rm -rf 6.175_Lab8
# docker cp ../6.175_Lab8 $CID:/
# docker exec -u 0 --workdir /6.175_Lab8/programs/assembly $CID make
# docker exec -u 0 --workdir /6.175_Lab8/programs/benchmarks $CID make

# Exercise 1
# docker exec -u 0 --workdir /6.175_Lab8 $CID make build.bluesim VPROC=EXCEP
# docker exec -u 0 --workdir /6.175_Lab8 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab8 $CID ./run_bmarks.sh
# docker exec -u 0 --workdir /6.175_Lab8 $CID ./run_excep.sh
# docker exec -u 0 --workdir /6.175_Lab8 $CID ./run_permit.sh