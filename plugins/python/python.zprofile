# AX-ZSH: Alex' Modular ZSH Configuration
# python: Initialize Python environment

# Make sure that python(1) or python3(1) is installed
(( $+commands[python] )) || (( $+commands[python3] )) || return

# pip: require a virtual environment, don't install in the global scope!
export PIP_REQUIRE_VIRTUALENV="true"
