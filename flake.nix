{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # Update with: nix flake lock --update-input ocnix
    ocnix.url = "github:mirko-plowtech/opencode-nix";
    opencode.url = "github:anomalyco/opencode";
  };

  outputs = { nixpkgs, ocnix, opencode, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}.extend ocnix.overlays.default;
    in {
      packages.${system}.default = pkgs.lib.opencode.wrapOpenCode {
        name = "my-opencode";
        opencode = opencode.packages.${system}.default;
        modules = [
          (import "${ocnix}/examples/chief-coding-assistant")
        ];
      };
    };
}
