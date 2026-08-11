# OpenSpec, built from the upstream flake's source.
#
# We deliberately do not use upstream's own `packages.<system>.default`: it
# builds against `nixpkgs.legacyPackages` from its own input, so neither our
# `follows` nor our nixpkgs.config applies. Upstream pins 26.11, which has
# dropped x86_64-darwin, and its pnpm_9 is flagged for CVEs in 26.05. Building
# it here against our nixpkgs lets us use a current, unflagged pnpm.
{ lib, stdenv, pnpm, pnpmConfigHook, fetchPnpmDeps, nodejs_22, npmHooks, src }:

stdenv.mkDerivation (finalAttrs: {
  pname = "openspec";
  version = (builtins.fromJSON (builtins.readFile "${src}/package.json")).version;

  inherit src;

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    inherit pnpm;
    fetcherVersion = 3;
    hash = "sha256-jysUFMFMe/Fpsj6J/oQi1w3qWm5fVO9hSK99GnHdCz0=";
  };

  nativeBuildInputs = [
    nodejs_22
    npmHooks.npmInstallHook
    pnpmConfigHook
    pnpm
  ];

  buildPhase = ''
    runHook preBuild

    pnpm run build

    runHook postBuild
  '';

  dontNpmPrune = true;

  meta = {
    description = "AI-native system for spec-driven development";
    homepage = "https://github.com/Fission-AI/OpenSpec";
    license = lib.licenses.mit;
    mainProgram = "openspec";
  };
})
