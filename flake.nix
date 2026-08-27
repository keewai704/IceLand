{
  description = "IceLand Quickshell development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
          qs = pkgs.quickshell;
          qt = pkgs.kdePackages;
        in
        {
          default = pkgs.mkShellNoCC {
            packages = [
              qs

              pkgs.just
              pkgs.git
              pkgs.jq
              pkgs.ripgrep
              pkgs.fd

              qt.qtdeclarative
              qt.qttools

              pkgs.shellcheck
              pkgs.shfmt
              pkgs.nixfmt-rfc-style

              pkgs.vulkan-tools
              pkgs.vulkan-validation-layers
              pkgs.wayland-utils

              pkgs.dbus
              pkgs.libnotify
              pkgs.playerctl
              pkgs.brightnessctl
            ];

            shellHook = ''
              export ICELAND_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
              export ICELAND_QS_QML_PATH="${qs}/lib/qt-6/qml"
              export QSG_RHI_BACKEND="''${QSG_RHI_BACKEND:-vulkan}"
              export QT_QPA_PLATFORM="''${QT_QPA_PLATFORM:-wayland}"
              export QMLLS_BUILD_DIRS="$ICELAND_ROOT"
              export QMLLS_NO_CMAKE_CALLS=1

              if [ -d "$ICELAND_QS_QML_PATH" ]; then
                export QML_IMPORT_PATH="$ICELAND_QS_QML_PATH''${QML_IMPORT_PATH:+:$QML_IMPORT_PATH}"
                export QML2_IMPORT_PATH="$QML_IMPORT_PATH"
              fi

              if [ ! -e "$ICELAND_ROOT/.qmlls.ini" ]; then
                touch "$ICELAND_ROOT/.qmlls.ini"
              fi

              printf 'IceLand devshell: Quickshell %s, RHI=%s\n' "$(qs --version 2>/dev/null || printf unknown)" "$QSG_RHI_BACKEND"
              printf 'Run `just dev` to launch and `just check` before committing.\n'
            '';
          };
        }
      );

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);
    };
}
