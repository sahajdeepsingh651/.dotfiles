
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'tomat' -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)

    $commandElements = $commandAst.CommandElements
    $command = @(
        'tomat'
        for ($i = 1; $i -lt $commandElements.Count; $i++) {
            $element = $commandElements[$i]
            if ($element -isnot [StringConstantExpressionAst] -or
                $element.StringConstantType -ne [StringConstantType]::BareWord -or
                $element.Value.StartsWith('-') -or
                $element.Value -eq $wordToComplete) {
                break
        }
        $element.Value
    }) -join ';'

    $completions = @(switch ($command) {
        'tomat' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('-V', '-V ', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('--version', '--version', [CompletionResultType]::ParameterName, 'Print version')
            [CompletionResult]::new('daemon', 'daemon', [CompletionResultType]::ParameterValue, 'Manage the background daemon')
            [CompletionResult]::new('start', 'start', [CompletionResultType]::ParameterValue, 'Start a new Pomodoro session')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop the current session')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Get current timer status')
            [CompletionResult]::new('watch', 'watch', [CompletionResultType]::ParameterValue, 'Continuously output status updates')
            [CompletionResult]::new('skip', 'skip', [CompletionResultType]::ParameterValue, 'Skip to the next phase')
            [CompletionResult]::new('pause', 'pause', [CompletionResultType]::ParameterValue, 'Pause the current timer')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a paused timer')
            [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle timer pause/resume')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'tomat;daemon' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('start', 'start', [CompletionResultType]::ParameterValue, 'Start the daemon in the background')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop the running daemon')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Check daemon status')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install systemd user service')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall systemd user service')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run the daemon in the foreground (internal use)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'tomat;daemon;start' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;daemon;stop' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;daemon;status' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;daemon;install' {
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Force overwrite existing service file without prompting')
            [CompletionResult]::new('--force', '--force', [CompletionResultType]::ParameterName, 'Force overwrite existing service file without prompting')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;daemon;uninstall' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;daemon;run' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help')
            break
        }
        'tomat;daemon;help' {
            [CompletionResult]::new('start', 'start', [CompletionResultType]::ParameterValue, 'Start the daemon in the background')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop the running daemon')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Check daemon status')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install systemd user service')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall systemd user service')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run the daemon in the foreground (internal use)')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'tomat;daemon;help;start' {
            break
        }
        'tomat;daemon;help;stop' {
            break
        }
        'tomat;daemon;help;status' {
            break
        }
        'tomat;daemon;help;install' {
            break
        }
        'tomat;daemon;help;uninstall' {
            break
        }
        'tomat;daemon;help;run' {
            break
        }
        'tomat;daemon;help;help' {
            break
        }
        'tomat;start' {
            [CompletionResult]::new('-w', '-w', [CompletionResultType]::ParameterName, 'Work duration in minutes (default: from config or 25)')
            [CompletionResult]::new('--work', '--work', [CompletionResultType]::ParameterName, 'Work duration in minutes (default: from config or 25)')
            [CompletionResult]::new('-b', '-b', [CompletionResultType]::ParameterName, 'Break duration in minutes (default: from config or 5)')
            [CompletionResult]::new('--break', '--break', [CompletionResultType]::ParameterName, 'Break duration in minutes (default: from config or 5)')
            [CompletionResult]::new('-l', '-l', [CompletionResultType]::ParameterName, 'Long break duration in minutes (default: from config or 15)')
            [CompletionResult]::new('--long-break', '--long-break', [CompletionResultType]::ParameterName, 'Long break duration in minutes (default: from config or 15)')
            [CompletionResult]::new('-s', '-s', [CompletionResultType]::ParameterName, 'Sessions until long break (default: from config or 4)')
            [CompletionResult]::new('--sessions', '--sessions', [CompletionResultType]::ParameterName, 'Sessions until long break (default: from config or 4)')
            [CompletionResult]::new('-a', '-a', [CompletionResultType]::ParameterName, 'Auto-advance mode: all, none, to-break, to-work (default: from config)')
            [CompletionResult]::new('--auto-advance', '--auto-advance', [CompletionResultType]::ParameterName, 'Auto-advance mode: all, none, to-break, to-work (default: from config)')
            [CompletionResult]::new('--sound-mode', '--sound-mode', [CompletionResultType]::ParameterName, 'Sound mode: embedded, system-beep, none (default: from config)')
            [CompletionResult]::new('--volume', '--volume', [CompletionResultType]::ParameterName, 'Volume level (0.0-1.0)')
            [CompletionResult]::new('--sound', '--sound', [CompletionResultType]::ParameterName, 'DEPRECATED: Enable sound notifications for this session')
            [CompletionResult]::new('--beep', '--beep', [CompletionResultType]::ParameterName, 'DEPRECATED: Use system beep instead of audio files')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;stop' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;status' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'Output format: waybar, i3status-rs, or plain')
            [CompletionResult]::new('--output', '--output', [CompletionResultType]::ParameterName, 'Output format: waybar, i3status-rs, or plain')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Custom text format (e.g. "{icon} {time}")')
            [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Custom text format (e.g. "{icon} {time}")')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;watch' {
            [CompletionResult]::new('-o', '-o', [CompletionResultType]::ParameterName, 'Output format: waybar, i3status-rs, or plain')
            [CompletionResult]::new('--output', '--output', [CompletionResultType]::ParameterName, 'Output format: waybar, i3status-rs, or plain')
            [CompletionResult]::new('-f', '-f', [CompletionResultType]::ParameterName, 'Custom text format (e.g. "{icon} {time}")')
            [CompletionResult]::new('--format', '--format', [CompletionResultType]::ParameterName, 'Custom text format (e.g. "{icon} {time}")')
            [CompletionResult]::new('-i', '-i', [CompletionResultType]::ParameterName, 'Update interval in seconds')
            [CompletionResult]::new('--interval', '--interval', [CompletionResultType]::ParameterName, 'Update interval in seconds')
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;skip' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;pause' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;resume' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;toggle' {
            [CompletionResult]::new('-h', '-h', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            [CompletionResult]::new('--help', '--help', [CompletionResultType]::ParameterName, 'Print help (see more with ''--help'')')
            break
        }
        'tomat;help' {
            [CompletionResult]::new('daemon', 'daemon', [CompletionResultType]::ParameterValue, 'Manage the background daemon')
            [CompletionResult]::new('start', 'start', [CompletionResultType]::ParameterValue, 'Start a new Pomodoro session')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop the current session')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Get current timer status')
            [CompletionResult]::new('watch', 'watch', [CompletionResultType]::ParameterValue, 'Continuously output status updates')
            [CompletionResult]::new('skip', 'skip', [CompletionResultType]::ParameterValue, 'Skip to the next phase')
            [CompletionResult]::new('pause', 'pause', [CompletionResultType]::ParameterValue, 'Pause the current timer')
            [CompletionResult]::new('resume', 'resume', [CompletionResultType]::ParameterValue, 'Resume a paused timer')
            [CompletionResult]::new('toggle', 'toggle', [CompletionResultType]::ParameterValue, 'Toggle timer pause/resume')
            [CompletionResult]::new('help', 'help', [CompletionResultType]::ParameterValue, 'Print this message or the help of the given subcommand(s)')
            break
        }
        'tomat;help;daemon' {
            [CompletionResult]::new('start', 'start', [CompletionResultType]::ParameterValue, 'Start the daemon in the background')
            [CompletionResult]::new('stop', 'stop', [CompletionResultType]::ParameterValue, 'Stop the running daemon')
            [CompletionResult]::new('status', 'status', [CompletionResultType]::ParameterValue, 'Check daemon status')
            [CompletionResult]::new('install', 'install', [CompletionResultType]::ParameterValue, 'Install systemd user service')
            [CompletionResult]::new('uninstall', 'uninstall', [CompletionResultType]::ParameterValue, 'Uninstall systemd user service')
            [CompletionResult]::new('run', 'run', [CompletionResultType]::ParameterValue, 'Run the daemon in the foreground (internal use)')
            break
        }
        'tomat;help;daemon;start' {
            break
        }
        'tomat;help;daemon;stop' {
            break
        }
        'tomat;help;daemon;status' {
            break
        }
        'tomat;help;daemon;install' {
            break
        }
        'tomat;help;daemon;uninstall' {
            break
        }
        'tomat;help;daemon;run' {
            break
        }
        'tomat;help;start' {
            break
        }
        'tomat;help;stop' {
            break
        }
        'tomat;help;status' {
            break
        }
        'tomat;help;watch' {
            break
        }
        'tomat;help;skip' {
            break
        }
        'tomat;help;pause' {
            break
        }
        'tomat;help;resume' {
            break
        }
        'tomat;help;toggle' {
            break
        }
        'tomat;help;help' {
            break
        }
    })

    $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
        Sort-Object -Property ListItemText
}
