#!/bin/bash
RESOURCE_NAME=CPU
NUM=${1:-6}
WARM=${2:-20}
CRIT=${3:-10}
OK=0
WG=1
NG=2
D_NUM=`expr $NUM - 1`
VMSTAT_IDOL=`vmstat 1 $NUM | awk 'NR>4 {sum+=$15} END {print sum}'`
VMSTAT_IDOL=`expr $VMSTAT_IDOL / $D_NUM`
CPU_RESOURCE=`expr 100 - $VMSTAT_IDOL`
if [ $VMSTAT_IDOL -le $CRIT ]; then
	./moniter_message.sh "$RESOURCE_NAME" $NG $CPU_RESOURCE
elif [ $VMSTAT_IDOL -gt $CRIT -a $VMSTAT_IDOL -le $WARM ]; then
	./moniter_message.sh "$RESOURCE_NAME" $WG $CPU_RESOURCE
else
	./moniter_message.sh "$RESOURCE_NAME" $OK $CPU_RESOURCE
fi
