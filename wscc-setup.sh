#!/bin/bash
clear
echo "##########################################################"
echo "#                                                        #"
echo -e "#\e[38;5;87m WALZ.systems Corporate Client Setup\e[0m                    #"
echo "# ------------------------------------------------------ #"
echo "#                                                        #"
echo "# This will install the WSCC - OS Patch on a clean       #"
echo "# Ubuntu Desktop 14.04.3 LTS                             #"
echo "#                                                        #"
echo "# Works with:                                            #"
echo "#     as SDC    >> (Standalone Desktop Client)           #"
echo "#     with UCS  >> (Univention Corporate Server)         #"
echo "#     with WSCS >> (WALZ.systems Corporate Server)       #"
echo "#                                                        #"
echo "# (c) 1997-2015 by WALZ.systems,                         #"
echo "#                  devXive - research and development    #"
echo "#                                                        #"
echo "# Version: WSCC v.3.0                                    #"
echo "#                                                        #"
echo "##########################################################"
source library/helper
check_root_access
# ----------------------------------------------------- INSTALL CORE LIB -------------------------------------------------------
echo ""
echo ""
echo "Install core lib ..."
echo ""
wscc_clean_this "/usr/share/wscc-commons"
wscc_copy "/usr/share/wscc-commons"
wscc_convert "/usr/share/wscc-commons"
echo -e "Install core lib ...\e[38;5;46mdone\e[0m"
bash /usr/share/wscc-commons/library/installer