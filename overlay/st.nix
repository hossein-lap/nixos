(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
        sha256 = "1axnd8mb5362rs90dk1393hd7bgyknxq461wshrzvc5ip639b36a";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
