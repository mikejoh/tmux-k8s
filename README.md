# The tmux Kubernetes status plugin

This `tmux` plugin shows you the current Kubernetes context and namespace you're using.

![k8s status bar](status_bar_with_k8s_plugin.png)

## Usage
Add `#{k8s_status}` to your `status-left` or `status-right`:

Example:
```
set -g status-right '#{k8s_status} %a %Y-%m-%d %H:%M'
```

## Installation via Tmux Plugin Manager

1. Install [Tmux Plugin Manager][tpm].
2. Add this plugin to your `~/.tmux.conf`:
```
set -g @plugin 'mikejoh/tmux-k8s'
```
3. Press [prefix] + `I` to install.

## Manual installation

1. Create the tmux plugin directory and clone this repository:
```
mkdir -p ~/.tmux/plugins && git clone https://github.com/mikejoh/tmux-k8s.git ~/.tmux/plugins/tmux-k8s
```
2. Press [prefix] + `I` to install.

### Bonus

If you want to use my status bar setup in tmux, or basically use my tmux.conf as is, you can find more info [here][tmux_gist]:

[tmux_gist]: https://gist.github.com/mikejoh/d2021745632f404ab8a47a3667168398
[tpm]: https://github.com/tmux-plugins/tpm
