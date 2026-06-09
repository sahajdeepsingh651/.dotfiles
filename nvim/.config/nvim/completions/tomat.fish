# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_tomat_global_optspecs
	string join \n h/help V/version
end

function __fish_tomat_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_tomat_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_tomat_using_subcommand
	set -l cmd (__fish_tomat_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c tomat -n "__fish_tomat_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_needs_command" -s V -l version -d 'Print version'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "daemon" -d 'Manage the background daemon'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "start" -d 'Start a new Pomodoro session'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "stop" -d 'Stop the current session'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "status" -d 'Get current timer status'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "watch" -d 'Continuously output status updates'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "skip" -d 'Skip to the next phase'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "pause" -d 'Pause the current timer'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "resume" -d 'Resume a paused timer'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "toggle" -d 'Toggle timer pause/resume'
complete -c tomat -n "__fish_tomat_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "start" -d 'Start the daemon in the background'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "stop" -d 'Stop the running daemon'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "status" -d 'Check daemon status'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "install" -d 'Install systemd user service'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "uninstall" -d 'Uninstall systemd user service'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "run" -d 'Run the daemon in the foreground (internal use)'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and not __fish_seen_subcommand_from start stop status install uninstall run help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from start" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from stop" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from install" -s f -l force -d 'Force overwrite existing service file without prompting'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from uninstall" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from run" -s h -l help -d 'Print help'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "start" -d 'Start the daemon in the background'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "stop" -d 'Stop the running daemon'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "status" -d 'Check daemon status'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "install" -d 'Install systemd user service'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "uninstall" -d 'Uninstall systemd user service'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "run" -d 'Run the daemon in the foreground (internal use)'
complete -c tomat -n "__fish_tomat_using_subcommand daemon; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tomat -n "__fish_tomat_using_subcommand start" -s w -l work -d 'Work duration in minutes (default: from config or 25)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -s b -l break -d 'Break duration in minutes (default: from config or 5)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -s l -l long-break -d 'Long break duration in minutes (default: from config or 15)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -s s -l sessions -d 'Sessions until long break (default: from config or 4)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -s a -l auto-advance -d 'Auto-advance mode: all, none, to-break, to-work (default: from config)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -l sound-mode -d 'Sound mode: embedded, system-beep, none (default: from config)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -l volume -d 'Volume level (0.0-1.0)' -r
complete -c tomat -n "__fish_tomat_using_subcommand start" -l sound -d 'DEPRECATED: Enable sound notifications for this session'
complete -c tomat -n "__fish_tomat_using_subcommand start" -l beep -d 'DEPRECATED: Use system beep instead of audio files'
complete -c tomat -n "__fish_tomat_using_subcommand start" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand stop" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand status" -s o -l output -d 'Output format: waybar, i3status-rs, or plain' -r -f -a "waybar\t''
i3status-rs\t''
plain\t''"
complete -c tomat -n "__fish_tomat_using_subcommand status" -s f -l format -d 'Custom text format (e.g. "{icon} {time}")' -r
complete -c tomat -n "__fish_tomat_using_subcommand status" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand watch" -s o -l output -d 'Output format: waybar, i3status-rs, or plain' -r -f -a "waybar\t''
i3status-rs\t''
plain\t''"
complete -c tomat -n "__fish_tomat_using_subcommand watch" -s f -l format -d 'Custom text format (e.g. "{icon} {time}")' -r
complete -c tomat -n "__fish_tomat_using_subcommand watch" -s i -l interval -d 'Update interval in seconds' -r
complete -c tomat -n "__fish_tomat_using_subcommand watch" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand skip" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand pause" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand resume" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand toggle" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "daemon" -d 'Manage the background daemon'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "start" -d 'Start a new Pomodoro session'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "stop" -d 'Stop the current session'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "status" -d 'Get current timer status'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "watch" -d 'Continuously output status updates'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "skip" -d 'Skip to the next phase'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "pause" -d 'Pause the current timer'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "resume" -d 'Resume a paused timer'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "toggle" -d 'Toggle timer pause/resume'
complete -c tomat -n "__fish_tomat_using_subcommand help; and not __fish_seen_subcommand_from daemon start stop status watch skip pause resume toggle help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tomat -n "__fish_tomat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "start" -d 'Start the daemon in the background'
complete -c tomat -n "__fish_tomat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "stop" -d 'Stop the running daemon'
complete -c tomat -n "__fish_tomat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "status" -d 'Check daemon status'
complete -c tomat -n "__fish_tomat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "install" -d 'Install systemd user service'
complete -c tomat -n "__fish_tomat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "uninstall" -d 'Uninstall systemd user service'
complete -c tomat -n "__fish_tomat_using_subcommand help; and __fish_seen_subcommand_from daemon" -f -a "run" -d 'Run the daemon in the foreground (internal use)'
