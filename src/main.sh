#!/bin/bash

export SCRIPT_DIR=$(dirname ${0})

wolfram_script () { 
    wolframscript -file "${1}"
    WS_EXIT_CODE=$(echo $?)
    case $WS_EXIT_CODE in
        0)
            ;;
        139)
            echo "::warning::Warning: wolframscript did not exit cleanly"
            ;;
        *)
            exit $WS_EXIT_CODE
            ;;
    esac
}

echo "::group::Installing dependencies..."
wolfram_script "${SCRIPT_DIR}/install_dependencies.wls"
echo "::endgroup::"

echo "::group::Checking Paclet..."
wolfram_script "${SCRIPT_DIR}/check_paclet.wls"
echo "::endgroup::"