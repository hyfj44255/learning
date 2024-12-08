#!/bin/bash

arr=(1 2 3 4 5 6)
for ele in ${arr[*]};do
    echo -e "\a"
    sleep 1s
done