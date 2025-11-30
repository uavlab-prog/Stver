#!/bin/bash

cmd=${LUPDATE}

if [ -z "${cmd}" ]
then
cmd=lupdate
fi

for i in `find . -type f -iname "*.ts"`; do cd `dirname "$i"` && pwd && ${cmd} ./ -no-obsolete -ts `basename "$i"` && cd -; done
