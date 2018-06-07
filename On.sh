#!/bin/bash

valueVar='03e207'"$(date +%m%d%H%M)"'00df03'
echo $valueVar
sudo gatttool -b C4:BE:84:1E:6F:83 --char-write-req --handle 0x0018 --value $valueVar;sleep 1; sudo gatttool -b C4:BE:84:1E:6F:83 --char-write-req --handle 0x0018 --value 0401
