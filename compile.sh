# copied from Jacopo's stuff

# Based on https://github.com/CyberGrandChallenge/cb-testing/blob/master/cgc-cb.mk
# '-Wl,-mcgc_i386' is my addition, though, so that 'clang -o exe' works. [J]

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$#" -lt 1 ]; then
    echo "usage $0 <clang commands>";
    exit 1
fi

export CC=$DIR/bin/clang
export LD=$DIR/bin/ld
export CXX=$DIR/bin/clang++
export OBJCOPY=$DIR/bin/objcopy

export LDFLAGS="-nostdlib -static -Wl,-mcgc_i386 $LDFLAGS"
export  CFLAGS="-nostdlib -fno-builtin -nostdinc -isystem$DIR/include $CFLAGS"
export LDLIBS="-L$DIR/lib -lcgc $LDLIBS"

export PATH="$DIR/bin:$PATH"

function compile() {
    $CC -Ilib/ \
        -std=gnu99 -Wall -Wextra -Wshadow -Wwrite-strings -Wpointer-arith -Wstrict-overflow=4  \
        $CFLAGS $LDFLAGS $@ $LDLIBS;
}

compile $@
