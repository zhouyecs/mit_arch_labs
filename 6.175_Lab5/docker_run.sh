# delete the running docker container
docker ps -a
docker stop `docker ps -a | grep connectal | awk '{print $1}'`
docker rm   `docker ps -a | grep connectal | awk '{print $1}'`

# run the docker container and detach it
docker run -id --name connectal kazutoiris/connectal
CID=`docker ps -a | grep connectal | awk '{print $1}'`

# 慢慢配环境吧 
# https://github.com/riscv-software-src/riscv-isa-sim
# https://github.com/stnolting/riscv-gcc-prebuilt
# https://github.com/sifive/elf2hex(unnecessary)

# init
# docker exec -u 0 --workdir / $CID rm -rf 6.175_Lab5
# docker cp ../6.175_Lab5 $CID:/
# docker exec -u 0 --workdir /6.175_Lab5/programs/assembly $CID make
# docker exec -u 0 --workdir /6.175_Lab5/programs/benchmarks $CID make

# Exercise 0
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=ONECYCLE
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_bmarks.sh

# Exercise 1
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=TWOCYCLE
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_bmarks.sh

# Exercise 2
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=FOURCYCLE
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_bmarks.sh

# Exercise 3
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=TWOSTAGE
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_bmarks.sh

# Exercise 4
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=TWOSTAGEBTB
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_bmarks.sh