#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install MUI 5.0 SDK${CCEND}";
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4.lha" -o /tmp/MUI-5.0.lha && \
	lha -xfq2 MUI-5.0.lha; \
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha && \
	lha -xfq2 MUI-5.0-contrib.lha; \
	mv ./SDK/MUI ${SDK_PATH}/MUI_5.0; \
	rm -rf /tmp/*;