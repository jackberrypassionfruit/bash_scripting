# Great for looping inside a single directory, but we need to go deeper...
# for MPEG in *.mp4; do
#   ffmpeg -i "$MPEG" -vcodec libx265 -crf 28 "new-$MPEG";
#   # echo $MPEG
# done

# This one is making $MPEG each WORD in each string, and that's wrong
# for MPEG in `find . -name "*.mp4"`; do
#   # ffmpeg -i "$MPEG" -vcodec libx265 -crf 28 "new-$MPEG";
#   echo "${MPEG}"
# done

# YES! using the exec flag in find is the ticket, because it's smarter about strings I guess

find . -name "*.mp4" -exec bash -c 'for MPEG in "$1" ;
  do

    ffmpeg -i "$MPEG" -vcodec libx265 -crf 28 "${MPEG%.mp4}(SHRUNK).mp4";
    mkdir -p "${MPEG%/*}/trash"
    mv "$MPEG" "${MPEG%/*}/trash"

  done
' none {} \;