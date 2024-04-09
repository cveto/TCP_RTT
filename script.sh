#!/bin/bash
# Needs sed, awk, mtr, netcat and tshark

# $1 how many packets
# $2 To what IP
# $3 On What port

# Delete file if exist and make it writable
file="/tmp/tmp.txt"
if [ -f "$file" ] ; then
    rm -f "$file"
fi
touch $file
chmod 755 $file

# Kill all zombies and wait until they are dead
pkill tshark && while pgrep -l tshark; do sleep 1;done;

# Run package capture
tshark -i any -Y 'tcp.port==1792 && (tcp.flags.syn==1 && tcp.flags.ack==1)' -T fields -e tcp.time_relative -e tcp.dstport &> /tmp/tmp.txt &

sleep 1 # tShark needs some time to wake-up. And there doesn't seem to be a way to know how long that takes.


## Generate packets - with netcat or mtr

echo "----- MTR results -----"
echo "Results in miliseconds:"
#mtr --tcp --report -c $1 --port $3 $2
mtr --tcp -c $1 -r -f 32 -m 32 --port $3 $2

#for i in $(seq 1 1 $1); do nc -zv 172.24.193.168 1792 2> /dev/null; done
#j=0;
#for i in $(seq 1 1 $1)
#do
#    nc -zv $2 $3 2> /dev/null;
#    if (( $i % 500 == 0 )); then echo "$i packages already sent"; fi 
#done

echo ""
echo "----- tshark results -----"

sleep 1 # Definetely needed, otherwise I tshark does not capture all packets

pkill tshark && while pgrep -l tshark > /dev/null; do sleep 1;done;   # Delay needed or packets missing in the output file

sed -i '/^[0-9].*\./!d' $file  # Remove all lines that are not results (that don't staret with NUMBER and dot)  (so AWK can process them after).

echo "SYN packets sent (according to our instructions and mtr): $1"
echo "SYN_ACK packets received (according to tshark): `wc -l < /tmp/tmp.txt`"
echo ""
echo "Results in seconds"


cat $file | awk '{if(min==""){min=max=$1}; if($1>max) {max=$1}; if($1<min) {min=$1}; total+=$1; count+=1} END {print "avg " total/count," | max "max," | min " min}'
rm $file     # Cleanup

