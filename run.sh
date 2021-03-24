#!/usr/bin/env bash
#
######################################
#---基于Arch Linux动态壁纸生成程序   #
#-枯燥乏味的生活需要一丝丝激情,      #
#-每天面对死气沉沉的桌面死的心都有了 #
#---GNOME,桌面动态壁纸生成程序       #
######################################
#
#--Color Code;
C_ls="\033[0m"
R_ed="\033[1;31m"
G_reen="\033[1;32m"
Y_ellow="\033[1;33m"

#--Cache;
> /tmp/lun.txt > /dev/null 2>&1
X='/tmp/lun.txt'        #壁纸索引临时文件;
Image_file='/usr/share/backgrounds/gnome'      #自述壁纸路径;
Image_readme='/usr/share/gnome-background-properties'      #描述自述壁纸的路径;
readonly Image_file Image_readme X

#--init初始;
I_nit() {
    #---xml文件名;
    printf "${G_reen}输入xml文件名,${Y_ellow}例如love${C_ls}\n"
    read -p "请输入文件名:" file_name

    #---图片切换时间;
    printf "${G_reen}输入图片切换时间,${Y_ellow}例如60${C_ls}\n"
    read -p "请输入切换图片间隔时间:" switch_time
    if $(echo $switch_time |grep -q '^[Aa-Zz]') || $(echo $switch_time |grep -q '[Aa-Zz]'); then
        printf "${R_ed}警告!!!错误的输入,${G_reen}你应该输入:${C_ls}\n"
        exit 1
    else

        #---图片过渡时间;
        read -p "请输入图片过渡时间:" filter_time
        if $(echo $filter_time |grep -q '^[Aa-Zz]') || $(echo $filter_time |grep -q '[Aa-Zz]'); then
            printf "${R_ed}警告!!!错误的输入,${G_reen}你应该输入:${C_ls}\n"
            exit 1
        else
            readonly file_name switch_time filter_time
            Image_lun
            Back_read
            Back_image
        fi
    fi
}

#--图片类型判断,建立壁纸轮寻索引函数;
Image_lun() {
    for i in *
    do
        len3="$(xxd -p -l 3 ${i})"
        len4="$(xxd -p -l 4 ${i})"
        if [ $len3 == "ffd8ff" ]; then  #JPG;
            printf "`pwd`/${i}\n" >> ${X}
        elif [ $len4 == "89504e47" ]; then  #PNG;
            printf "`pwd`/${i}\n" >> ${X}
        elif [ $len4 == "52494646" ]; then  #WEBP;
            printf "`pwd`/${i}\n" >> ${X}
        fi
    done
}

#--/usr/share/gnome-background-properties/*  #壁纸背景xml描述xml生成;
Back_read() {
    cat << EOF > ${Image_readme}/${file_name}.xml
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>Default Background</name>
    <filename>/usr/share/backgrounds/gnome/${file_name}-image.xml</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
    <pcolor>#3465a4</pcolor>
    <scolor>#000000</scolor>
  </wallpaper>
</wallpapers>
EOF
}

#--最后的首尾工作,xml剪裁;
Xml_cai() {
    for i in $(cat ${X})
    do
        ((b+=1))
        printf "<static>\n"
        printf "<duration>${filter_time}</duration>\n"
        printf "  <file>${i}</file>\n"
        printf "</static>\n"
        printf "<transition>\n"
        printf "  <duration>${switch_time}</duration>\n"
        printf "  <from>${i}</from>\n"
        ((a=$b+1));img="$(sed -n ${a}p ${X})"
        printf "  <to>${img}</to>\n"
        printf "</transition>\n"
    done
    printf "</background>\n"
}

#--/usr/share/backgrounds/gnome/*  #壁纸xml文件生成;
Back_image() {
    #--Time Code;
    cat << EOF > ${Image_file}/${file_name}-image.xml
<background>
  <starttime>
    <year>$(date "+%Y")</year>
    <month>$(date "+%m")</month>
    <day>$(date "+%d")</day>
    <hour>$(date "+%H")</hour>
    <minute>$(date "+%M")</minute>
    <second>$(date "+%S")</second>
  </starttime>
EOF
#Image_lun
Xml_cai >> ${Image_file}/${file_name}-image.xml
xp="$(cat -n ${Image_file}/${file_name}-image.xml | grep  '<to></to>' | awk '{print $1}')"     #获取最后图片本该变0的行;
sed -i "${xp}c$(printf "<to>`sed -n 1p ${X}`</to>\n")" ${Image_file}/${file_name}-image.xml    #最后的修改哈哈哈;
}

#--Root权限检测;
if (( `id -u` != 0 )); then
    clear;printf "${R_ed}Sorry,你必须使用${G_reen}Root${R_ed}权限运行此脚本;${C_ls}\n\a"
    exit 1
else
    clear
    printf "${Y_ellow}如何使用:${C_ls}\n"
    I_nit
fi
