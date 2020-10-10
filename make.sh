# example run:
# without running the program:
# ./make.sh FILENAME
# running the program after building:
# ./make.sh -r FILENAME
FILENAME=$1
RUNNING=false

if getopts 'r' c; then
    echo running
    FILENAME=$2
    RUNNING=true
fi

FILENAME="${FILENAME%%.*}"

rgbasm -o $FILENAME.obj $FILENAME.asm
rgblink -o a.gb $FILENAME.obj
rgbfix -v -p0 a.gb
rm $FILENAME.obj

if [ $RUNNING = true ]; then
    wine /home/max/Desktop/bgb/bgb.exe a.gb 2>/dev/null &
fi