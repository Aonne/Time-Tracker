# Time Tracker

Time Tracker is a regrouping of few scripts that will retrieve the log files of featured launchers, clean them a bit to let you see what game you played, when did you play it and how long.

As for now, it is very much an alpha and will require a lot of interpretation.
The data still needs some cleaning, manually and later, automatically, but should be usable for graphs.


## Requirements

Windows 10 or 11, doesnt work on Linux.
Also only people with a NVIDIA GPU will be able to **fully** use it, as the NVIDIA scripts can track most of the games by itself.


## How to use

1) Download
    - Without Autohotkey: Download the last version in [releases](https://github.com/Aonne/Time-Tracker/releases/).
    - With Autohotkey: Download the ZIP of the code
2) Extract in the location that you want. Time Tracker is fully portable.
3) Launcher Time Tracker, not setup. For the first installation its important that you're not launching setup.
4) Adding path to launchers:
    - Most of the paths should already be there, even if you don't actually have the launcher installed.
    - For those that are empty, you can click on the launcher's button to add the path to it. (for now only works with Steam and Ryujinx)
5) Optional:
    - Check "Launch at start up" to not miss any log, as some launchers will reset theirs at every Windows startup.
6) Read the logs:
    - Logs will be in the ```Temp``` folder. For now, almost every launchers has a different syntax, something that I'm trying to correct. ```Nvidia.txt``` should have 90% of the logs, it just doesnt registers the name of most old games. That's why you'll need to look at the game's launcher put the piece together.


# FAQ

* How does it work?
  * Every launchers use log files, for error checking. We can look into them and search for a few parameters: What game was launched, when was it launched, and when was it stopped. But those log can still be difficult to read, so Time Tracker will clean them until having only the time and the process/game. In practice it won't be that clean, that's where people will need to interprete.

* What launchers are featured?
  * As for now : Steam, Epic, Minecraft (WIP and can't log custom launchers), GOG (WIP) and Battlenet. Riot, Origin and Ryujinx are the next.

* What do you do with my data?
  * Absolutely nothing! Time Tracker doesn't share anything anywhere, in fact it can be use without an internet connection.

* Does it work on games without launcher?
  * Only ```Nvidia``` should log that. Note that for older games, it won't log the name but should still know when it was opened and closed. As for *very* light games hhhhhh it's a gamble, some may work, some may not. I am always trying to find new ways to improve this project.

* Support for AMD GPUs?
  * Not in the close future. Time Tracker will still work with any GPU, just not the NVIDIA script.

* Why Autohotkey?
  * I only know Autohotkey as I wrote a few scripts with it, nothing big. It's actually my first project that I can call that.
