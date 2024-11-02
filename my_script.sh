#!/bin/bash

# File Management System with RGB Colors

# Define RGB colors using ANSI escape codes
function rgb_color() {
    echo -e "\e[38;2;$1;$2;$3m"
}

# Define reset color
RESET=$(tput sgr0)

# Define colors
GREEN=$(rgb_color 0 255 0)
RED=$(rgb_color 255 0 0)
YELLOW=$(rgb_color 255 255 0)
BLUE=$(rgb_color 0 0 255)
CYAN=$(rgb_color 0 255 255)

# Display header
function display_header() {
    echo -e "${CYAN}============================${RESET}"
    echo -e "${GREEN}     File Management Menu   ${RESET}"
    echo -e "${CYAN}============================${RESET}"
}

function display_menu() {
    display_header
    echo -e "${YELLOW}1. Create a file${RESET}"
    echo -e "${YELLOW}2. Delete a file${RESET}"
    echo -e "${YELLOW}3. Move a file${RESET}"
    echo -e "${YELLOW}4. List files in a directory${RESET}"
    echo -e "${YELLOW}5. Exit${RESET}"
    echo -e "${CYAN}============================${RESET}"
}

function create_file() {
    read -p "Enter the filename to create: " filename
    touch "$filename" && echo -e "${GREEN}File '$filename' created.${RESET}"
}

function delete_file() {
    read -p "Enter the filename to delete: " filename
    if [ -e "$filename" ]; then
        rm "$filename" && echo -e "${GREEN}File '$filename' deleted.${RESET}"
    else
        echo -e "${RED}File '$filename' does not exist.${RESET}"
    fi
}

function move_file() {
    read -p "Enter the filename to move: " filename
    if [ -e "$filename" ]; then
        read -p "Enter the destination directory: " destination
        if [ -d "$destination" ]; then
            mv "$filename" "$destination" && echo -e "${GREEN}File '$filename' moved to '$destination'.${RESET}"
        else
            echo -e "${RED}Destination directory '$destination' does not exist.${RESET}"
        fi
    else
        echo -e "${RED}File '$filename' does not exist.${RESET}"
    fi
}

function list_files() {
    read -p "Enter the directory to list files (leave empty for current directory): " directory
    if [ -z "$directory" ]; then
        directory="."
    fi
    if [ -d "$directory" ]; then
        echo -e "${GREEN}Files in '$directory':${RESET}"
        ls "$directory"
    else
        echo -e "${RED}Directory '$directory' does not exist.${RESET}"
    fi
}

while true; do
    display_menu
    read -p "Select an option [1-5]: " choice
    case $choice in
        1) create_file ;;
        2) delete_file ;;
        3) move_file ;;
        4) list_files ;;
        5) echo -e "${GREEN}Exiting...${RESET}"; exit 0 ;;
        *) echo -e "${RED}Invalid option. Please try again.${RESET}" ;;
    esac
    echo ""
done
