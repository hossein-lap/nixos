(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
        sha256 = "1598gn1lqinmwsh83fxdxaanrhx1q27d2l4sb09xwpiwxdp1grp5";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
