#!/bin/bash

# Usage:
# Call bash activate_python3.12_environment.sh if you want to spawn a subprocess and avoid changing directory after this script is finished

# or

# Call using source activate_python3.12_environment.sh to persist directory changes and also persist virtual environment activation in parent shell

# References: [Script to change current directory (cd, pwd)](https://unix.stackexchange.com/a/27140)
# [Bash Source Command](https://linuxize.com/post/bash-source-command/)

# Reference to function creation and calls: https://devqa.io/create-call-bash-functions/
function initializeDirectory() {
    cd python3.12_setup/.venv3.12/Scripts
}

function activateEnvironment(){
    source ./activate
}

# Get the directory on which script was called
currentDirectory=$(pwd)

initializeDirectory
activateEnvironment

# Restore the directory on which script was called
cd $currentDirectory