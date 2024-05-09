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

# git clone https://github.com/cambridgehackers/connectal
# curl http://www.dabeaz.com/ply/ply-3.9.tar.gz | tar -zvxf -

# docker exec -u 0 --workdir / $CID rm -rf 6.175_Lab5
# docker cp ../6.175_Lab5 $CID:/

# init
# docker exec -u 0 --workdir /6.175_Lab5 $CID ln -s ply-3.9/ply/ connectal/scripts/
# docker exec -u 0 --workdir /6.175_Lab5 $CID sed -i 's/python script/python3 script/g' connectal/Makefile


# Exercise 0
# docker exec -u 0 --workdir /6.175_Lab5/programs/assembly $CID make
# docker exec -u 0 --workdir /6.175_Lab5/programs/benchmarks $CID make
# docker exec -u 0 --workdir /6.175_Lab5 $CID make build.bluesim VPROC=ONECYCLE
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_asm.sh
# docker exec -u 0 --workdir /6.175_Lab5 $CID ./run_bmarks.sh





# docker cp $CID:/6.175_Lab5./bluesim/
