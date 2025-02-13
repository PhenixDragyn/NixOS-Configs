{ inputs, pkgs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  #] ++ lib.optional (builtins.isString theme) ../../../../../stylix/themes/${theme}/home-manager/nixvim.nix;

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
 
		# colorschemes = {
		#   onedark = {
		# 	  enable = true;
		# 	};
		# };

    # colorschemes = {
    #   vscode = {
    #     enable = true;
    #   };
    # };

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = false;
    };

    opts = { clipboard="unnamedplus";
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      wrap=false;
    };

    plugins = {
      comment.enable = true;
      #nvim-colorizer.enable = true;
      colorizer.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
			nvim-autopairs.enable = true;
      ts-autotag.enable = true;
      #surround.enable = true;
			trouble.enable = true;
      web-devicons.enable = true;

      neo-tree = {
				enable = true;

        window = {
				  width = 30;
				};

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
          "<leader>fg" = "live_grep";
          "<leader>fb" = "buffers";
          "<leader>fh" = "help_tags";
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
          gopls.enable = true;
					#cssls.enable = true;
          #html.enable = true;
					#jsonls.enable = true;
					lua_ls.enable = true;
          pyright.enable = true;
          ts_ls.enable = true;
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

      lualine = {
          enable = true;
          # theme = "catppuccin";
      
          settings = {
            extensions = [
              "fzf"
              "neo-tree"
            ];
     
						options = { 
						  disabled_filetypes = {
							  statusline = ["startup" "alpha"];
						  };
     
              globalstatus = true;
						};
      #
      #      sections = {
      #        lualine_a = [
      #          {
      #            name = "mode";
      #            icon = " ";
      #          }
      #        ];
      #        lualine_b = [
      #          {
      #            name = "branch";
      #            icon = "";
      #          }
      #          {
      #            name = "diff";
      #            extraConfig = {
      #              symbols = {
      #                added = " ";
      #                modified = " ";
      #                removed = " ";
      #              };
      #            };
      #          }
      #        ];
      #        lualine_c = [
      #          {
      #            name = "diagnostics";
      #            extraConfig = {
      #              sources = ["nvim_lsp"];
      #              symbols = {
      #                error = " ";
      #                warn = " ";
      #                info = " ";
      #                hint = "󰝶 ";
      #              };
      #            };
      #          }
      #          {
      #            name = "navic";
      #          }
      #        ];
      #        lualine_x = [
      #          {
      #            name = "filetype";
      #            extraConfig = {
      #              icon_only = true;
      #              separator = "";
      #              padding = {
      #                left = 1;
      #                right = 0;
      #              };
      #            };
      #          }
      #          {
      #            name = "filename";
      #            extraConfig = {
      #              path = 1;
      #            };
      #          }
      #     #      {
      #     #        name.__raw = ''
      #     #          function()
      #     #            local icon = " "
      #     #            local status = require("copilot.api").status.data
      #     #            return icon .. (status.message or " ")
      #     #          end,
      #     # 
      #     #          cond = function()
      #     #           local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
      #     #           return ok and #clients > 0
      #     #          end,
      #     #        '';
      #     #      }
      #        ];
      #        lualine_y = [
      #          {
      #            name = "progress";
      #          }
      #        ];
      #        lualine_z = [
      #          {
      #            name = "location";
      #          }
      #        ];
					 # };
          };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      colorizer
      #nvim-web-devicons
    ];

    # https://nix-community.github.io/nixvim/keymaps/index.html
		# :split and :splitv
		# :tabe, :tabc, tabn, and tabp
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
					desc = "Move focus to the upper window";
				};
      }

			# File explorer
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
			{
        key = "<leader>nh";
				action = ":nohl<CR>";
				options = {
				  desc = "Clear search highlights";
				};
			}

			# Increment/Decrement numbers
			{
        key = "<leader>+";
				action = "<C-a>";
				options = {
				  desc = "Increment number";
				};
			}
			{
        key = "<leader>-";
				action = "<C-x>";
				options = {
				  desc = "Decrement number";
				};
			}

			# Window management
			{
        key = "<leader>sv";
				action = "<C-w>v";
				options = {
				  desc = "Split window vertically";
				};
			}
			{
        key = "<leader>sh";
				action = "<C-w>s";
				options = {
				  desc = "Split window horizontal";
				};
			}
			{
        key = "<leader>se";
				action = "<C-w>=";
				options = {
				  desc = "Make splits equal size";
				};
			}
			{
        key = "<leader>sx";
				action = "<cmd>close<CR>";
				options = {
				  desc = "Close current split";
				};
			}

      # Tab management
			{
        key = "<leader>to";
				action = "<cmd>tabnew<CR>";
				options = {
				  desc = "Open new tab";
				};
			}
			{
        key = "<leader>tx";
				action = "<cmd>tabclose<CR>";
				options = {
				  desc = "Close current tab";
				};
			}
			{
        key = "<leader>tn";
				action = "<cmd>tabn<CR>";
				options = {
				  desc = "Go to next tab";
				};
			}
			{
        key = "<leader>tp";
				action = "<cmd>tabp<CR>";
				options = {
				  desc = "Go to previous tab";
				};
			}
			{
        key = "<leader>tf";
				action = "<cmd>tabnew %<CR>";
				options = {
				  desc = "Open current buffer in new tab";
				};
			}

      #Trouble
			{
        key = "<leader>xx";
				action = "<cmd>TroubleToggle<CR>";
				options = {
				  desc = "Open/Close trouble list";
				};
			}
			{
        key = "<leader>xw";
				action = "<cmd>TroubleToggle workspace_diagnostics<CR>";
				options = {
				  desc = "Open trouble workspace diagnostics";
				};
			}
			{
        key = "<leader>xd";
				action = "<cmd>TroubleToggle document_diagnostics<CR>";
				options = {
				  desc = "Open trouble document diagnostics";
				};
			}
			{
        key = "<leader>xq";
				action = "<cmd>TroubleToggle quickfix<CR>";
				options = {
				  desc = "Open trouble quickfix list";
				};
			}
			{
        key = "<leader>xl";
				action = "<cmd>TroubleToggle loclist<CR>";
				options = {
				  desc = "Open trouble location list";
				};
			}
			{
        key = "<leader>xt";
				action = "<cmd>TodoTrouble<CR>";
				options = {
				  desc = "Open todos in trouble";
				};
			}

    ];
  };
}
