{
  flake-utils,
  nixpkgs,
  ...
}:
let
  systems = [
    "aarch64-darwin"
    "x86_64-darwin"
    "aarch64-linux"
    "x86_64-linux"
  ];
in
flake-utils.lib.eachSystem systems (
  system:
  let
    pkgs = import nixpkgs { inherit system; };
    version = "26.513.20950";
  in
  {
    packages.codexZip = pkgs.fetchurl {
      name = "codex-darwin-arm64-${version}.zip";
      url = "https://persistent.oaistatic.com/codex-app-prod/Codex-darwin-arm64-${version}.zip";
      hash = "sha256-zSlRaoUJc4eRFbe08qS/oyqaBbfW2Epjj3hlbEmA6Cw=";
      passthru = {
        inherit version;
      };
    };
  }
)
