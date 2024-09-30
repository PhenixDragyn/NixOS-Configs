{ pkgs, ... }:

{
	programs.yazi = {
		enable = true;
		enableZshIntegration = true;

		settings = {
 			manager = {
 				ratio = [ 2 3 5 ];
 				sort_by = "natural";
 				sort_sensitive = true;
 				sort_reverse = false;
 				sort_dir_first = true;
 				linemode = "none";
 				show_hidden = false;
 				show_symlink = true;
 			};

      input = {
			  find_origin = "bottom-left";
				find_offset = [0 2 50 3];
			};

 			preview = {
 			# 	image_filter = "lanczos3";
 			 	image_quality = 90;
 			# 	tab_size = 1;
 				max_width = 768;
 				max_height = 1024;
 			# 	cache_dir = "";
 			# 	ueberzug_scale = 1;
 			# 	ueberzug_offset = [
 			# 		0
 			# 		0
 			# 		0
 			# 		0
 			# 	];
 			};
    
 			# tasks = {
 			# 	micro_workers = 5;
 			# 	macro_workers = 10;
 			# 	bizarre_retry = 5;
 			# };
 		};

		theme = {
		  status = {
			  #separator_open = "█";
        #separator_close = "█";
        separator_open = "";
			  separator_close = "";
				#separator_open = "";
				#separator_close = "";

			};

      which = {
			  separator = "  ";
			};

		  #input = {
			#  border = { fg = "black"; };
			#};
		};
	};
}
