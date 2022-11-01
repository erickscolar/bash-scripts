# #1 parameter is the type of the message (nf, sc, er)
# #2 parameter is the message
# #3 is optional and break lines (br)
# ie: shout nf "Info!"
# ie: shout sc "Success!" br
function shout() {

    if [ "$1" = 'nf' ]
    then
        echo -e "\e[0;34m *************************************\e[m"
        echo -e "\e[0;34m $2\e[m"
        echo -e "\e[0;34m *************************************\e[m"
    fi

    if [ "$1" = 'sc' ]
    then
        echo -e "\e[1;31m *************************************\e[m"
        echo -e "\e[1;31m $2\e[m"
        echo -e "\e[1;31m *************************************\e[m"
    fi

    #if [ "$1" = 'er' ]
    #then
    #    echo -e "\e[1;31m $2\e[m"
    #fi

    if [ "$3" = 'br' ]
    then
        echo
    fi

}