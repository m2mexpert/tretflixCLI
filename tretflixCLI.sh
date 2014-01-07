#!/bin/bash

# Relaunch as root if user didn't use "sudo"
[ `whoami` = root ] || exec sudo $0 "$@"

set -o nounset

CLI_ARGS=("$@")
DEFAULT_IFS=$IFS
CLI_Version="1.0.1"

# Verify that the user has run the script using "sudo" user
if [[ $(whoami) != "root" ]]; then
  echo
  echo "!! ERROR: This script must be run as root..."
  echo
  exit 1
fi

function getScriptAbsoluteDir {
  # @description used to get the script path
  # @param $1 the script $0 parameter
  local script_invoke_path="$1"
  local cwd=`pwd`

  # absolute path ? if so, the first character is a /
  if test "x${script_invoke_path:0:1}" = 'x/'
  then
    FCN_RESULT=`dirname "$script_invoke_path"`
  else
    FCN_RESULT=`dirname "$cwd/$script_invoke_path"`
  fi
}

function import() {
  # @description importer routine to get external functionality.
  # @description the first location searched is the script directory.
  # @description if not found, search the module in the paths contained in $SHELL_LIBRARY_PATH environment variable
  # @param $1 the .shinc file to import, without .shinc extension
  module=$1

  if test "x$module" == "x"; then
    echo "$script_name : Unable to import unspecified module. Dying."
    exit 1
  fi

  if test "x${script_absolute_dir:-notset}" == "xnotset"; then
    echo "$script_name : Undefined script absolute dir. Did you remove getScriptAbsoluteDir? Dying."
    exit 1
  fi

  if test "x$script_absolute_dir" == "x"; then
    echo "$script_name : empty script path. Dying."
    exit 1
  fi

  if test -e "$script_absolute_dir/$module.shinc"; then
    # import from script directory
    . "$script_absolute_dir/$module.shinc"
    return
  elif test "x${SHELL_LIBRARY_PATH:-notset}" != "xnotset"; then
    # import from the shell script library path
    # save the separator and use the ':' instead
    local saved_IFS="$IFS"
    IFS=':'
    for path in $SHELL_LIBRARY_PATH; do
      if test -e "$path/$module.shinc"; then
        . "$path/$module.shinc"
        return
      fi
    done
    # restore the standard separator
    IFS="$saved_IFS"
  fi
  echo "$script_name : Unable to find module $module."
  exit 1
}

function help() {
  echo "Usage: tretflix [COMMAND] ....."
  echo
  echo "COMMANDS:"
  echo "  tretflix config"
  echo "  tretflix downloads"
  echo "  tretflix network"
  echo "  tretflix service"
  echo "  tretflix shares"
  echo
  exit 1
}

# get script name and path (Required for import function)
script_invoke_path="$0"
script_name=`basename "$0"`
getScriptAbsoluteDir "$script_invoke_path"
script_absolute_dir=$FCN_RESULT

# get config variables from config file
source "$script_absolute_dir/config"

# Import modules
import "modules/about"
import "modules/config"
import "modules/couchpotato"
import "modules/downloads"
import "modules/headphones"
import "modules/network"
import "modules/plexmediaserver"
import "modules/sabnzbdplus"
import "modules/service"
import "modules/shares"
import "modules/sickbeard"
import "modules/tools"
import "modules/transmission"
import "modules/update"

# call appropriate module based on options entered by the user via CLI
if test "${CLI_ARGS[0]+isset}"; then
  shopt -s nocasematch
  case "${CLI_ARGS[0]}" in
    about)
      about__command_handler
      ;;
    config)
      config__command_handler
      ;;
    downloads)
      downloads__command_handler
      ;;
    network)
      network__command_handler
      ;;
    service)
      service__command_handler
      ;;
    shares)
      shares__command_handler
      ;;
    update)
      update__command_handler
      ;;
    *)
      help
  esac
else
  help
fi

echo
exit