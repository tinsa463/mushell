{
  description = "quickshell config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    quickshell,
  }: let
    lib = nixpkgs.lib;
    src = ./.;
    perSystem = package: (lib.listToAttrs (lib.map (a: {
      name = a;
      value = package {
        pkgs = nixpkgs.legacyPackages.${a};
        system = a;
      };
    }) (lib.attrNames nixpkgs.legacyPackages)));
  in {
    packages = perSystem ({
      pkgs,
      system,
    }: rec {
      shell = pkgs.writeShellScriptBin "shell" ''
        ${quickshell.packages.${system}.default}/bin/quickshell
      '';
      default = shell;

      systemd.user.services.shell = {
        Unit = {
          Description = "Shell widget using quickshell";
          After = ["hyprland-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${default}/bin/shell -p ${src}";
          Restart = "on-failure";
          Slice = "app-graphical.slice";
        };
        Install = {
          WantedBy = ["hyprland-session.target"];
        };
      };

      prePatch = ''
        substituteInPlace shell.qml \
        	--replace-fail 'ShellRoot {' 'ShellRoot {  settings.watchFiles: false'
      '';
    });
    devShells = perSystem ({
      pkgs,
      system,
    }: {
      default = pkgs.mkShell {
        packages = [
          self.packages.${system}.default
        ];
      };
    });
  };
}
