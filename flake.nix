{
  description = "legacy mkShell wrapper flake, for quick devShell";

  nixConfig.bash-prompt-suffix = "🔨";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShell."${system}" = with pkgs;
      mkShell {
        packages =
          [
            helix
          ]
          ++ (with haskell.packages.ghc946; [
            ghc
            cabal-install
            stack
            ghcid
            doctest
            haskell-language-server
            implicit-hie
          ]);
      };

    formatter.${system} = pkgs.alejandra;
  };
}
