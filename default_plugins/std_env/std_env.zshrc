# AX-ZSH: Alex' Modular ZSH Configuration
# std_env: Setup standard environment variables

# Note: colors aren't available in the "zprofile" stage, so we have to set
# these variables here (and therefore exporting makes no sense) ...
TIMEFMT="%J - $fg[green]%U$reset_color user; $fg[red]%S$reset_color system; $fg_bold[white]%*E$reset_color total ($fg[yellow]%P$reset_color cpu)."
WATCHFMT="$fg_bold[white]%n$reset_color has $fg_bold[white]%a$reset_color from %M (%l)."
