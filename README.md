# A simple starter for turning a React app into a native binary

Either:

- Fork this repo and begin with a vanilla CRA
- Paste in your own React app and overwrite all React files

Then enter a nix shell `nix develop` and generate your npm deps hash. Update `flake.nix` with the new hash and run `nix build` your binary will be in `result/bin` after the build finishes.
