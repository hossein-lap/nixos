{ pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  # imports = [
  #     ./vim.nix
  # ];

  users.users.hos = {
    isNormalUser = true;
    description = "hos";
    extraGroups = [ "networkmanager" "wheel" "kvm" "docker" ];
    # packages = with pkgs; [
    #   # thunderbird
    # ];

  };

}
