# 基于Arch Linux的conky,系统资源监视

#### 须知这些炫酷的配置经过自己曾***几个月***的努力;  
你可以随意修改在发布,但请注明我的[→ Github地址](https://github.com/wo2ni)  
请不要将这些用于任何商业用途,以及其他营销手段;

### 自己的Conky配置;
[![2021-01-22-01-16-12.png](https://i.postimg.cc/qMWnYDQ9/2021-01-22-01-16-12.png)](https://postimg.cc/HV4V82q2)

### system-monitoring
[![2021-01-22-12-29-06.png](https://i.postimg.cc/wBLk0Ypf/2021-01-22-12-29-06.png)](https://postimg.cc/Ty2m3Shg)

### parrot-monitoring
[![2021-01-22-12-30-28.png](https://i.postimg.cc/QtS1yXnb/2021-01-22-12-30-28.png)](https://postimg.cc/k662VdC6)

## 最新版本的conky配置语法已改变,使用lua;  
为了激进,此页面将提供所需的所有工具;

## 安装教程;
### Arch Linux  
- [→ 单击下载打包好的conky-lua-nv](https://github.com/wo2ni/Arch_Conky/releases/download/V0.1/conky-lua-nv-1.11.6-2-x86_64.pkg.tar.zst)
```
pacman -Syy git ksh lsof   #必须的依赖;
git clone https://github.com/wo2ni/Arch_Conky.git
cd Arch_Conky && chmod +x install.sh 
./install.sh
```

### Debian/Ubuntu
```
apt-get update && apt-get install git conky conky-all
git clone https://github.com/wo2ni/Arch_Conky.git
cd Arch_Conky && chmod +x install.sh 
./install.sh
```

### 字体的问题;
#### 若为正确安装字体,conky将不能正常运行,  
最简单那的方法,下载并安装本人提供的字体包;
- [→ 本人的字体包,单击下载](https://github.com/wo2ni/Arch_Conky/releases/download/V0.1/fonts.tar.bz2)

### 旧版conky配置格式转换
```
git clone https://github.com/wo2ni/Arch_Conky.git
cd Arch_Conky && chmod +x convert.lua 
./convert.lua 旧版配置文件 新版配置文件
```

- [→ 本人永久的Github地址](https://github.com/wo2ni)
- [→ Lua教程网址](http://www.runoob.com/lua/)
