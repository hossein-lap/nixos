(self: super: {
	farbfeld = super.st.overrideAttrs (oldAttrs: {
		pname = "farbfeld-hos";
		version = "1.0.0";
		# src = "/home/hos/.local/hos/workflow/st";
		# src = fetchTarball {
		#	 url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
		#	 # url = "https://gitlab.com/hos-workflow/st/-/archive/wall/st-wall.tar.gz";
		#	 sha256 = "1x6lnc4j1hfjy10ngh1s186p5nxpl2zqab9i4zjvzp6vkilh032b";
		# };

		src = super.fetchgit {
			url = "https://gitlab.com/hos-workflow/farbfeld.git";
			rev = "refs/heads/master"; # Or specify a commit hash or branch name
			sha256 = "sha256-VARyNcZhdgBjHNrkrZHbM1JyJdN7kSo7z5HjHI2l544=";
			# Optional: pin to a specific commit
			# rev = "specific_commit_hash";
			# Optional: Add a sha256 for cache consistency
			# sha256 = "1x6lnc4j1hfjy10ngh1s186p5nxpl2zqab9i4zjvzp6vkilh032b";
		};

		buildInputs = oldAttrs.buildInputs ++ (with super; [ libjpeg ]);
	});
})
