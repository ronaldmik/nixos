{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    libation
  ];

#  libationSettings = pkgs.writeTextFile "immutable_settings.json" ''
#      {
#        "Books":"/mnt/share/books",
#        "FolderTemplate": "<author>/<if series-><series>/[<series#>] <-if series><title short>",
#        "FileTemplate": "<title>",
#        "ReplacementCharacters": {
#          "Replacement": [
#            {
#              "CharacterToReplace": "\u0000",
#              "ReplacementString": "_",
#              "Description": "All other invalid characters"
#            },
#            {
#              "CharacterToReplace": "/",
#              "ReplacementString": "∕",
#              "Description": "Forward Slash (Filename Only)"
#            },
#            {
#              "CharacterToReplace": "\\",
#              "ReplacementString": "\\",
#              "Description": "Back Slash (Filename Only)"
#            },
#            {
#              "CharacterToReplace": "\"",
#              "ReplacementString": "“",
#              "Description": "Open Quote"
#            },
#            {
#              "CharacterToReplace": "\"",
#              "ReplacementString": "”",
#              "Description": "Close Quote"
#            },
#            {
#              "CharacterToReplace": "\"",
#              "ReplacementString": "\"",
#              "Description": "Other Quote"
#            },
#            {
#              "CharacterToReplace": ":",
#              "ReplacementString": " -",
#              "Description": "colon to space-dash for Android"
#            }
#          ]
#        }
#      }
#    '';
    
#  installPhase = ''
#    mkdir -p ${config.home.homeDirectory}.local/share/Libation
#    cp $libationSettings ${config.home.homeDirectory}.local/share/Libation/Settings.json
#  '';
}
