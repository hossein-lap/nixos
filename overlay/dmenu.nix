(self: super: {
	dmenu = super.dmenu.overrideAttrs (oldAttrs: {
		pname = "dmenu-hos";
		version = "1.0.0";
		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/dmenu.git";
			rev = "refs/heads/master";
			sha256 = "sha256-JuAUgi1QG/03zmbs2AhjyTyG9QQw97C0ZvsA+Vb0lDU=";
		};
		nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ (with super; [ pkg-config ]);
		buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz fribidi ]);
		NIX_CFLAGS_COMPILE = "-I${super.fribidi.dev}/include";
	});
})
