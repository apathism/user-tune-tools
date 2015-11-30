# Copyright 2005 Joe Wreschnig
# Copyright 2009-2010 Koryabkin Ivan
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation

import os
import util

from plugins.events import EventPlugin

outfile = os.path.expanduser("~/.psi/tune")
format = "%s\n%s\n%s\n%d\n%d"
    
class PsiTune(EventPlugin):
    PLUGIN_ID = "PsiTune"
    PLUGIN_NAME = "Psi Tune"
    PLUGIN_DESC = "Sends information about current song to Psi/Psi+"
    PLUGIN_ICON = 'gtk-save'
    PLUGIN_VERSION = "0.2"

    def plugin_on_song_started(self, song):
        if song is None:
            try:
                os.remove(outfile)
            except EnvironmentError: pass
#            else: f.close()
        else:
            try:
                f = file(outfile, "wb")
                f.write(format % (
                    util.escape(song.comma("title")),
                    util.escape(song.comma("artist")),
                    util.escape(song.comma("album")),
                    song("~#track", 0), song("~#length")))
            except EnvironmentError: pass
            else: f.close()
