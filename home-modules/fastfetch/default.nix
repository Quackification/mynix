{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https=//github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      display = {
        key= {
            type= "icon";
            paddingLeft= 2;
        };
      };
      logo= {
        source= ./logo.png;
        type= "kitty";
        "padding"= {
            "top"= 1;
        };
        "height"= 10;
      };
      modules = [
            {
                    "type"= "custom";
                    "format"= "{#1}{#94}System Information{#94}{#1}";
            }
            {
                    "type"= "custom";
                    "format"= "──────────────────────────────";
            }
            {
                type = "os";
                format = "{3}";

            }
            "host"
            "kernel"
            "uptime"
            "packages"
            "shell"
            "de"
            "wm"
            "terminal"
            "break"
            {
                    "type"= "custom";
                    "format"= "{#1}{#94}Hardware Information{#94}{#1}";
            }
            {
                    "type"= "custom";
                    "format"= "──────────────────────────────";
            }
            {
                    "type"= "cpu";
                    "showPeCoreCount"= false;
                    "temp"= false;
                    format = "{}";
            }
            "memory"
            "disk"
            "battery"
            "poweradapter"
            "break"
            {

                    "type"="colors";
                    "symbol"="circle";
                    "paddingLeft"= 1;
            }
        ];
    };
  };
}
