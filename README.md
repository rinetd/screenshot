screenshot
==========

Linux and OS X script that uploads your mouse selection to your server for easy image hosting.
###Configuration:

Edit the following fields in screenshot.sh:
*HOST 
*USER
*UPLOAD_PATH
*BASE_URL

*note: script assumes that you're authorized to access the host without using a password.*

###Requirements:

####Linux:
* xsel   (clipboard)
* rsync  (transfer, can be replaced with scp)
* espeak (audio notification of completion)
* scrot  (screenshot utility)

####OS X:
* None

###Binding keys on Linux:

Using **xbindkeys**, edit ~/.xbindkeysrc:

```shell
"sleep 0.3 && /path/to/screenshot.sh"
   alt + shift + 4
```
*The sleep is required because xbindkeys doesn't return the keyboard right away, causing scrot to error out.*
