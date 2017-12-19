#!/bin/sh -x

DISPLAYTIME=30

initApp() {
	su -lc "screen -d -m $0 screen" pi
}

screenApp() {
	startx $0
}

xApp() {
	( sleep $DISPLAYTIME ; killall chromium ; ) &
	killpid=$!
	chromium --app="$(nextUrl)"
	kill $killpid
}

nextUrl() {
	rollShiftFile /home/pi/urls
}

rollShiftFile() {
	roll="${1}.roll"
	if [ ! -s "$roll" ]; then
		cat "$1" > "$roll"
	fi
	shiftLine $roll
}

shiftLine() {
	first=1
	tmp="${1}.tmp"
	echo -n > "$tmp"
	while read line; do
		if [ "$first" = "1" ]; then
			first=0
			echo "$line"
		else
			echo "$line" >> "$tmp"
		fi
	done < "$1"
	cat "$tmp" > "$1"
	rm "$tmp"
}

xLooper() {
	looper xApp
}

looper() {
	touch /tmp/kiosk.started
	rm -f /tmp/kiosk.stop
	while [ ! -f /tmp/kiosk.stop ] && [ -f /tmp/kiosk.started ]; do
		$@
	done
	rm -f /tmp/kiosk.stop /tmp/kiosk.started
}

case "$1" in
	init)		initApp		;;
	screen)		screenApp	;;
	*)		xLooper		;;
esac

