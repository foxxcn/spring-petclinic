{
  description = "A development environment for the Spring PetClinic application";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "spring-petclinic-shell";

          buildInputs = with pkgs; [
            maven
            gradle
            docker
            docker-compose
            jdk21_headless
          ];

          # shellHook = ''
          #  export MAVEN_OPTS="-Xmx2g"
          #  echo "Welcome to the Spring PetClinic dev shell!"
          # '';
        };
      }
    );
}
