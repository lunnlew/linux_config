#!/bin/bash

# ASUS-wifi
echo "options asus_nb_wmi wapf=4"| sudo tee /etc/modprobe.d/asus_nb_wmi.conf
echo "华硕无线驱动添加完成！"

# Update
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
echo "系统更新完成！"

# Git，Wget,VLC
sudo apt-get -y install git wget vlc
echo "Git，Wget, VLC服务安装完成！"

# Ma6147-VIM
wget -qO- https://raw.github.com/ma6174/vim/master/setup.sh | sh
echo "Ma6147-VIM配置完成！"

# OH-MY-ZSH
sudo apt-get -y install zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc_backup
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh
echo "
#命令高亮部分

#color{{{
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
eval _$color='%{$terminfo[bold]$fg[${(L)color}]%}'
eval $color='%{$fg[${(L)color}]%}'
(( count = $count + 1 ))
done
FINISH="%{$terminfo[sgr0]%}"
#}}}
 
#彩色补全菜单 
eval $(dircolors -b) 
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
#}}}
 
#命令别名 {{{
alias -g cp='cp -i'
alias -g mv='mv -i'
alias -g ls='ls -F --color=auto'
alias -g ll='ls -la'
alias -g grep='grep --color=auto'
alias -g ee='emacsclient -t'
 
#漂亮又实用的命令高亮界面
setopt extended_glob
 TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')
 
 recolor-cmd() {
     region_highlight=()
     colorize=true
     start_pos=0
     for arg in ${(z)BUFFER}; do
         ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
         ((end_pos=$start_pos+${#arg}))
         if $colorize; then
             colorize=false
             res=$(LC_ALL=C builtin type $arg 2>/dev/null)
             case $res in
                 *'reserved word'*)   style="fg=magenta,bold";;
                 *'alias for'*)       style="fg=cyan,bold";;
                 *'shell builtin'*)   style="fg=yellow,bold";;
                 *'shell function'*)  style='fg=green,bold';;
                 *"$arg is"*)
                     [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                 *)                   style='none,bold';;
             esac
             region_highlight+=("$start_pos $end_pos $style")
         fi
         [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
         start_pos=$end_pos
     done
 }
check-cmd-self-insert() { zle .self-insert && recolor-cmd }
 check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }
 
 zle -N self-insert check-cmd-self-insert
 zle -N backward-delete-char check-cmd-backward-delete-char
" >> ~/.zshrc
echo "OH-MY-ZSH配置完成！"

# AUTOJUMP
sudo apt-get -y install autojump
git clone https://github.com/joelthelion/autojump.git
python ~/autojump/install.py
echo "[[ -s /home/ttop5/.autojump/etc/profile.d/autojump.sh  ]] && source /home/ttop5/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u" >> ~/.zshrc
source ~/.zshrc
cd && rm -rf autojump
echo "AUTOJUMP配置完成！"

# Google-Chrome
sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
sudo apt-get -y update
sudo apt-get -y install google-chrome-stable
cd /etc/apt/sources.list.d && sudo rm -f *
cd
sudo apt-get -y Update
echo "Google-Chrome安装完成！"

# Shadowsocks
sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
sudo apt-get -y update
sudo apt-get -y install shadowsocks-qt5
cd /etc/apt/sources.list.d && sudo rm -f *
cd
sudo apt-get -y Update
echo "Shadowsocks安装完成！"

# Sogou & WPS
sudo echo "deb http://archive.ubuntukylin.com:10006/ubuntukylin trusty main" > /etc/apt/sources.list.d/ubuntukylin.list
sudo apt-get -y update
sudo apt-get update --fix-missing
sudo apt-get install sogoupinyin
sudo apt-get install wps-office
cd /etc/apt/sources.list.d && sudo rm -f *
cd
sudo apt-get -y Update
echo "Sogou和WPS安装完成！"

# python相关
sudo apt-get install python-pip bpython
pip install virtualenv flake8

# 卸载预装软件
sudo apt-get -y purge empathy
sudo apt-get -y purge nautilus-sendto-empathy
sudo apt-get -y purge empathy-common               #即时通讯
sudo apt-get -y purge thunderbird*                 #邮件
sudo apt-get autoremove indicator-messages         #面板邮件通知
sudo apt-get -y purge ubuntuone*                   #Ubuntu One
sudo apt-get -y purge gwibber*                     #微博
sudo apt-get -y purge deja-dup                     #备份
sudo apt-get -y purge totem*                       #视频播放
sudo apt-get -y purge rhythmbox*                   #音乐播放
sudo apt-get -y purge libreoffice*                 #办公套件
sudo apt-get -y purge gnome-orca                   #屏幕阅读
sudo apt-get -y purge onboard                      #屏幕键盘
sudo apt-get -y purge mahjongg                     #对对碰
sudo apt-get -y purge sol                          #纸牌王
sudo apt-get -y purge gnome-sudoku                 #数独
sudo apt-get -y purge gnomine                      #扫雷
# sudo apt-get -y purge gucharmap                    #字符映射表
# sudo apt-get -y purge gnome-power-manager          #电源统计
# sudo apt-get -y purge gnome-system-monitor         #系统监视器
# sudo apt-get -y purge gnome-system-log             #日志查看器
# sudo apt-get -y   purge usb-creator-gtk            #启动盘创建器
# sudo apt-get -y purge landscape-client-ui-install  #管理服务
# sudo apt-get -y purge aptitude                     #软件包管理
# sudo apt-get -y purge software-center              #软件中心
# sudo apt-get -y purge yelp*                        #帮助
# sudo apt-get -y purge update-*                     #自动更新
# sudo apt-get -y purge bluez*                       #卸载蓝牙
# sudo apt-get -y purge simple-scan                  #扫描
# sudo apt-get -y purge hplip*                       #打印
# sudo apt-get -y purge printer-driver*              #打印驱动
# sudo apt-get -y purge apport*                      #问题报告
# sudo apt-get -y purge whoopsie                     #崩溃报告
# sudo apt-get -y purge xdiagnose                    #卸载X诊断
# sudo apt-get -y purge checkbox*                    #系统测试 
# sudo apt-get -y purge gnome-nettool                #网络工具
# sudo apt-get -y purge samba-common*                #samba共享
# sudo apt-get -y purge whois                        #查询域名信息
# sudo apt-get -y purge gedit*                       #文本编辑
# sudo apt-get -y purge file-roller                  #归档管理器
# sudo apt-get -y purge wodim                        #命令刻碟
# sudo apt-get -y purge compiz*                      #桌面特效
sudo apt-get -y clean
sudo apt-get -y autoclean
echo “无关软件卸载完成！”

# Basic Server
sudo apt-get -y install tasksel
echo "请按照提示选择需要的相关服务："
sudo tasksel
echo "相关服务安装完成！"
