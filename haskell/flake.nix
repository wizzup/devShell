{
  description = "legacy mkShell wrapper flake, for quick devShell";

  nixConfig.bash-prompt = "hs:🪛\\W ";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShell."${system}" = with pkgs; mkShell {
          packages = [
            helix
          ] ++
          (with haskellPackages; [
            ghc
            cabal-install
            stack
            ghcid
            haskell-language-server
            implicit-hie
          ]);
        };
    };

}
