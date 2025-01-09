(self: super: {
	st = super.st.overrideAttrs (oldAttrs: {
		pname = "st-hos";
		version = "1.0.0";
		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/st.git";
			rev = "refs/heads/wall"; # Or specify a commit hash or branch name
			sha256 = "sha256-4K8xJqkDndwtCNSEuSFt3ejKgMcgzfXbKggCrJY6zQI="; 	# branch: wall
			# sha256 = "sha256-VXPpcXs5lbSyULoVNmUeeXrCkehGkns+vZG8q830Xfw="; 	# branch: new-nowall
			# Optional: pin to a specific commit
			# rev = "specific_commit_hash";
			# Optional: Add a sha256 for cache consistency
			# sha256 = "1x6lnc4j1hfjy10ngh1s186p5nxpl2zqab9i4zjvzp6vkilh032b";
		};

		buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
	});
})
