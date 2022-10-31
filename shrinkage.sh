
# Shrinkage - takes a nested directory of files and runs all of the *.mp4 files through ffmpeg in order to reduce their file size. Feel free to adopt the parameters for your own use or shoot me a questions about the the looping for "find ... -exec "

# format " sh ./shrinkage.sh filetype depth"
# note: depth = 0 for unshrunk folder in same directory. +1 for every level up

find . -name "*.$1" -exec bash -c 'for file in "$1" ;
  do
    ffmpeg -y -i "$file" -vcodec libx265 -crf 28 "${file%.mp4}(SHRUNK).mp4";
    depth=""
    nest="/*"
    for i in {0..'$2'}; do
      depth+="$nest";
    done

    shrunkDir="${file%$depth}/unShrunk${file%/*}"
    
    mkdir -p ${shrunkDir%\.}
    mv "$file" ${shrunkDir%\.} 

  done
' none {} \;
