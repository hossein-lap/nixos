(self: super: {
    dwm = super.st.overrideAttrs (oldAttrs: {
        pname = "dwm-hos";
        version = "1.0.0";
        src = fetchTarball {
            url = "https://gitlab.com/hos-workflow/dwm/-/archive/master/dwm-master.tar.gz";
            sha256 = "0mvdznc3grkssa772is7bfnl2m2b9f39gwwhb1ib7gf1f1ibgq9l";
        };
        buildInputs = oldAttrs.buildInputs ++ (with super; [ fribidi ]);
    });
})
