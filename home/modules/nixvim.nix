{ config, lib, pkgs, stable, unstable, buildSettings, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
 
    colorschemes = {
      vscode = {
        enable = true;
      };
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = false;
    };

    opts = {
      clipboard="unnamedplus";
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      wrap=false;
    };

    plugins = {
      comment.enable = true;
      nvim-colorizer.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
			nvim-autopairs.enable = true;
			nix.enable = true;
      #surround.enable = true;

      neo-tree = {
				enable = true;

				filesystem = {
					window = {
						mappings = {
							"\\" = "close_window";
						};
					};
				};
      };

			telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
        };
      };

      treesitter = {
        enable = true;
        nixGrammars = true;
      };

      lsp = {
        enable = true;
        servers = {
				  bashls.enable = true;
					cssls.enable = true;
          gopls.enable = true;
          html.enable = true;
					jsonls.enable = true;
					lua-ls.enable = true;
          pyright.enable = true;
          tsserver.enable = true;
        };
      };

      lspkind = {
        enable = true;
        cmp.ellipsisChar = "...";
        cmp.menu = {
          buffer = "[Buffer]";
          nvim_lsp = "[LSP]";
          luasnip = "[LuaSnip]";
          nvim_lua = "[Lua]";
          latex_symbols = "[Latex]";
        };
        cmp.after = ''
        function(entry, vim_item, kind)
        local strings = vim.split(kind.kind, "%s", { trimempty = true })
        kind.kind = " " .. strings[1] .. " "
        kind.menu = "   " .. strings[2]
        return kind
        end
        '';
      };

      #lsp-lines.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      colorizer
      nvim-web-devicons
    ];

    # https://nix-community.github.io/nixvim/keymaps/index.html
    keymaps = [  
      {
        key = "<leader>sw";
	      action = "<cmd>execute 'silent! write !sudo tee % > /dev/null' <bar> edit!<cr>"; 
	      options = {
	        desc = "Sudo write";
	        silent = true;
	      };
      }
      {
        key = "<Esc><Esc>";
				action = "<C-\\><C-n>";
				options = {
					desc = "Exit terminal mode";
				};
      }
      {
        key = "<C-h>";
				action = "<C-w><C-h>";
				options = {
					desc = "Move focus to the left window";
				};
      }
      {
        key = "<C-l>";
				action = "<C-w><C-l>";
				options = {
					desc = "Move focus to the right window";
				};
      }
      {
        key = "<C-j>";
				action = "<C-w><C-j>";
				options = {
					desc = "Move focus to the lower window";
				};
      }
      {
        key = "<C-k>";
				action = "<C-w><C-k>";
				options = {
					desc = " Move focus to the upper window";
				};
      }
      {
        key = "\\";
        action = "<cmd>Neotree reveal<cr>";
        options = {
          desc = "NeoTree reveal";
        };
      }
      {
        key = "<leader>e";
				action = "<cmd>Neotree filesystem toggle<cr>";
				options = {
					desc = "NeoTree toggle";
				};
      }
    ];
  };
}
