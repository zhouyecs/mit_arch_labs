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
最后发现蹊跷，Makefile的编译选项删除“-Xc++ D_GLIBCXX_USE_CXX11_ABI=0”或者改成“-Xc++ D_GLIBCXX_USE_CXX11_ABI=1”，pass。  
查了一下，详见：https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dual_abi.html 和 https://developers.redhat.com/blog/2015/02/05/gcc5-and-the-c11-abi  
简而言之，就是新旧版的兼容问题。（怎么没有小贴士呢？
#### problem 2
写一个module mkLinearFFT。  
参考figure2，mkCombinationalFFT  
参考pdf L05-FoldedandPipeliendCircuits  
使用fifo实现，使用三个stage  
#### problem 3
写一个module mkCircularFFT。  
参考figure2，mkCombinationalFFT 
参考pdf L05-FoldedandPipeliendCircuits，pdf里称为folded  
使用if-else语句判断即可
#### problem 4
按照题目改就行
#### problem 5
按照题目指示的对应关系更改源代码即可，例如8->TSub#(tnp1, 1), 9->tnp1
#### problem 6
按照题目指示，再把FFT_POINTS->fft_points，ComplexSample->Complex#(cmplxd)替换即可
#### problem 7
只要在对应参数位置加上provisos (Add#(2, a__, fft_points))，无需添加其他要求就足以pass  
其他要求还在研究......

### lab3
#### problem 1
如果需要测试pitch.c（虽然没什么用），需要首先 `sudo apt install libfftw3-dev`。  
创建了两个static变量inphases和outphases，在bsv中应该在rule外使用vector保存  
因为需要输出到out(fifo)中，所以在bsv中，先创建一个Vector out_data并初始化，再循环结束后再enq进out(fifo)中  
在if中，outphases[bin]先增加shifted，然后在输入到out中，在bsv中，需要注意均需要增加shifted  
bsv的各种类型很容易搞晕：(  
#### problem 2
在pitch.c的`fftw_execute(forward);`前后输出，然后将其复制到PitchAdjustTest.bsv即可   
#### problem 3
参考figure3，From和To都是Complex和ComplexMP之间的转换，  
From和To之间的代码也可以复用
#### problem 4&5
按照figure3，参考lab2文件，import需要的模块  
注意提前创建factor： `FixedPoint#(I_SIZE, P_SIZE) factor = 2.0;`  
和lab2不同，这里的x是vector，所以需要遍历进行tocmplx()frcmplx()