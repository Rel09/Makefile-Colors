#!/bin/bash

# Bash script that store all the colors, instead of instead the Makefile

# ------------------------------------------------ #
# Paste this in the terminal to see all the Colors
# ------------------------------------------------ #

#   ./Makefile.sh printAll
 
# ------------------------------------------------ #
#                   Set Text Color 
# ------------------------------------------------ #

# ./Makefile.sh colorTxt [Text_Color_Index] [Text]
#  Example:   ./Makefile.sh 10 "[+] Compilation Successful !"

# ------------------------------------------------ #
#             Set Text & Background Color
# ------------------------------------------------ #

# ./Makefile.sh colorBg [Text_Color_Index]  [Background_Color_Index Text]
# Example:   ./Makefile.sh 10 0 "[+] Compilation Successful !"


#  Now you can literally use that inside your makefile

# ------------------------------------------------ #
#               Makefile's Functions
# ------------------------------------------------ #

#   ./Makefile.sh colorTxt [Text_Color_Index] [Text]
colorTxt() {
    local index=$1
    shift
    local text="$*"
    echo -e "\033[38;5;${index}m$text\033[0m"
}

#   ./Makefile.sh colorBg [Text_Color_Index] [Background_Color_Index] [Text]
colorBg() {
    local fg_index=$1
    local bg_index=$2
    shift 2
    local text="$*"
    echo -e "\033[38;5;${fg_index}m\033[48;5;${bg_index}m$text\033[0m"
}

# ------------------------------------------------ #
#               Display all the colors
# ------------------------------------------------ #
printAllColors() {
    for ((i = 0; i < 256; i++)); do 
        printf "\033[38;5;%dm Color %-3d \033[0m " "$i" "$i"
        if (( (i + 1) % 10 == 0 )); then
            printf "\n"
        fi
    done
    printf "\033[0m\n"
}

printAllBackgroundColors() {
    for ((i = 0; i < 256; i++)); do
        printf "\033[48;5;%dm Color %-3d \033[0m " "$i" "$i"
        if (( (i + 1) % 10 == 0 )); then
            printf "\n"
        fi
    done
    printf "\033[0m\n"
}

printAll() {

    # Forecolor
    for ((i = 0; i < 256; i++)); do
        printf -v FG_COLOR_256_$i '\033[38;5;%dm' $i
        eval "colorText_$i() { echo -e \"\${FG_COLOR_256_$i}\$1\033[0m\"; }"
    done

    # Background
    for ((i = 0; i < 256; i++)); do
        printf -v BG_COLOR_256_$i '\033[48;5;%dm' $i
        eval "text_bg_color_$i() { echo -e \"\${BG_COLOR_256_$i}\$1\033[0m\"; }"
    done

    printAllColors
    printAllBackgroundColors
}

#printAll
#printAllColors
#printAllBackgroundColors

# ------------------------------------------------ #
#                 This is REQUIRED 
# ------------------------------------------------ #
$*
