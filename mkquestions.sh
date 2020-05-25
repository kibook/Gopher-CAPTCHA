#!/bin/sh

set -e

RNG=/dev/urandom
MAX=1000

random() {
	tr -cd '1-9' < "$RNG" | head -c 1 | sed 's/^0*//'
}

for i in $(seq 1 "$MAX")
do
	a=$(random)
	b=$(random)
	o=$(($(random) % 2))

	case "$o" in
		0)
			op='+'
			ans=$((a + b))
			;;
		1)
			op='-'
			ans=$((a - b))
			;;
	esac

	mkdir -p "questions/${i}"

	echo "What is ${a} ${op} ${b}?" > "questions/${i}/q"
	echo "$ans" > "questions/${i}/a"

	if test $((i % 50)) -eq 0
	then
		echo "Created ${i}/${MAX} questions."
	fi
done
