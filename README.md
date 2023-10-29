# Time Tracker

Time Tracker is a regrouping of few scripts that will retrieve the log files of featured launchers, clean them a bit to let you see what game you played and when did you play it.

As for now, it is very much an alpha and will require a lot of interpretation.
The data still needs some cleaning, manually and later, automatically, but should be usable for graphs.


## Requirements

Windows 10 or 11, doesnt work on Linux.
Also only people with a NVIDIA GPU will be able to **fully** use it, as the NVIDIA scripts can track most of the games by itself.


## How to use

1) Download
    - Without Autohotkey: Download the last version in [releases](https://github.com/Aonne/Time-Tracker/releases/). (WIP, no executable version for now)
    - With Autohotkey: Download the ZIP of the code
2) Extract in the location that you want. Time Tracker is **entirely portable**.
3) Launcher *Time Tracker*.
4) Adding path to launchers:
    - Some of the paths will already be there, even if you don't actually have the launcher installed.
    - For those that says "NOT FOUND", you can click on the launcher's button on the left to add the path to it. (For now no option to change it except changing user_options.ini manually)
5) Optional:
    - Check "Launch at start up" to not miss any log, as some launchers will reset theirs at every Windows startup. This will create a simple shortcut of *Time Tracker* in ```C:\Users\%A_UserName%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup```.
6) Read the logs:
    - Logs will be in the ```Temp``` folder. For now, almost every launchers has a different syntax, something that I'm trying to correct. ```Nvidia.txt``` should have 90% of the logs, it just doesnt registers the name of most old games. That's why you'll need to look at the game's launcher put the piece together.
7) Optional step - Fixes:
    - Fixes are a work in progress to further clean the log files. This is done after to not add computing time to *Time Tracker*. It consists of three parts:
        - Part 1 : Change every dates to a single format.
        - Part 2 : Flag missing lines. Due to launchers or *Time Tracker*, some entries of gaming sessions won't be logged. This step should help you notice those missing entries and manually correct them, using other logs.
        - Part 3 : When you are sure the *Part  2* is perfect and no entries are missing, this regroup every log files into one.


# FAQ

* How does it work?
  * Every launchers use log files for error checking. We can look into them and search for a few parameters: What game was launched, when was it launched, and when was it stopped. But those log can still be difficult to read, so Time Tracker will clean them until having only the time and the process/game. In practice it won't be that clean, that's where people will need to interprete.

* What launchers are featured?
  * As for now : Steam, Epic, GOG, Minecraft, Battlenet, EA Desktop, MultiMC, Prism, Playnite and Riot (and Nvidia). If you want more, please open an [issue](https://github.com/Aonne/Time-Tracker/issues/new) with the tag ```launcher request```.

* It doesnt work!
  * Check if the paths lead to something, every one of them should lead to a folder with at least one *.log* file in it (except Riot that is different). If paths are not right, use the Reset button, and if it is still not right, you can manually change the path in ````user_options.ini````.

* What do you do with my data?
  * Absolutely nothing! Time Tracker doesn't share anything anywhere, in fact it can entirely be used without an internet connection.

* Does it work on games without launcher?
  * ```Nvidia``` is the only one that will log mostly everything. Older games will be a hit or miss, it's really best to used it for the part 2 of *Fixes*. ```Playnite``` is a really good launcher for that, as it will clearly logs everything that launches through it.

* Support for AMD GPUs?
  * Not in the close future. Time Tracker will still work with any GPU, just not the NVIDIA script.

* Why Autohotkey?
  * I only know Autohotkey as I wrote a few scripts with it, nothing big. It's actually my first project that I can call that.
