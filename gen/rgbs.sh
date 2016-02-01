#!/bin/mksh
#-
# Copyright © 2016
#	mirabilos <m@mirbsd.org>
#
# Provided that these terms and disclaimer and all copyright notices
# are retained or reproduced in an accompanying document, permission
# is granted to deal in this work without restriction, including un‐
# limited rights to use, publicly perform, distribute, sell, modify,
# merge, give away, or sublicence.
#
# This work is provided “AS IS” and WITHOUT WARRANTY of any kind, to
# the utmost extent permitted by applicable law, neither express nor
# implied; without malicious intent or gross negligence. In no event
# may a licensor, author or contributor be held liable for indirect,
# direct, other damage, loss, or other issues arising in any way out
# of dealing in the work, even if advised of the possibility of such
# damage or existence of a defect, except proven that it results out
# of said person’s immediate fault when using the work as intended.
#-
# Helper script to generate RGB tuples for each index (hacked up).
# Use only until they repeat (with off-by-ones allowed for each
# scale and in both directions): 0..376 for freq=0.3

freq=0.3

bc -l |&
print -p scale=10
i=-1
while (( ++i < 5000 )); do
	print -p "s($freq*$i)*127+128"
	read -p rs
	print -p "s(($freq*$i)+2.094395102393195492308428922186335256131446266250070547316629728205)*127+128"
	read -p gs
	print -p "s(($freq*$i)+4.18879020478639098461685784437267051226289253250014109463325945641)*127+128"
	read -p bs
	print "$i	$rs	$gs	$bs"
	r=${rs%.*}
	g=${gs%.*}
	b=${bs%.*}
	if (( i )); then
		s=1
		(( (r == r0) || (r == (r0 - 1)) || (r == (r0 + 1)) )) || s=0
		(( (g == g0) || (g == (g0 - 1)) || (g == (g0 + 1)) )) || s=0
		(( (b == b0) || (b == (b0 - 1)) || (b == (b0 + 1)) )) || s=0
		(( s )) && break
		sr+=" $r"
		sg+=" $g"
		sb+=" $b"
	else
		sr="set -A col_r -- $r"
		sg="set -A col_g -- $g"
		sb="set -A col_b -- $b"
		r0=$r
		g0=$g
		b0=$b
	fi
done
print \# $i
print
print -r -- $sr
print -r -- $sg
print -r -- $sb
