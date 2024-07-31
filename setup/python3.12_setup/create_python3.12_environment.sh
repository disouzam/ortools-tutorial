#!/bin/bash

function readDestinationFolder(){
    value=`cat destinationFolder.txt`
    echo "$value"
}

function readPythonPath(){
    value=`cat pythonPath.txt`
    echo "$value"
}

function readPythonVersion(){
    value=`cat pythonVersion.txt`
    echo "$value"
}


# This function assumes that you launched this script from folder python3.12_setup
function createEnvironment(){
    currentDirectory=$(pwd)

    # https://stackoverflow.com/a/19858692
    folder=${currentDirectory:(-16)}

    if [[ "$folder" != "python3.12_setup" ]]
    then
        echo $folder
        echo "Error creating .venv3.12. Current folder is not python3.12_setup. Current folder:": $currentDirectory
        exit 1
    fi

    if [[ -z $1 ]];
    then
        echo "Error creating .venv3.12. Provide the path to Python executable"
        echo "Example:"
        echo "bash create_python3.12_environment.sh "C:\\Program Files\\Python311\\python.exe""
        exit 1
    fi

    pythonVersion=$("$1" --version)
    echo "pythonVersion: " $pythonVersion

    if [[ ${pythonVersion:(-6)} != "$2" ]]
    then
        echo "Incorrect Python version. Repository is set to work with Python" "$2"
        echo "Current version: " $pythonVersion
        exit 1
    fi

    echo "destinationFolder: " $3

    if [[ -z $3 ]];
    then
        echo "Error creating .venv3.12. Provide the path that .venv3.12 will be created."
        echo "Example:"
        echo "D:\\Repos\\CurrentRepoFolder"
        exit 1
    fi

    "$1" -m venv $destinationFolder

    touch $destinationFolder/.gitignore
    echo "*" > $destinationFolder/.gitignore
}

destinationFolder=$(readDestinationFolder)
pythonPath=$(readPythonPath)
pythonVersion=$(readPythonVersion)
createEnvironment "$pythonPath" "$pythonVersion" "$destinationFolder"
echo "Virtual environment created successfully at folder : $destinationFolder"