#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

# Source predefined functions and variables
. /etc/profile

PORT="devilutionx"

# init_port binary audio(alsa. pulseaudio, default)
[[ "$EE_DEVICE" == "Amlogic" ]] && init_port ${PORT} pulseaudio || init_port ${PORT} alsa

if [ ! -L /storage/.local/share/diasurgical/devilution/diabdat.mpq ]; then
mkdir -p /storage/.local/share/diasurgical/devilution/
ln -sf /storage/roms/ports/diablo/diabdat.mpq /storage/.local/share/diasurgical/devilution/diabdat.mpq
fi

cd /emuelec/bin/
./${PORT} >> $EE_LOG 2>&1
ret_error=$?

end_port

if [[ "$ret_error" != 0 ]]; then
	ee_check_bios "Diablo"
	exit $ret_error
else
	exit 0
fi

