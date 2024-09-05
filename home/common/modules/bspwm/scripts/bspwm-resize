#!/bin/sh

case $1 in
	left)
    bspc node -z right -5 0
    bspc node -z left +5 0
		;;
	down)
    bspc node -z top 0 -5 
    bspc node -z bottom 0 +5 
		;;
	up)
    bspc node -z top 0 +5
    bspc node -z bottom 0 -5
		;;
	right)
    bspc node -z right +5 0 
    bspc node -z left -5 0
		;;
esac
