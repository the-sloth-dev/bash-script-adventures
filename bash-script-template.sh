#!/usr/bin/env bash

# ----- Variables -----
DEFAULT_VALUE="some value"

# ----- Functions -----

function arguments {
    echo "
        ARGUMENTS:
                        --required-param      Required
                                              Show case for a required parameter. Here we should explain the usage of the parameter

                        --optional_param      Optional, Default: $DEFAULT_VALUE
                                              Show case for a optional parameter. Here we should explain the usage of the parameter

                        --debug               Optional.
                                              Enables debug mode.

                        --help                Prints out help.

                        --usage               Prints out help.
    "
}

function help {
    echo "
        NAME
            $0 - short explanation what the script does

            SYNOPSIS
                $0 [--required-param  <value>] [--optional_param <value>]
                   [--debug] [--help] [--usage]
            $(arguments)
    "
}

function usage {
    echo " $(help)

            DESCRIPTION
                Sample script that shows template to be used for bashing.

                In this section we should explain what the script does.

                DEBUG

                A debug flag has been provided to enable script execution in debug mode. This is done
                to allow troubleshooting in case of issues with the script.

            EXIT STATUS CODES:
                Exit code 0  Success.

                Exit code 1  General errors, Miscellaneous errors, such as 'divide by zero'
                             and other impermissible operations.

                Exit code 2  Misuse of script operations. Missing keyword, argument, or permission problem.

                Exit code 3  General issues. Missing artifacts, files, project, or failure to retrieve a project.

                Exit code ?  Non-zero exit status returned. Command failed to execute.
    "
}

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
error() {
    echo -e "\e[31m$(date "+%Y-%m-%d %H:%M:%S") - ERROR: ${1}\e[0m"
}

attention() {
    echo -e "\e[31m$(date "+%Y-%m-%d %H:%M:%S") - ATTENTION: ${1}\e[0m"
}

note() {
    echo -e "\e[33m$(date "+%Y-%m-%d %H:%M:%S") - NOTE: ${1}\e[0m"
}

info() {
    echo -e "\e[32m$(date "+%Y-%m-%d %H:%M:%S") - INFO: ${1}\e[0m"
}

some_function() {
    local _param=$1

    info "beginning execution of function with ${_param}"
    # TODO: Add logic here
    info "completed execution of function with ${_param}"
}

# ----- Main -----

if [[ $# -eq 0 ]]; then
    usage; error "expects arguments"; exit 1;
fi

# argument parsing
while (($#)); do
    case "$1" in
        --required-param      ) required_param=${2};                     shift 2;;
        --optional_param      ) optional_param=${2};                     shift 2;;
        --debug               ) debug=1;                                 shift 1;;
        --help                ) help;                                    exit 0;;
        --usage               ) usage;                                   exit 0;;
        *                     ) usage; error "unknown argument";         exit 1;;
    esac
done

if [[ ${debug} ]] ; then
    echo "debug mode activated"
    set -x
fi

if [[ -z ${required_param} ]]; then
    error "argument --required-param is required";
    exit 2;
fi

if [[ -z ${optional_param} ]]; then
    warn "argument --optional-param not provided. default: '${DEFAULT_VALUE}'";
    optional_param=${DEFAULT_VALUE}
fi

# ----- Script logic ----

some_function "${required_param}"

exit 0
