{ pkgs, ... }:

let
  bg  = "#171718";
  fg  = "#FFFFFF";
  bg2 = "#2A2A2A";
  fg2 = "#FAFAFA";

  accent1 = "#FF8888"; # Red
  accent2 = "#AEE75D"; # Green
  accent3 = "#FFCC55"; # Yellow
  accent4 = "#68C9FF"; # Blue
  accent5 = "#FF00FF"; # Magenta
  accent6 = "#6FEAFF"; # Cyan

  currentWindow = let
    index = "#[reverse,fg=${accent4},bg=${fg}] #I ";
    name  = "#[fg=${bg2},bg=${fg2}] #W ";
  in "${index}${name}";

  windowStatus = let
    index = "#[reverse,fg=${accent3},bg=${fg}] #I ";
    name  = "#[fg=${bg2},bg=${fg2}] #W ";
  in "${index}${name}";

  time = let
    format = "%H:%M";
    icon = pkgs.writeShellScript "icon" ''
      hour=$(date +%H)
      case "$hour" in
        00|12) echo "󱑖" ;;
        01|13) echo "󱑋" ;;
        02|14) echo "󱑌" ;;
        03|15) echo "󱑍" ;;
        04|16) echo "󱑎" ;;
        05|17) echo "󱑏" ;;
        06|18) echo "󱑐" ;;
        07|19) echo "󱑑" ;;
        08|20) echo "󱑒" ;;
        09|21) echo "󱑓" ;;
        10|22) echo "󱑔" ;;
        11|23) echo "󱑕" ;;
      esac
    '';
  in "#[reverse,fg=${accent4}] ${format} #(${icon}) ";

  pwd = "#[fg=${accent4}] #[fg=${fg}]#{b:pane_current_path}";

  git = let
    icon = pkgs.writeShellScript "branchIcon" ''
      git -C "$1" rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo ""
    '';
    branch = pkgs.writeShellScript "branchName" ''
      git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null
    '';
  in "#[fg=${accent4}]#(${icon} #{pane_current_path})#(${branch} #{pane_current_path})";

  separator = "#[fg=${fg}]|";

in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      yank
    ];

    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    terminal = "screen-256color";

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g default-terminal "screen-256color"

      # Prefix key to Alt + a
      set-option -g prefix M-a
      unbind-key C-b
      bind-key M-a send-prefix

      # Brighter Carbonfox-style
      set-option -g pane-active-border fg=${accent3}
      set-option -g pane-border-style fg=#444444
      set-option -g status-style "bg=${bg} fg=${fg}"

      # Statusline layout
      set-option -g status-left-length 0
      set-option -g status-right-length 100
      set-option -g status-right "${git} ${pwd} ${separator} ${time}"
      set-option -g window-status-current-format "${currentWindow}"
      set-option -g window-status-format "${windowStatus}"
      set-option -g window-status-separator ""
    '';
  };
}

