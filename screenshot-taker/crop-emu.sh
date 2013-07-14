# to create a black image 
# convert -size 340x500 xc:#000000 black.png 
convert $1 -crop 331x491+23+21 out-$1
convert  skin-2.png black.png -compose over -geometry '500x700+125+240!' -composite out-$1 -compose over  -geometry "475x680+150+250" -composite final-$1


