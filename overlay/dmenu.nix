(self: super: {
	dmenu = super.dmenu.overrideAttrs (oldAttrs: {
		pname = "dmenu-hos";
		version = "1.0.0";
		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/dmenu.git";
			rev = "refs/heads/master";
			sha256 = "sha256-W+mDWZy9xAmYhtW9bWaILVaOomINsdV09QCUCT1fuIY=";
		};

		buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz fribidi pkg-config ]);
		NIX_CFLAGS_COMPILE = "-I${super.fribidi.dev}/include/fribidi";
	});
})
