#!/usr/bin/bash
# 

echo -e "${CCPINK}${CCBOLD}\n---> Install MUI 5.0 SDK${CCEND}";
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4.lha" -o /tmp/MUI-5.0.lha && \
	lha -xfq2 MUI-5.0.lha; \
	curl -fsSL "https://github.com/amiga-mui/muidev/releases/download/MUI-5.0-20210831/MUI-5.0-20210831-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha && \
	lha -xfq2 MUI-5.0-contrib.lha; \
	mkdir -p ${SDK_PATH}/Examples/MUI; \
	mv ./SDK/MUI/Autodocs/* ${SDK_PATH}/Documentation/AutoDocs/; \
	mv ./SDK/MUI/C/Examples/* ${SDK_PATH}/Examples/MUI/; \
	\cp -r ./SDK/MUI/C/include/* ${SDK_PATH}/local/common/include/; \
	mv ./SDK/MUI/Docs ${SDK_PATH}/local/Documentation/MUI; \
	rm -rf /tmp/*;