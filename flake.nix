{
  description = "My personal opinionated configs for neovim";

  # Nixpkgs / NixOS version to use.
  inputs.nixpkgs.url = "nixpkgs/nixos-21.05";

  outputs = { self, nixpkgs }:
    let

      # to work with older version of flakes
      lastModifiedDate = self.lastModifiedDate or self.lastModified or "19700101";

      # Generate a user-friendly version number.
      version = builtins.substring 0 8 lastModifiedDate;

      # System types to support.
      supportedSystems = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" "i686-linux" ];

      # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Nixpkgs instantiated for supported system types.
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; overlays = [ self.overlay ]; });

    in

    {

      packages = forAllSystems (system:
          let 
            pkgs = nixpkgs.legacyPackages.${system};
            rcSnippets = (import ./vimrc-snippets.nix);
            myNvim = pkgs.neovim.override {
              configure = {
                customRC= with rcSnippets; ''
                  ${preamble}
                  ${jkToEsc}
                  ${swapColonComma}
                  ${switchWinOnGSpace}
                  ${applyTheme}
                '';
                packages.myVimPackage = with pkgs.vimPlugins; {
                  start = [
                    vim-sensible
                    vim-surround
                    vim-unimpaired
                    vim-repeat
                    vim-colors-solarized
                  ];
                };
              };
            };
          in
	{
            myNvim_generic = myNvim;
        });

      # The default package for 'nix build'. This makes sense if the
      # flake provides only one package or there is a clear "main"
      # package.
      defaultPackage = forAllSystems (system: self.packages.${system}.myNvim_generic);
    };
}
