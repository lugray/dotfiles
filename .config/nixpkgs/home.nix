{ config, pkgs, ... }:

let
  vimPlugins = pkgs.vimPlugins // pkgs.callPackage ./vim-plugins/default.nix {};
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # programs.home-manager.path = "/Users/lisaugray/src/github.com/rycee/home-manager";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "19.09";

  home.packages = with pkgs; [
    gawk
    wget
    (import ./ls-colors.nix)
    (import ./poll.nix)
  ];

  programs.git = {
    enable = true;
    userName = "Lisa Ugray";
    userEmail = "lisa.ugray@shopify.com";
    extraConfig = {
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };
      alias = {
        st = "status";
        co = "commit";
        ch = "checkout";
        alias = "config --get-regexp ^alias\\\\.";
        unstage = "reset HEAD --";
        gl = "log --oneline --graph --all";
        permission-reset = "!git diff -p -R | grep -E \"^(diff|(old|new) mode)\" | git apply";
        fpt = "force-push-this";
        m = "checkout master";
        amco = "commit -a --amend --no-edit";
        prune-all-hard = "!git fetch --all --prune && git branch -vv --no-color | grep \"\\[.*: gone\\]\" | awk \"{print \\$1}\" | xargs git branch -D";
        checkoutr = "checkout";
        br = "branch";
        rtt = "reset-to-tracking";
      };
      push.default = "simple";
      color = {
        diff = {
          whitespace = "red reverse";
          commit = "green";
          frag = "cyan";
          old = "red";
          new = "green";
          meta = "yellow";
          func = "bold magenta";
        };
        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
        ui = "auto";
      };
      diff.plist.textconv = "plutil -convert xml1 -o -";
      core = {
        commitGraph = true;
        pager = "${pkgs.gitAndTools.diff-so-fancy}/bin/diff-so-fancy | less";
        excludesfile = "${
          pkgs.writeText "global_git_ignore" ''
            .projectile
            test/debug.rb
            .tox
            .pryrc
            scratch.rb
            .DS_Store
            .byebug_history
            ugray.*
          ''
        }";
      };
      pull.ff = "only";
      track-push.default = "lugray";
      fetch.prune = true;
      diff = {
        algorithm = "patience";
        noprefix = true;
      };
      protocol.version = "2";
      gc.writeCommitGraph = true;
      credential.helper = "store --file /opt/dev/var/private/git_credential_store";
      url."https://github.com/Shopify/".insteadOf = [
        "git@github.com:Shopify/"
        "git@github.com:shopify/"
        "ssh://git@github.com/Shopify/"
        "ssh://git@github.com/shopify/"
      ];
    };
  };

  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      italic-text = "always";
      theme = "dracula";
      pager = "less -XFr";
    };
    themes = {
      dracula = builtins.readFile (
        pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        } + "/Dracula.tmTheme"
      );
    };
  };
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./init.vim;
    plugins = with vimPlugins; [
      vim-nix
      vim-ruby

      godoctor-vim
      vim-textobj-rubyblock

      # UI
      vim-gitgutter
      colorizer # Show #xxxxxx in its colour
      dracula-vim

      # Navigation
      ctrlp-vim
      ctrlp-modified-vim
      ack-vim

      # Editing
      vim-mucomplete
      vim-surround # cs"'
      vim-commentary
      vim-repeat # . support for some plugins
      vim-easy-align
      vim-textobj-user
      ReplaceWithRegister
      vim-case-change # ~ for visual select
      splitjoin-vim
      vim-multiple-cursors

      vim-dispatch
      vim-test
      vim-sensible
      vim-fugitive
    ];
  };
}
