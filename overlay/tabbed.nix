(self: super: {
	tabbed = super.st.overrideAttrs (oldAttrs: {
		pname = "tabbed-hos";
		version = "1.0.0";
		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/tabbed.git";
			rev = "refs/heads/master";
			sha256 = "sha256-IRIrhXShWcmcVqt21H1Pz3Uh/NLwdlNqliXUiDfELLQ=";
		};
		buildInputs = oldAttrs.buildInputs ++ (with super; [ ]);
	});
})
