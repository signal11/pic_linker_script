#!/bin/bash -e

mkdir -p output/

MCUS=pic24fj64gb002

for i in $MCUS; do
	echo "Generating $i"
	./pic24f_gen.sh $i
	./pic24f_bootloader_gen.sh $i
done
