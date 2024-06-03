#!/bin/bash

# Set Colour Vars
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

FUNC_RPC_MENU() {

    while true; do
        echo -e "${GREEN}       ##${NC}"
        echo -e "${GREEN}       ##  This script sets the WS & RPC server configuration based on the selected option ${NC}"
        echo -e "${GREEN}       ##  below. The script will overwrite the existing values with those of the selected option ..${NC}"
        echo -e "${GREEN}       ##${NC}"
        echo
        echo -e "${GREEN}       ##  1 -- Set to 'earpc.xinfin.network' option ${NC}"
        echo -e "${GREEN}       ##  2 -- Set to 'erpc.xinfin.network' option ${NC}"
        echo -e "${GREEN}       ##  3 -- Set to 'rpc1.xinfin.network' option ${NC}"
        echo -e "${GREEN}       ##  4 -- Set to 'rpc.xinfin.network' option ${NC}"
        echo -e "${GREEN}       ##  5 -- Set to 'erpc.xdcrpc.com' option ${NC}"
        echo -e "${GREEN}       ##  6 -- Set to 'rpc.xdcrpc.com' option ${NC}"
        echo -e "${GREEN}       ##  7 -- Set to 'rpc.xdc.org' option ${NC}"
        echo -e "${GREEN}       ##  8 -- Set to 'rpc-xdc.icecreamswap.com' option ${NC}"
        echo
        read -t30 -r -p "       Enter the option NUMBER from the list above : " _RES_INPUT
        if [ $? -gt 128 ]; then
            #clear
            echo
            echo
            echo "      ....timed out waiting for user response - please select a NUMBER from the list... exiting"
            #echo "....timed out waiting for user response - proceeding as standard in-place restore to existing system..."
            echo
            #DR_RESTORE=false
            #FUNC_RPC_MENU;
            FUNC_EXIT_ERROR
        fi

        case $_RES_INPUT in
        1*)
            VARVAL_RPC="https://earpc.xinfin.network"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        2*)
            VARVAL_RPC="https://erpc.xinfin.network"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        3*)
            VARVAL_RPC="https://rpc1.xinfin.network"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        4*)
            VARVAL_RPC="https://rpc.xinfin.network"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        5*)
            VARVAL_RPC="https://erpc.xdcrpc.com"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        6*)
            VARVAL_RPC="https://rpc.xdcrpc.com"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        7*)
            VARVAL_RPC="https://rpc.xdc.org"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;
        8*)
            VARVAL_RPC="https://rpc-xdc.icecreamswap.com"
            VARVAL_WSS="wss://ews.xinfin.network"
            break
            ;;

        *) echo -e "${RED}  please select a NUMBER from the list${NC}" ;;
        esac
    done
    FUNC_SET_FILE
}

FUNC_SET_FILE() {
    DIRS1=~/pluginV2Install/sample.vars
    DIRS2=~/plinode_$(hostname -f).vars
    DIRS3=~/pluginV2/config.toml

    # Set bashfile2
    if [ -e "$DIRS1" ] && [ -e "$DIRS2" ]; then
        sed -i -e "s|mainnet_httpUrl=.*|mainnet_httpUrl='$VARVAL_RPC'|g" $DIRS1 $DIRS2

    fi

    if [ -e "$DIRS3" ]; then
        sed -i -e "s|httpUrl = .*|httpUrl = '$VARVAL_RPC'|g" $DIRS3
    fi
    cat $DIRS1 | grep -H "mainnet_httpUrl" ~/pluginV2Install/sample.vars
    cat $DIRS2 | grep -H "mainnet_httpUrl" ~/plinode_$(hostname -f).vars 
    cat $DIRS3 | grep -H "httpUrl" ~/pluginV2/config.toml

    FUNC_SED_FILE
}

FUNC_SED_FILE() {

    #sed -i 's|^export ETH_URL.*|export ETH_URL='$VARVAL_WSS'|g' ~/plugin-deployment/$BASH_FILE2
    sed -i -e "s|mainnet_wsUrl=.*|mainnet_wsUrl='$VARVAL_WSS'|g" $DIRS1 $DIRS2 $DIRS3

    #sed -i 's|plirpc.blocksscan.io|pli.xdcrpc.com|g' ~/plugin-deployment/$BASH_FILE3
    #sed -i 's|https:\/\/.*\\|'$VARVAL_RPC'\\|g' ~/plugin-deployment/$BASH_FILE3
    sed -i -e "s|wsUrl = .*|wsUrl = '$VARVAL_WSS'|g" $DIRS3

    pm2 restart all
    pm2 reset all
    pm2 list

    cat $DIRS1 | grep -H "mainnet_wsUrl" ~/pluginV2Install/sample.vars
    cat $DIRS2 | grep -H "mainnet_wsUrl" ~/plinode_$(hostname -f).vars
    cat $DIRS3 | grep -H "wsUrl" ~/pluginV2/config.toml
}

FUNC_EXIT_ERROR() {
    exit 1
}

FUNC_RPC_MENU
