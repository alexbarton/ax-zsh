# AX-ZSH: Alex' Modular ZSH Configuration
# std_options.zshrc: Setup standard ZSH options

# Change directories by just entering their names
setopt auto_cd

# Automatically push directories to the directory stack
setopt autopushd
setopt pushdignoredups

# Recognize comments in interactive mode, too
setopt interactivecomments

# Display PID when suspending processes as well
setopt longlistjobs

# Watch for logins of everyone but me
watch=(notme)
