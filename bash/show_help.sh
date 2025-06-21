#!/bin/bash

sed -e 's/=c= /[38;5;245m/g' -e 's/=h= /[38;5;37m/g' -e 's/$/[0m/g' ${1}
