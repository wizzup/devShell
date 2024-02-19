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
          cargo
          rustc
          rust-analyzer
          lldb
          
          helix
          ];
      };

    formatter.${system} = pkgs.alejandra;
  };
}
