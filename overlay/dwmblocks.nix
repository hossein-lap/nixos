(self: super: {
    dwmblocks = super.dwmblocks.overrideAttrs (oldAttrs: {
        pname = "dwmblocks-hos";
        version = "1.0.0";
        src = fetchTarball {
            url = "https://gitlab.com/hos-workflow/dwmblocks/-/archive/master/dwmblocks-master.tar.gz";
            sha256 = "0mvdznc3grkssa772is7bfnl2m2b9f39gwwhb1ib7gf1f1ibgq9l";
        };
        buildInputs = oldAttrs.buildInputs ++ (with super; [ xorg.libXft xorg.libX11 harfbuzz pkg-config ncurses5 ]);
    });
})
