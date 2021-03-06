Config {
       font = "xos4 Terminus:pixelsize=17:antialias=true"
       , additionalFonts = [ "xft:FontAwesome:size=11" ]
       , allDesktops = True
       , bgColor = "#282c34"
       , fgColor = "#bbc2cf"
       , position = TopW L 100
       , commands = [ Run Cpu [ "--template", "CPU: <total>%"
                              , "--Low","3"
                              , "--High","50"
                              , "--low","#bbc2cf"
                              , "--normal","#bbc2cf"
                              , "--high","#fb4934"] 50

                    , Run Memory ["-t","MEM: <usedratio>%"
                                 ,"-H","80"
                                 ,"-L","10"
                                 ,"-l","#bbc2cf"
                                 ,"-n","#bbc2cf"
                                 ,"-h","#fb4934"] 50
                    , Run PipeReader "/tmp/.volume-pipe" "vol_pipe"
                    , Run PipeReader "/tmp/.bright-pipe" "bright_pipe"
                    , Run Date "%a %b %_d %H:%M:%S" "date" 10 
                    , Run DynNetwork ["-t","Down: <rx>, Up: <tx>"
                                     ,"-H","200"
                                     ,"-L","10"
                                     ,"-h","#bbc2cf"
                                     ,"-l","#bbc2cf"
                                     ,"-n","#bbc2cf"] 50
                    , Run CoreTemp ["-t", "Temp: <core0>°"
                                   , "-L", "30"
                                   , "-H", "75"
                                   , "-l", "lightblue"
                                   , "-n", "#bbc2cf"
                                   , "-h", "#aa4450"] 50
                    , Run Volume "default" "Master"
                                            [ "-t", "<status>", "--"
                                            , "--on", "<fc=#859900><fn=1>\xf028</fn> <volume>%</fc>"
                                            , "--onc", "#859900"
                                            , "--off", "<fc=#dc322f><fn=1>\xf026</fn> MUTE</fc>"
                                            , "--offc", "#dc322f"
                                            ] 10
                    
                    , Run BatteryP       [ "BAT0" ]
                                         [ "--template" , "BAT: <acstatus>"
                                         , "--Low"      , "10"        -- units: %
                                         , "--High"     , "80"        -- units: %
                                         , "--low"      , "#fb4934" -- #ff5555
                                         , "--normal"   , "#bbc2cf"
                                         , "--high"     , "#98be65"
                                         , "--" -- battery specific options
                                                   -- discharging status
                                                   , "-o"   , "<left>% (<timeleft>)"
                                                   , "-a"   , "notify-send -u critical Battery Depleted"
                                                   -- AC "on" status
                                                   , "-O"   , "<left>% (<fc=#98be65>Charging</fc>)" -- 50fa7b
                                                   -- charged status
                                                   , "-i"   , "<fc=#98be65>Charged</fc>"
                                         ] 50
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% } %date% { %cpu% | %coretemp% | %memory% | %vol_pipe% |  %bright_pipe% |  %battery% | %dynnetwork% |"   -- #69DFFA
       }
