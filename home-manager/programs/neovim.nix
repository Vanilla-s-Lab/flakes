{ pkgs, ... }:
let generated = pkgs.callPackage ../../_sources/generated.nix { }; in
{
  programs.neovim.enable = true;
  # programs.neovim.package = pkgs.neovim-nightly;

  programs.neovim.plugins = with pkgs; [
    # https://github.com/NvChad/NvChad/blob/v1.0/lua/pluginList.lua#L243
    pkgs.vimPlugins.dashboard-nvim

    pkgs.vimPlugins.rose-pine
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.nvim-web-devicons
  ];

  programs.neovim.extraConfig = ''
    " https://neovim.io/doc/user/options.html#'background'
    set background=light

    " https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
    set cpoptions-=_

    " https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/
    set termguicolors

  '' + ''

    " https://github.com/rose-pine/neovim
    lua << EOF
      require('rose-pine').setup()
      vim.cmd('colorscheme rose-pine')
    EOF

    " https://github.com/nvim-lualine/lualine.nvim
    lua << END
      -- https://github.com/rose-pine/neovim/wiki#supported-plugins
      require('lualine').setup({
        options = { theme = 'rose-pine' }
      })
    END
  '';
}
