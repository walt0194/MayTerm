#!/bin/bash

valueVar='03e207'"$(date +%m%d%H%M)"'00df03'
sudo gatttool -b C4:BE:84:1E:6F:83 --char-write-req --handle=0x0081 --value=$valueVar
sudo gatttool -b C4:BE:84:1E:6F:83 --char-write-req --handle=0x0081 --value=0400