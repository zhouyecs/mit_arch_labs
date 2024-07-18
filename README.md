# mit_arch_labs

## 6.175
http://csg.csail.mit.edu/6.175/index.html

### lab5
第一个riscv实验最考验的其实是配环境，除了已有的docker容器，还需要自己编译 riscv-isa-sim 和 riscv-gcc-prebuilt。

需要完成的代码可以参考课件L10-L15，但是有些课件上的结构和题目要求不同，例如TwoCycle，课件中将decode放在了execute部分，而题目要求将其放在fetch部分

### lab6

区分：  
BTB(Branch Target Buffer)：记录分支指令跳转目标地址，使用PC的一部分用于寻址  
BHT(Branch History Table)：记录历史指令的跳转情况（跳还是不挑），也使用PC的一部分用于寻址  
RAS(Return Address Stack)：仅用于函数调用/返回的情况，需要判断指令是否JAL/JALR，若是，rd=x1入栈，rd=x0&rs1=x1时出栈  

### lab7



## 6.375
http://csg.csail.mit.edu/6.375/6_375_2019_www/handouts.html

### lab2
从这个 lab 开始，难度骤增，开始记录...
#### problem 1
Makefile 的编译选项删除 “-Xc++ D_GLIBCXX_USE_CXX11_ABI=0”或者改成“-Xc++ D_GLIBCXX_USE_CXX11_ABI=1”，pass。  
新旧版的兼容问题，详见：https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html 和 https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi  
#### problem 2
写一个 module mkLinearFFT。  
参考 figure2，mkCombinationalFFT  
参考 pdf L05-FoldedandPipeliendCircuits  
使用 fifo 实现，使用三个 stage  
#### problem 3
写一个 module mkCircularFFT。  
参考 figure2，mkCombinationalFFT 
参考 pdf L05-FoldedandPipeliendCircuits，pdf 里称为 folded  
使用 if-else 语句判断即可
#### problem 4
按照题目改就行
#### problem 5
按照题目指示的对应关系更改源代码即可，例如 8->TSub#(tnp1, 1), 9->tnp1
#### problem 6
按照题目指示，再把 FFT_POINTS->fft_points，ComplexSample->Complex#(cmplxd)替换即可
#### problem 7
只要在对应参数位置加上 provisos (Add#(2, a__, fft_points))，无需添加其他要求就足以pass  
其他要求还在研究......

### lab3
#### problem 1
如果需要测试 pitch.c（虽然没什么用），需要首先 `sudo apt install libfftw3-dev`。创建了两个 static 变量 inphases 和 outphases ，在 bsv 中应该在 rule 外使用 vector保存，因为需要输出到 out(fifo) 中，所以在 bsv 中，先创建一个 Vector out_data 并初始化，再循环结束后再 enq 进 out(fifo) 中，在 if 中，outphases[bin] 先增加 shifted，然后在输入到 out 中，在 bsv 中，需要注意均需要增加 shifted，bsv 的各种类型很容易搞晕：(  
#### problem 2
在 pitch.c 的`fftw_execute(forward);`前后输出，然后将其复制到 PitchAdjustTest.bsv 即可   
#### problem 3
参考figure3，From和To都是Complex和ComplexMP之间的转换，From 和 To 之间的代码也可以复用
#### problem 4&5
按照 figure3，参考 lab2 文件，import 需要的模块，注意提前创建 factor： `FixedPoint#(I_SIZE, P_SIZE) factor = 2.0;`和 lab2 不同，这里的 x 是 vector，所以需要遍历进行 tocmplx()frcmplx()

### lab4
第一次用docker
#### problem 1
注意在exec时，需要-u 0，即以root身份进入容器，否则会报错  
#### problem 2&3
按照教程修改代码即可，因为没有vivado，跳过problem 3
#### problem 4
按照教程修改代码即可，这时还无法make run_simualtion，需要等整个lab结束后才行，我卡了很久，被自己蠢到了
#### problem 5
除了setFactor，整个pipeline还暴露了两个interface：putSampleInput和getSampleOutput，注意修改。可以参考前面的pitchAdjust，创建一个settable的interface，包含三个interface
#### problem 6
按照教程修改代码即可，其中`pd`应该改为`pf`
#### problem 7
按照教程修改代码即可