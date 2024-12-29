(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st-hos";
    version = "1.1.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
        # sha256 = "0qi36vrh82f1d8gcqn4hy2igjghy6c3fcaqcrza6h3mhp50bsz9p";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
