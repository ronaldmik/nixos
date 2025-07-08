{ config, ... }:
{
  # In order to create a correct ~/.ssh/allowed_signers, run:
  # echo "$(git config --get user.email) namespaces=\"git\" $(cat ~/.ssh/id_ed25519.pub)" >> ~/.ssh/allowed_signers
  programs.git = {
    enable = true;
    userName = "Ronald Mik";
    userEmail = "16256741+ronaldmik@users.noreply.github.com";
    
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    extraConfig = {
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
  };
}
