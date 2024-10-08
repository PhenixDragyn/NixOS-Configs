{ ... }:

{
  programs.imv = {
    enable = true;
    settings = {
		  binds = {
		 	  h = "zoom 1";
		    j = "prev";
			  k = "next";
			  l = "zoom -1";
			
		    #w = "exec swww img $imv_current_file";
			};
    };
  };
}
