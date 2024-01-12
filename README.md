# A simple starter for turning a React app into a native binary

Either:

- Fork this repo and begin with (included) vanilla CRA
- Paste in your own React app and overwrite all React files

Then enter a nix shell `nix develop` and generate your npm deps hash. Update `flake.nix` with the new hash and run `nix build` your binary will be in `result/bin` after the build finishes.

## Build Process

You will have to update the `npmDepsHash` if you change any dependencies in your `package.json` to accomplish this:
- Run `nix develop` which will pop you into a shell with the necessary CL tool to get the hash
- Run `prefetch-npm-deps`
- Copy that output into the flake.
