#!/bin/bash

rewriteFiles(){

    for dir in $inputDir/*.sh;do
        name=$(basename $dir)
        sed '1c\#!bin/bash' $dir > /tmp/$name
    done
}

inputDir=$1
if [ -n $inputDir ];then
    echo "print dirs"
    sed -sn '1F;
    1s!/bin/sh!bin/bash!
    ' $inputDir/*.sh|
    gawk 'BEGIN {print "These files under dir inputed is using sh as shebang"
    print "---------------------------------------------------"}
    {print $0}
    END {print "---------------------------------------------------"}
    '
else
    echo "no input dir parameter,will quit..."
    exit
fi

read -p "corret and rewrite to /tmp floder?" answer

case $answer in 
Y|y)
    echo 123
    rewriteFiles
    ;;
N|n)
    echo 456;;
*)
    echo 789;;
esac
