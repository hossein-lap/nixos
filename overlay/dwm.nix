(self: super: {
	dwm = super.dwm.overrideAttrs (oldAttrs: {
		pname = "dwm-hos";
		version = "1.0.0";
		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/dwm.git";
			rev = "refs/heads/nixos"; # Or specify a commit hash or branch name
			sha256 = "sha256-tbrL8djapqCj+/7K1a/q6/8d8NcIsokgwWBl99Fbffc=";
		};

		buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz fribidi pkg-config ]);
		NIX_CFLAGS_COMPILE = "-I${super.fribidi.dev}/include/fribidi";
	});
})

