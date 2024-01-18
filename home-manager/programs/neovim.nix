{ pkgs, nixosConfig, config, generated, ... }:
{
  programs.neovim.enable = true;
  home.sessionVariables = { EDITOR = "nvim"; };

  programs.neovim.plugins = with pkgs; [
    # https://github.com/NvChad/NvChad/blob/v1.0/lua/pluginList.lua#L243
    pkgs.vimPlugins.dashboard-nvim

    pkgs.vimPlugins.rose-pine
    pkgs.vimPlugins.lualine-nvim
    pkgs.vimPlugins.nvim-web-devicons

    pkgs.vimPlugins.bufferline-nvim

    pkgs.vimPlugins.nvim-lspconfig
    # https://nixos.wiki/wiki/Tree_sitters
    pkgs.vimPlugins.nvim-treesitter.withAllGrammars

    pkgs.vimPlugins.indent-blankline-nvim
    pkgs.vimPlugins.neoformat

    pkgs.vimPlugins.gitsigns-nvim
    pkgs.vimPlugins.vim-fugitive
  ];

  home.packages = [
    pkgs.rnix-lsp
    pkgs.xclip
  ];

  programs.neovim.extraConfig = ''
    " https://neovim.io/doc/user/options.html#'background'
    set background=light

    " https://vi.stackexchange.com/questions/6194/why-do-cw-and-ce-do-the-same-thing
    set cpoptions-=_

    " https://jdhao.github.io/2018/10/19/tmux_nvim_true_color/
    set termguicolors

    " https://vim.fandom.com/wiki/Working_with_long_lines
    set linebreak

    " https://jdhao.github.io/2019/01/11/line_number_setting_nvim/
    set number

    " https://twitter.com/neovim/status/1548665836285591552
    set mouse=

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

    " https://github.com/akinsho/bufferline.nvim/
    lua << EOF
      -- https://github.com/rose-pine/neovim/wiki#supported-plugins
      local highlights = require('rose-pine.plugins.bufferline')
      require('bufferline').setup({ highlights = highlights })
    EOF

    " https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    lua << EOF
      require'lspconfig'.rnix.setup{}
    EOF

    " https://github.com/nvim-treesitter/nvim-treesitter/
    lua << EOF
      require'nvim-treesitter.configs'.setup {
        highlight = { enable = true }
      }
    EOF

    " https://github.com/lewis6991/gitsigns.nvim
    lua << EOF
      require('gitsigns').setup({
        current_line_blame = true
      })
    EOF
  '';
}
