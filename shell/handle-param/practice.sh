#!/bin/bash 
# usage:
# ./practice.sh -t IPv4 baidu.com taobao.com
# ./practice.sh
# 看到提示后输入 /home/robinyang/development/learn/shell/handle-param/ips
while getopts t: opt;do
    case $opt in
        t)  
            ipVer=$OPTARG
            echo $OPTARG
            if [ $ipVer = "IPv4" ];then
                ipcommand=$(which ping)
            elif [ $ipVer = "IPv6" ];then
                ipcommand=$(which ping6)
            else
                echo "pls specify a correct IP version!"
                exit
            fi
            echo will be using ip command: $ipcommand
            shift $[ $OPTIND - 1]
            num=$#
            if [ $num -eq 0 ];then
                echo "pls provide IP"
                exit 1
            else
                for item in "$@";do
                    $ipcommand -q -c 3 $item
                done           
                exit
            fi 
            ;;
        *)
            echo "unknown flag, will quit"
            exit 1
            ;;
    esac
done

echo
echo "Please enter the file name with an absolute directory
reference..."
echo
choice=0
while [ $choice -eq 0 ]
do
    read -t 6 -p "Enter name of file: " filename
    if [ -z $filename ]
    then
        quitanswer=""
        read -t 10 -n 1 -p "Quit script [Y/n]? " quitanswer
        case $quitanswer in
            Y | y) echo
            echo "Quitting script..."
            exit;;
            N | n) echo
            echo "Please answer question: "
            choice=0;;
            *)
            echo
            echo "No response. Quitting script..."
            exit;;
        esac
    else
        choice=1
    fi
done
#
if [ -s $filename ] && [ -r $filename ]
then
    echo "$filename is a file, is readable, and is not empty."
    echo
    cat $filename | while read line
    do
        ipaddress=$line
        echo "address is: "$ipaddress
        read line ##读取下一行
        iptype=$line
        echo "IP type is: "$iptype
        if [ $iptype = "IPv4" ]
        then
            pingcommand=$(which ping)
        else
            pingcommand=$(which ping6)
        fi
        echo "Checking system at $ipaddress..."
        $pingcommand -q -c 3 $ipaddress
        echo
    done
    echo "Finished processing the file. All systems checked."
else
    echo
    echo "$filename is either not a file, is empty, or is"
    echo "not readable by you. Exiting script..."
fi