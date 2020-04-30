# FlipFlopScript
## A PowerShell that automatically changes the mouse scrolling direction

On windows you cannot simply change the mouse scrolling direction in the settings.
The only method you have is to dig into Registry Editor and change the right parameter for the right device.
You have to do this for all your mice and for all the USB ports.

With the FlipFlopScript (in reference to the "FlipFlopWheel" parameter you have to change in Regedit) you can do it easily without having to open Registry Editor.


## How to use
- Download the script
- Open PowerShell **As Administrator**
- Execute the line below (make sure the script is in Downloads):
```
& "$home\Downloads\FlipFlopScript.ps1"
```
- Follow the instructions
- Delete the script if you want

## How it works
The script is pretty simple:
1. You choose the scroll direction
2. By unplugging and replugging the mouse it detects its ID
3. You have to make it for all the USB ports to be able to change the parameters for each one afterwards
4. The script change the Registry Editor parameter (FlipFlopWheel) for all the USB port for your mouse
5. Unplug and replug the mouse to see new changes

## Footnotes
- You have to execute this script for each mouse you want to change
- You can restore the scrolling direction to default with the script
