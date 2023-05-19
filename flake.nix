{
  description = "React app for a youtube video";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ];
      perSystem = { config, self', input', pkgs, system, ... }: {
        packages = {
          nixified-react = pkgs.buildNpmPackage {
            name = "nixified-react";
            src = ./.;

            buildInputs = with pkgs; [ nodejs-18_x ];

            npmPackFlags = [ "--ignore-scripts" ];

            npmDepsHash = "sha256-4xsM4xPMwO+dOJL6VbHqyI5/+3kZW7WW/jhmX5bsz58=";

            npmBuild = ''
              npm run build
            '';

            installPhase = ''
              mkdir $out
              cp -r build/ $out
            '';
          };

          default = pkgs.writeShellScriptBin "serve-nixified-react" ''
            #!/usr/bin/env bash
            cd ${self'.packages.nixified-react}/build
            ${pkgs.httplz}/bin/httplz
          '';
        };



        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs-18_x
            pkgs.httplz
            pkgs.prefetch-npm-deps
          ];
        };
      };
    };
}
