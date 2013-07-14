# to create a black image 
# convert -size 340x500 xc:#000000 black.png 
convert $1 -crop 331x491+23+21 out-$1
convert  skin-1.png black.png -compose over -geometry '500x775+135+245!' -composite out-$1 -compose over  -geometry "550x720+140+265" -composite res.png


