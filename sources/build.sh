#!/bin/sh
set -e


echo "Generating Static fonts"
mkdir -p ../fonts
fontmake -g LV_Livvic.glyphs -i -o ttf --output-dir ../fonts
fontmake -g LV_Livvic_Italic.glyphs -i -o ttf --output-dir ../fonts

rm -rf instance_ufo/ master_ufo/


echo "Post processing"
ttfs=$(ls ../fonts/*.ttf)
for ttf in $ttfs
do
	gftools fix-dsig -f $ttf;
	ttfautohint $ttf "$ttf.fix";
	mv "$ttf.fix" $ttf;
	gftools fix-hinting $ttf;
	mv $ttf.fix $ttf;
done

