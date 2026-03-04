{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    ocnix.url = "github:your-org/ocnix";
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
        modules = [{
          opencode.model = "anthropic/claude-sonnet-4-5";
          opencode.agents.reviewer = {
            model = "anthropic/claude-opus-4-5";
            instructions = ''
              You are a code reviewer. Focus on correctness, security, and maintainability.
            '';
          };
          opencode.mcp.servers.github = {
            command = "''${pkgs.mcp-github}/bin/mcp-github";
          };
        }];
      };
    };
}
