{
  self,
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
  in
  {
    packages.codexWebResources = pkgs.stdenvNoCC.mkDerivation {
      pname = "codex-web-resources";
      version = self.packages.${system}.codexZip.version;

      src = self.packages.${system}.codexZip;

      nativeBuildInputs = [ pkgs.unzip ];

      dontConfigure = true;
      dontBuild = true;

      unpackPhase = ''
        runHook preUnpack

        unzip -q "$src"

        runHook postUnpack
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p "$out"
        cp -R Codex.app/Contents/Resources/plugins "$out/plugins"

        chromeManifestScript="$out/plugins/openai-bundled/plugins/chrome/scripts/installManifest.mjs"
        chromeExtensionHost="${
          self.packages.${system}.codex_chrome_extension_host
        }/bin/codex-chrome-extension-host"
        substituteInPlace "$chromeManifestScript" \
          --replace-fail 'let t=a(o);' "let t=\"$chromeExtensionHost\";" \
          --replace-fail 'path:a(o)' "path:\"$chromeExtensionHost\""
      ''
      + pkgs.lib.optionalString (system == "aarch64-darwin") ''
        install -m755 Codex.app/Contents/Resources/node "$out/node"
        install -m755 Codex.app/Contents/Resources/node_repl "$out/node_repl"
      ''
      + pkgs.lib.optionalString (system == "x86_64-linux") ''
        install -m755 ${pkgs.nodejs}/bin/node "$out/node"
        install -m755 ${
          self.packages.${system}.codex-primary-runtime
        }/dependencies/bin/node_repl "$out/node_repl"
      ''
      + pkgs.lib.optionalString (system != "aarch64-darwin" && system != "x86_64-linux") ''
        echo "codex-web resources are only packaged for aarch64-darwin and x86_64-linux" >&2
        exit 1
      ''
      + ''
        runHook postInstall
      '';
    };
  }
)
