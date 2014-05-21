;-----------------------------------------------------------------------------------
;Colorlock
;Version 2.0 (3-24-09)
By Andrew Pinion
;Visit http://megalith.us/ for updates and online documentation.
;-----------------------------------------------------------------------------------


;--------------------------------------------------------------
;Initialization commands and Default Settings
;--------------------------------------------------------------
on 1:LOAD: {
  /colorlock.default
}

alias colorlock.default {

  /.remote on
  /set %CLver Colorlock 2.0 (3-26-09)

  /.enable #color
  /.disable #colorkeys
  /.disable #classicmenu
  /.enable #newmenu
  /.disable #colordesk

  /set %colornum 12

  //echo $active 0*
  //echo $active 3***Colorlock successfully Installed!
  //echo $active 3*To change options, use the right-click menu in the channel or PM window.

}

#CLinstalled on
#CLinstalled end

;--------------------------------------------
;Uninstalling Colorlock
;--------------------------------------------

alias colorlock.uninstall {

  /unset %colornum
  /unset %CLver
  /unload -rs colorlock.mrc
  halt
}

on 1:UNLOAD: {
  /colorlock.uninstall
}



;--------------------------------------------
;Version Information
;--------------------------------------------

#colorver off
ctcp 1:MEGALITH:*:{ 
  //ctcpreply $nick VERSION %CLver
}

ctcp 1:CLDIAG:*:{ 


  //ctcpreply $nick VERSION %CLver
  //ctcpreply $nick Colorsetting: %colornum

}
#colorver end

alias colorlock.about {
  //echo $active 3Colorlock
  //echo $active 3By Andrew Pinion
  //echo $active 3Version: %CLver 
  //echo $active 3Visit http://megalith.us/ for more scripts.
}

;----------------------------------------------------
;Popup Menus
;----------------------------------------------------

#classicmenu off

menu channel {
  Colorlock
  . $+ $iif( $group(#color) == on, Disable Colorlock , Enable Colorlock ) : $iif( $group(#Color) == on, /.disable #Color Colorlock , /.enable #color colorlock )
  .-
  . Set Color...: /set %colornum $$?="Enter your custom color codes here:" | echo $active $+($chr(3),,%colornum ,-Color Changed-)
  .  Randomize Color: /colorlock.random
  . Use Menu Mode: /.disable #classicmenu | /.enable #newmenu | /menucheck 
}

menu query {
  Colorlock
  . $+ $iif( $group(#color) == on, Disable Colorlock , Enable Colorlock ) : $iif( $group(#Color) == on, /.disable #Color Colorlock , /.enable #color colorlock )
  .-
  . Set Color...: /set %colornum $$?="Enter your custom color codes here:" | echo $active $+($chr(3),,%colornum ,-Color Changed-)
  .  Randomize Color: /colorlock.random
  . Use Menu Mode: /.disable #classicmenu | /.enable #newmenu | /menucheck 
}

#classicmenu end

alias menucheck {
  if ($group(#colordesk) == on) {
    /dialog -mdk Colorlock Colorlock
  }
  else {
    /dialog -mk Colorlock Colorlock
  }
}



#newmenu on

menu channel {
  . $+ $iif( $group(#color) == on, Colorlock , Colorlock ) : $iif( $group(#colordesk) == on, /dialog -mdk Colorlock Colorlock , /dialog -mk Colorlock Colorlock )
}

menu query {
  . $+ $iif( $group(#color) == on, Colorlock , Colorlock ) : $iif( $group(#colordesk) == on, /dialog -mdk Colorlock Colorlock , /dialog -mk Colorlock Colorlock )
}

#newmenu end

#colordesk off
;Dummy Group used as a flag
#colordesk end

;----------------------------------------------------
;Menu Interface
;----------------------------------------------------

dialog Colorlock {
  title "Colorlock"
  size -1 -1 136 67
  option dbu
  tab "Colors", 1, 0 -2 136 67
  box "Main Options", 4, 3 14 131 48, tab 1
  button "Random", 5, 90 28 37 12, tab 1
  button "Test Color", 6, 90 42 37 12, tab 1
  edit "", 7, 44 43 42 10, tab 1
  text "Color Code:", 8, 11 44 32 8, tab 1
  check "Enable Colorlock", 9, 9 27 50 10, tab 1
  tab "Settings", 2
  check "Use F11 Hotkeys", 10, 6 25 58 10, tab 2
  check "Open Menu on Desktop", 11, 6 37 77 10, tab 2
  button "Switch to Classic Menu", 15, 5 49 71 12, tab 2
  box "Preferences", 16, 3 15 129 50, tab 2
  tab "About", 3
  button "Uninstall", 12, 95 51 37 12, tab 3
  icon 13, 5 14 125 33, addons/images/cl.jpg, 0, tab 3
  button "Help", 14, 6 51 32 12, tab 3
  button "Check for Updates", 17, 42 51 50 12, tab 3
}


;----------------------------------------------------
;Menu Interface Processing - Initialization
;----------------------------------------------------

On *:DIALOG:Colorlock:init:0:{
  did -a Colorlock 7 %Colornum
  if ($group(#color) == on) {
    did -c Colorlock 9
  }
  else {
    did -b colorlock 7
    did -b colorlock 5
    did -b colorlock 6
  }
  if ($group(#colorkeys) == on) {
    did -c Colorlock 10
  }
  if ($group(#colordesk) == on) {
    did -c Colorlock 11
  }
}

;----------------------------------------------------
;Menu Interface Processing - Tab 1
;----------------------------------------------------


;Test Color Button

on *:DIALOG:Colorlock:sclick:6:{
  echo $active $+($chr(3),,%colornum , Testing 1 2 3...)
}

;Random Color Button

on *:DIALOG:colorlock:sclick:5:{
  /set %colornum $rand(1,15)
  /did -r Colorlock 7
  /did -a Colorlock 7 %colornum
}

;Color Edit box

On *:DIALOG:Colorlock:edit:7:{
  //set %colornum $did(7)
}

;Enable Colorlock Check Box

on *:DIALOG:Colorlock:sclick:9:{
  if ($group(#color) == off) {
    did -c Colorlock 9
    /.enable #color
    did -e colorlock 7
    did -e colorlock 5
    did -e colorlock 6
  }
  else {
    did -u Colorlock 9
    /.disable #color
    did -b colorlock 7
    did -b colorlock 5
    did -b colorlock 6
  }
}

;----------------------------------------------------
;Menu Interface Processing - Tab 2
;----------------------------------------------------

;Use F11 Hokeys Checkbox

on *:DIALOG:Colorlock:sclick:10:{
  if ($group(#colorkeys) == off) {
    did -c Colorlock 10
    /.enable #colorkeys
  }
  else {
    did -u Colorlock 10
    /.disable #colorkeys
  }
}

;Open on Desktop Checkbox

on *:DIALOG:Colorlock:sclick:11:{
  if ($group(#colordesk) == off) {
    did -c Colorlock 11
    /.enable #colordesk
  }
  else {
    did -u Colorlock 11
    /.disable #colordesk
  }
}

;Switch to Classic Mode Button

on *:DIALOG:Colorlock:sclick:15:{
  /.enable #classicmenu
  /.disable #newmenu
  /.dialog -x Colorlock
}

;----------------------------------------------------
;Menu Interface Processing - Tab 3
;----------------------------------------------------
;View Help File
on *:DIALOG:Colorlock:sclick:14:{
  /run notepad.exe addons/colorhelp.txt
}
;Uninstall

on *:DIALOG:Colorlock:sclick:12:{
  /dialog -mk Colorundo Colorundo
  /beep 1
}

dialog Colorundo {
  title "Colorlock Uninstaller"
  size -1 -1 124 33
  option dbu
  button "Uninstall", 1, 71 16 37 12
  button "Cancel", 2, 23 16 37 12
  text "Do you really wish to uninstall this addon? ", 3, 5 4 111 8, center
}

on *:DIALOG:Colorundo:sclick:1:{
  /dialog -x Colorlock
  /dialog -x Colorundo
  /colorlock.uninstall
}

on *:DIALOG:Colorundo:sclick:2:{
  /dialog -x Colorundo
}

;Check for Updates
on *:DIALOG:Colorlock:sclick:17:{
  /run iexplore.exe http://main.megalith.us/index.php/Colorlock
}


;----------------------------------------------------
;Color Locker Processing
;----------------------------------------------------

#color on

on 1:INPUT:*:{
  if (/* !iswm $1) && (!* !iswm $1) && (@* !iswm $1) { msg $active $+($chr(3),,%colornum ,$1-) | halt } 
}

alias colorlock.random {
  /set %colornum $rand(0,15)
  /beep 2
}

#color end

;----------------------------------------------------
;F-Key Integration
;----------------------------------------------------

#colorkeys off

alias f11 { $+ $iif( $group(#Color) == on, /.disable #Color Colorlock , /.enable #color colorlock ) }
alias cf11 { /colorlock.random }

#colorkeys end

;----------------------------------------------------
;CLR processing
;----------------------------------------------------
;the master command to change settings.

#clr on
alias clr {
  if ($$1 == off) { /.disable #color | halt }
  if ($$1 == on) { /.enable #color | halt }
  if ($$1 == uninstall) { /beep 1 | /dialog -mk colorundo colorundo | halt }
  if ($$1 == reset) { /echo $active ***Colorlock reset to default settings. | /colorlock.default | halt }
  if ($$1 == random) { /colorlock.random | halt }
  if ($$1 == diag) { /.enable #colorver | //echo $active 3**Diagnostic mode enabled. | halt }  
  if ($$1 == help) { /run notepad.exe colorlock/colorhelp.txt | halt }  
  if ($$1 == guion) { /.enable #newmenu | /.disable #classicmenu | halt }
  if ($$1 == guioff) { /.disable #newmenu | /.enable #classicmenu | halt }
  if ($$1 == nomenu) { /.disable #newmenu | /.disable #classicmenu | halt }

  if ($$1 == white) { /set %colornum 0 | halt }
  if ($$1 == black) { /set %colornum 1 | halt }
  if ($$1 == blue) { /set %colornum 2 | halt }
  if ($$1 == green) { /set %colornum 3 | halt }
  if ($$1 == red) { /set %colornum 4 | halt }
  if ($$1 == brown) { /set %colornum 5 | halt }
  if ($$1 == purple) { /set %colornum 6 | halt }
  if ($$1 == orange) { /set %colornum 7 | halt }
  if ($$1 == yellow) { /set %colornum 8 | halt }
  if ($$1 == lightgreen) { /set %colornum 9 | halt }
  if ($$1 == cyan) { /set %colornum 10 | halt }
  if ($$1 == lightcyan) { /set %colornum 11 | halt }
  if ($$1 == lightblue) { /set %colornum 12 | halt }
  if ($$1 == pink) { /set %colornum 13 | halt }
  if ($$1 == grey) { /set %colornum 14 | halt }
  if ($$1 == lightgrey) { /set %colornum 15 | halt }

  else {
  /set %colornum $$1- | halt }
}
#clr off
