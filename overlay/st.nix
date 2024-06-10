(self: super: {
  st = super.st.overrideAttrs (oldAttrs: {
    pname = "st-hos";
    version = "1.0.0";
    src = fetchTarball {
        url = "https://gitlab.com/hos-workflow/st/-/archive/master/st-master.tar.gz";
        sha256 = "19z8bpiw3axqw52w1mjc7mdxn6ijbpwyp5yciggz4rc7k3y9abhq";
    };
    buildInputs = oldAttrs.buildInputs ++ (with super; [ harfbuzz ]);
  });
})
