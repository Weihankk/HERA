# LocalHERA
![git](https://img.shields.io/badge/HERA-Local-brightgreen) 

Local Highly Efficient Repeat Assembly

## 项目介绍
将HERA流程拆分，并使用R重写了本地运行流程脚本。

HERA项目源地址：https://github.com/liangclab/HERA

本人邮箱：whzhang@webmail.hzau.edu.cn

本人QQ：97578011

## 本人的小疑问
- 没有光谱和Hi-C，CANU+HERA的结果可以拿来基于现有参考基因组去scaffolding吗？ 
- HERA的结果需要验证才可以？文章中的conflict是啥意思？本人才疏学浅，希望可以交流提升。。。

## 使用方法
#### 首先把我整理好的脚本克隆一波
```
git clone https://github.com/Weihankk/LocalHERA.git
cd LocalHERA
chmod 755 *
```
- 本项目仅对HERA源代码有一处改动： 把`21-Daligner_New.pl`的第100行注释掉了，不让其自动提交pbs脚本   
- 本项目额外增加了共20个脚本，其中19个LocalHERA*.R, 1个Final_Formating.sh
- 注意查看这些R脚本中的bwa路径，修改成自己服务器对应的路径

#### 克隆好之后，拿HERA自带的测试数据进行测试
```
vi LocalHERA_Parameters.R
```
- 请自行修改工作目录，以及数据、工具路径
-----------------------------------

#### 假设你修改好了，那就开始运行，开车！:car::taxi::articulated_lorry::police_car::minibus::truck::ambulance:
- 第1步：注意检查脚本中BWA路径，因为我服务器中的bwa版本比较新，HERA使用的是`bwa-0.7.10`，需要用到`-e`参数，BWA近几年的版本取消了这个参数，所以需要各位自行下载bwa-0.7.10版本。
```
Rscript LocalHERA_Run1.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第2步：在上一步中将某个文件拆分成了100个fasta，在这一步需要进行100次比对，由于用的是bwa去比对长序列，速度十分慢，即使给了多线程也依然提不起速度，计算资源占用达不到预期，因此可以根据自己计算资源酌情多提交些。
```
Rscript LocalHERA_Run2.R LocalHERA_Parameters.R 1 10   #提交第1-10个任务,
Rscript LocalHERA_Run2.R LocalHERA_Parameters.R 11 30   #提交第21-30个任务

………………

Rscript LocalHERA_Run2.R LocalHERA_Parameters.R 1 100   #也可以这样直接把100个任务全提交
```
- 其他无特殊交代，正常运行结束即可，注意检查是否所有任务都运行结束了，个别任务运行速度极慢。
------------------------------

- 第3步：
```
Rscript LocalHERA_Run3.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第4步：对一些文件建bwa索引。
```
Rscript LocalHERA_Run4.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可，注意检查是否所有任务都运行结束了，个别任务运行速度极慢。
------------------------------

- 第5步：相互比对，此步骤极慢，巨慢，炒鸡慢。
```
Rscript LocalHERA_Run5.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可，注意检查是否所有任务都运行结束了，个别任务运行速度极慢。
------------------------------

- 第6步：比对后的文件处理。
```
Rscript LocalHERA_Run6.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可，注意检查是否所有任务都运行结束了。
------------------------------

- 第7步：依然是比对后的文件处理。
```
Rscript LocalHERA_Run7.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可，注意检查是否所有任务都运行结束了。
------------------------------

- 第8步：
```
Rscript LocalHERA_Run8.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第9步： 开始Daligner步骤，此处我将集群任务提交分解成了本地循环提交，按步运行即可。
```
Rscript LocalHERA_Run9.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第10步： 依然是Daligner。
```
Rscript LocalHERA_Run10.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第11步： 还是Daligner。
```
Rscript LocalHERA_Run11.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第12步： 又是Daligner。
```
Rscript LocalHERA_Run12.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第13步：又又是Daligner，此步可以修改daligner的线程数，默认一次提交5个任务，每个任务8个线程，可以将线程数提高。
```
Rscript LocalHERA_Run13.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第14步： 又又又是Daligner。
```
Rscript LocalHERA_Run14.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第15步： 又又又又又是Daligner。
```
Rscript LocalHERA_Run15.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第16步： 又又又又又又是Daligner。
```
Rscript LocalHERA_Run16.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第17步： 最后一步Daligner。
```
Rscript LocalHERA_Run17.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------

- 第18步： 结束。
```
Rscript LocalHERA_Run18.R LocalHERA_Parameters.R
```
- 其他无特殊交代，正常运行结束即可。
------------------------------


