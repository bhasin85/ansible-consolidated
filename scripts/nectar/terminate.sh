#!/bin/bash

INSTANCE=$(mktemp)
echo "instance details, $INSTANCE"

ID=JA-TEST


echo "id is $ID"

nova delete \
  $ID


get_nova_property() {
  local name="$1"; shift;
  local file="$1"; shift;
  # might be better to use sed...
  grep " $name " $file | cut -d'|' -f 3 | sed 's/ //g'
}


nova show "$ID" > $INSTANCE
ID=$( get_nova_property id "$INSTANCE"  )


echo "id now $ID"


# wait for instance to terminate
while true; do
  nova show "$ID" > $INSTANCE
  STATE=$( get_nova_property 'OS-EXT-STS:task_state' $INSTANCE )
  echo "state, $STATE"
  if [ -z $STATE ]; then
    break
  fi
  sleep 5
done

