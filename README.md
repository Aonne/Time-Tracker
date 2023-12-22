# Time Tracker

Time Tracker is a regrouping of few scripts that will retrieve the log files of featured launchers, clean them a bit to let you see what game you played and when did you play it.

**It does not log anything itself.**

As for now, it is very much an alpha and will require a lot of interpretation.
The data still needs some cleaning, manually and later, automatically, but should be usable for graphs.


## Requirements

Windows 10 or 11, doesnt work on Linux or Mac.


## How to use

1) Download
    - Without Autohotkey: Download the last version in [releases](https://github.com/Aonne/Time-Tracker/releases/).
    - With Autohotkey: Download the ZIP of the code
2) Extract in the location that you want. Time Tracker is **entirely portable**.
3) Launcher *Time Tracker*.
4) Adding path to launchers:
    - Some of the paths will already be there, even if you don't actually have the launcher installed.
    - For those that says "NOT FOUND", you can click on the launcher's button on the left to add the path to it. (For now no option to change it except changing user_options.ini manually)
5) Optional:
    - Check "Launch at start up" to not miss any log, as some launchers will reset theirs at every Windows startup. This will create a simple shortcut of *Time Tracker* in ```AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup```.
6) Read the logs:
    - Logs will be in the ```Temp``` folder.


# FAQ

* How does it work?
  * Every launchers use log files for error checking. We can look into them and search for a few parameters: What game was launched, when was it launched, and when was it stopped. But those log can still be difficult to read, so Time Tracker will clean them until having only the time and the process/game. In practice it won't be that clean, that's where people will need to interprete.

* What launchers are featured?
  * As for now : Steam, Epic, GOG, Minecraft, Battlenet, EA Desktop, MultiMC, Prism, Playnite and Riot (and Nvidia, using Nvidia Share so activate the in game overlay). If you want more, please open an [issue](https://github.com/Aonne/Time-Tracker/issues/new) with the tag ```launcher request```.

* It doesnt work!
  * Check if the paths lead to something, every one of them should lead to a folder with at least one *.log* file in it (except Riot that is different). If paths are not right, you can manually change the paths in ````user_options.ini````.

* What do you do with my data?
  * Absolutely nothing! Time Tracker doesn't share anything anywhere, in fact it can entirely be used without an internet connection.

* Does it work on games without launcher?
  * ```Nvidia``` is the only one that will log mostly everything as long as *Nvidia Share* is working. Older games will be a hit or miss. ```Playnite``` is a really good launcher for that, as it will clearly logs everything that launches through it.

* Support for AMD GPUs?
  * Not in the close future. Time Tracker will still work with any GPU, just not the NVIDIA script.

* Why Autohotkey?
  * I only know Autohotkey as I wrote a few scripts with it, nothing big. It's actually my first project that I can call that.


# In Depth

In case you still have issues or are curious about things.

* Battlenet
  *     Will search for any .log files in Local\Battle.net\Logs
* EADesktop
  *     Will search for EADesktop.log in Local\Electronic Arts\EA Desktop\Logs
