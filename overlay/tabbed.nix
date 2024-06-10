(self: super: {
  tabbed = super.st.overrideAttrs (oldAttrs: {
    pname = "tabbed-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/tabbed/-/archive/master/tabbed-master.tar.gz";
        sha256 = "0hyggbw5a9z5swxm51g4ygg637vr1ag8p6139y1j6qd1vwc3cc3z";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ ]);
  });
})
