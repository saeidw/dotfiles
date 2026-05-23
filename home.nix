{ config, pkgs, ... }:

let
  user = import ./user.nix;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = user.username;
  home.homeDirectory = user.homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.ripgrep
    pkgs.fzf
    pkgs.fd
    pkgs.nodejs
    pkgs.timewarrior
    pkgs.taskwarrior3
    pkgs.jq
    pkgs.tree
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ### vimrc = {
    ###   source = ./vim/vimrc;
    ###   target = ".vim/vimrc";
    ### };

    coc-settings = {
      source = ./vim/coc-settings.json;
      target = ".vim/coc-settings.json";
    };

    coc-mappings = {
      source = ./vim/coc-mappings.vim;
      target = ".vim/coc-mappings.vim";
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/saeidw/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      } 
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = user.fullName;
        email = user.email;
      };
    };
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = [
      pkgs.vimPlugins.catppuccin-vim
      pkgs.vimPlugins.fzf-wrapper
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.coc-json
    ];
    extraConfig = builtins.readFile ./vim/vimrc;
  };

  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    initLua = builtins.readFile ./nvim/init.lua;
    plugins = [
      pkgs.vimPlugins.catppuccin-nvim
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.telescope-fzf-native-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.nvim-lspconfig
      {
        plugin = pkgs.vimPlugins.nvim-jdtls;
        runtime = {
          "ftplugin/java.lua" = {
            source = ./nvim/ftplugin/java.lua;
          };
        };
      }
    ];
  };
}
