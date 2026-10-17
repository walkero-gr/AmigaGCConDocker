#!/usr/bin/bash
#
set -e

echo -e "${CCPINK}${CCBOLD}\n---> Install MUI 5.0 SDK ${CCEND}";
  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://walkero.gr/betas/MUI-5.0-20210831-os4.lha" -o /tmp/MUI-5.0.lha && \
  lha -xfq2 MUI-5.0.lha; \
  curl --retry 10 --retry-delay 10 --retry-all-errors -fsSL "https://walkero.gr/betas/MUI-5.0-20210831-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha && \
  lha -xfq2 MUI-5.0-contrib.lha; \
  mkdir -p ${SDK_PATH}/Examples/MUI; \
  mv ./SDK/MUI/Autodocs/* ${SDK_PATH}/Documentation/AutoDocs/; \
  mv ./SDK/MUI/C/Examples/* ${SDK_PATH}/Examples/MUI/; \
  \cp -r ./SDK/MUI/C/include/* ${SDK_PATH}/local/common/include/; \
  mv ./SDK/MUI/Docs ${SDK_PATH}/local/Documentation/MUI; \
  rm -rf /tmp/*;

# echo -e "${CCPINK}${CCBOLD}\n---> Install MCC_TextInput ${CCEND}";
#   curl --retry 5 --retry-delay 4 --retry-all-errors -fsSL "https://aminet.net/dev/mui/MCC_TextInput.lha" -o /tmp/MCC_TextInput.lha && \
#   lha -xfq2 MCC_TextInput.lha;\
#   mv ./MCC_Textinput/Developer/C/Examples/* ${SDK_PATH}/Examples/MUI/; \
#   \cp -r MCC_Textinput/Developer/C/Include/MUI/* ${SDK_PATH}/local/common/include/mui/; \
#   rm -rf /tmp/*;
