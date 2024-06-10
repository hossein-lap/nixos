(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
