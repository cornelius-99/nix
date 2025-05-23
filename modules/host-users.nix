{
  username,
  hostname,
  ...
} @ args:
#############################################################
#
#  Host & Users configuration
#
#############################################################
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  users.users."privat" = {
    createHome = true;
    description = "non-priviledged account";
    home = "/Users/privat";
    name = "privat";
    uid = 502;
  };
  users.knownUsers = ["privat"];

  nix.settings.trusted-users = [username "privat"];
}
