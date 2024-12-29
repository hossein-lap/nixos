(self: super: {
    tabbed = super.st.overrideAttrs (oldAttrs: {
        pname = "tabbed-hos";
        version = "1.1.0";
        src = fetchTarball {
            url = "https://gitlab.com/hos-workflow/tabbed/-/archive/master/tabbed-master.tar.gz";
            # sha256 = "1k5cnl36c7cv7fi8aayk312fhbn54yjazvn8iqnm1242369a1v38";
        };
        buildInputs = oldAttrs.buildInputs ++ (with super; [ ]);
    });
})
