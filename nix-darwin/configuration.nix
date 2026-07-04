{ pkgs, lib, inputs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.comic-shanns-mono
  ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility.
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  environment.shells = [ pkgs.fish ];

  users.users.alekseypanchenko = {
    name = "alekseypanchenko";
    home = "/Users/alekseypanchenko";
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
  };
}
