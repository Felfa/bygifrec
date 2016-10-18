# bygifrec
A simple and free (as in freedom) script shell utility for GNU/Linux desktops to make GIF screencasts easily with byzanz-record.

## Requirements
Some dependencies are required to run properly this script:
* __byzanz, byzanz-record:__ screencast software needed for record the desktop and save it to an animated GIF file.
* __xdotool:__ command line tool used for getting X11 coordinates of the recording frame.
* __bash (or compatible shell)__.

## Usage
1. [Download _bygifrec.sh_](https://raw.githubusercontent.com/Felfa/bygifrec/master/bygifrec.sh) script or clone the entire repository: `git clone https://github.com/Felfa/bygifrec.git && cd bygifrec`.
2. Make the script runnable: `chmod a+x bygifrec.sh`
3. Run it from shell: `./bygifrec.sh` or by entering full path if you are running it from other location (it will save the gif on the current directory).

## TODO
* Translate into other languages (catalan, english...)
* Prompt for full save path or autosave with other name.
