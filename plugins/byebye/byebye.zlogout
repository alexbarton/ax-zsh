# AX-ZSH: Alex' Modular ZSH Configuration
# byebye.zlogout -- Say goodbye to interactive users

[[ -o interactive ]] \
	&& echo "Bye, bye, $LOGNAME!"
