
use builtin;
use str;

set edit:completion:arg-completer[tomat] = {|@words|
    fn spaces {|n|
        builtin:repeat $n ' ' | str:join ''
    }
    fn cand {|text desc|
        edit:complex-candidate $text &display=$text' '(spaces (- 14 (wcswidth $text)))$desc
    }
    var command = 'tomat'
    for word $words[1..-1] {
        if (str:has-prefix $word '-') {
            break
        }
        set command = $command';'$word
    }
    var completions = [
        &'tomat'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
            cand -V 'Print version'
            cand --version 'Print version'
            cand daemon 'Manage the background daemon'
            cand start 'Start a new Pomodoro session'
            cand stop 'Stop the current session'
            cand status 'Get current timer status'
            cand watch 'Continuously output status updates'
            cand skip 'Skip to the next phase'
            cand pause 'Pause the current timer'
            cand resume 'Resume a paused timer'
            cand toggle 'Toggle timer pause/resume'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'tomat;daemon'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
            cand start 'Start the daemon in the background'
            cand stop 'Stop the running daemon'
            cand status 'Check daemon status'
            cand install 'Install systemd user service'
            cand uninstall 'Uninstall systemd user service'
            cand run 'Run the daemon in the foreground (internal use)'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'tomat;daemon;start'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;daemon;stop'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;daemon;status'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;daemon;install'= {
            cand -f 'Force overwrite existing service file without prompting'
            cand --force 'Force overwrite existing service file without prompting'
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;daemon;uninstall'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;daemon;run'= {
            cand -h 'Print help'
            cand --help 'Print help'
        }
        &'tomat;daemon;help'= {
            cand start 'Start the daemon in the background'
            cand stop 'Stop the running daemon'
            cand status 'Check daemon status'
            cand install 'Install systemd user service'
            cand uninstall 'Uninstall systemd user service'
            cand run 'Run the daemon in the foreground (internal use)'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'tomat;daemon;help;start'= {
        }
        &'tomat;daemon;help;stop'= {
        }
        &'tomat;daemon;help;status'= {
        }
        &'tomat;daemon;help;install'= {
        }
        &'tomat;daemon;help;uninstall'= {
        }
        &'tomat;daemon;help;run'= {
        }
        &'tomat;daemon;help;help'= {
        }
        &'tomat;start'= {
            cand -w 'Work duration in minutes (default: from config or 25)'
            cand --work 'Work duration in minutes (default: from config or 25)'
            cand -b 'Break duration in minutes (default: from config or 5)'
            cand --break 'Break duration in minutes (default: from config or 5)'
            cand -l 'Long break duration in minutes (default: from config or 15)'
            cand --long-break 'Long break duration in minutes (default: from config or 15)'
            cand -s 'Sessions until long break (default: from config or 4)'
            cand --sessions 'Sessions until long break (default: from config or 4)'
            cand -a 'Auto-advance mode: all, none, to-break, to-work (default: from config)'
            cand --auto-advance 'Auto-advance mode: all, none, to-break, to-work (default: from config)'
            cand --sound-mode 'Sound mode: embedded, system-beep, none (default: from config)'
            cand --volume 'Volume level (0.0-1.0)'
            cand --sound 'DEPRECATED: Enable sound notifications for this session'
            cand --beep 'DEPRECATED: Use system beep instead of audio files'
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;stop'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;status'= {
            cand -o 'Output format: waybar, i3status-rs, or plain'
            cand --output 'Output format: waybar, i3status-rs, or plain'
            cand -f 'Custom text format (e.g. "{icon} {time}")'
            cand --format 'Custom text format (e.g. "{icon} {time}")'
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;watch'= {
            cand -o 'Output format: waybar, i3status-rs, or plain'
            cand --output 'Output format: waybar, i3status-rs, or plain'
            cand -f 'Custom text format (e.g. "{icon} {time}")'
            cand --format 'Custom text format (e.g. "{icon} {time}")'
            cand -i 'Update interval in seconds'
            cand --interval 'Update interval in seconds'
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;skip'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;pause'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;resume'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;toggle'= {
            cand -h 'Print help (see more with ''--help'')'
            cand --help 'Print help (see more with ''--help'')'
        }
        &'tomat;help'= {
            cand daemon 'Manage the background daemon'
            cand start 'Start a new Pomodoro session'
            cand stop 'Stop the current session'
            cand status 'Get current timer status'
            cand watch 'Continuously output status updates'
            cand skip 'Skip to the next phase'
            cand pause 'Pause the current timer'
            cand resume 'Resume a paused timer'
            cand toggle 'Toggle timer pause/resume'
            cand help 'Print this message or the help of the given subcommand(s)'
        }
        &'tomat;help;daemon'= {
            cand start 'Start the daemon in the background'
            cand stop 'Stop the running daemon'
            cand status 'Check daemon status'
            cand install 'Install systemd user service'
            cand uninstall 'Uninstall systemd user service'
            cand run 'Run the daemon in the foreground (internal use)'
        }
        &'tomat;help;daemon;start'= {
        }
        &'tomat;help;daemon;stop'= {
        }
        &'tomat;help;daemon;status'= {
        }
        &'tomat;help;daemon;install'= {
        }
        &'tomat;help;daemon;uninstall'= {
        }
        &'tomat;help;daemon;run'= {
        }
        &'tomat;help;start'= {
        }
        &'tomat;help;stop'= {
        }
        &'tomat;help;status'= {
        }
        &'tomat;help;watch'= {
        }
        &'tomat;help;skip'= {
        }
        &'tomat;help;pause'= {
        }
        &'tomat;help;resume'= {
        }
        &'tomat;help;toggle'= {
        }
        &'tomat;help;help'= {
        }
    ]
    $completions[$command]
}
