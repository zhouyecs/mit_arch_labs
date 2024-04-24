# mit_arch_labs

## 6.175
http://csg.csail.mit.edu/6.175/index.html

## 6.375
http://csg.csail.mit.edu/6.375/6_375_2019_www/handouts.html

### lab2
从这个lab开始，难度骤增，开始记录...
#### problem 1
按照提示，一上来就报错。（我：？）
我对着别人的代码找半天，还是报错。（我：？）
最后发现蹊跷，Makefile的编译选项删除“-Xc++ D_GLIBCXX_USE_CXX11_ABI=0”
或者改成“-Xc++ D_GLIBCXX_USE_CXX11_ABI=1”，pass。
查了一下，详见：https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html 和 https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi，
简而言之，就是新旧版的兼容问题。（怎么没有小贴士呢？
#### problem 2
写一个module mkLinearFFT (FFT)。
参考figure2，mkCombinationalFFT
1、使用fifo实现，使用三个stage
2、使用vector实现，进行循环