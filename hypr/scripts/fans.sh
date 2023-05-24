#!/usr/bin/env bash


function fan1speed {
    sensors | awk '/fan1:/ {print $2}'
}

function fan2speed {
    sensors | awk '/fan2:/ {print $2}'
}

maxFanSpeed=8000

lowThreshold=2000
midThreshold=5000
highThreshold=6000

text=""
tooltip="<span>󰈐</span> $(fan1speed) (L) | <span>󰈐</span> $(fan2speed) (R)"
class="off"

if [[ $(fan1speed) -gt $highThreshold ]]
then
    class="high"
elif [[ $(fan1speed) -gt $midThreshold ]]
then
    class="medium"
elif [[ $(fan1speed) -gt $lowThreshold ]]
then
    class="low"
fi

printf '{"text":"%s","tooltip":"%s","class":"%s","percentage":"%s"}\n' "$text" "$tooltip" "$class" "$percentage"
