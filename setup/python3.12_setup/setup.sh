#!/bin/bash

function createEnvironment()
{
    bash create_python3.12_environment.sh "$1"
    creationCode=$?

    if [[ $creationCode != 0 ]]
    then
        echo ""
        echo "Since environment was not created correctly, the final setup of dependencies will not be performed now"
        exit 1
    fi
}

# Reference to function creation and calls: https://devqa.io/create-call-bash-functions/
function initializeDirectory() {
    cd .venv3.12/Scripts
}

function activateEnvironment(){
    source ./activate
}

function basicSetup(){
    # where python

    # This should display: Python 3.12
    python.exe --version

    # This command should display something like:
    # pip 23.3.2 from {repository root folder}\.venv\Lib\site-packages\pip (python 3.12)
    python -m pip -V

    python -m pip install pip-tools

    python.exe -m pip install --upgrade pip
}

function runPipCompile(){
    pip-compile ./../../requirements.in --output-file ./../../requirements.txt
}

function installRequiredDepedencies(){
    python -m pip install -r ./../../requirements.txt
}

function freezeAllDependenciesInASeparateFile()
{
    python -m pip freeze --all > ./../../requirementsALL.txt
}

createEnvironment
initializeDirectory
activateEnvironment
basicSetup
runPipCompile
installRequiredDepedencies
freezeAllDependenciesInASeparateFile