(self: super: {
  tabbed = super.st.overrideAttrs (oldAttrs: {
    pname = "tabbed-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/tabbed/-/archive/master/tabbed-master.tar.gz";
        sha256 = "1598gn1lqinmwsh83fxdxaanrhx1q27d2l4sb09xwpiwxdp1grp5";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ ]);
  });
})
