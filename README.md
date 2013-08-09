screenshot
==========

Linux and OS X script that uploads your mouse selection to your server for easy image hosting.


###Binding keys on Linux:

Using **xbindkeys**, edit ~/.xbindkeysrc:

```shell
"sleep 0.3 && /path/to/screenshot.sh"
   alt + shift + 4
```
*The sleep is required because xbindkeys doesn't return the keyboard right away, causing scrot to error out.*
