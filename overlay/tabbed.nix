(self: super: {
  tabbed = super.st.overrideAttrs (oldAttrs: {
    pname = "tabbed-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/tabbed/-/archive/master/tabbed-master.tar.gz";
        sha256 = "1y0gk7sfylgmcxybjlpm1a3falnk5048gkwxdixaaff875b8i9ab";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ ]);
  });
})
