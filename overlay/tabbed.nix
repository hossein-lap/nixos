(self: super: {
	tabbed = super.tabbed.overrideAttrs (oldAttrs: {
		pname = "tabbed-hos";
		version = "1.0.0";
		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/tabbed.git";
			rev = "refs/heads/master";
			sha256 = "sha256-CcehNHCBwZ8ilZj5hGi9605t8LL3eLHMMPSTWB9Wnoo=";
		};

		buildInputs = oldAttrs.buildInputs ++ (with super; [ ]);
	});
})
