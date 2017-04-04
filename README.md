```

:::::::.    :::.     .::::::.   ::   .:  :::::::.      ...   ::::::::::::
 ;;;'';;'   ;;`;;   ;;;`    `  ,;;   ;;,  ;;;'';;'  .;;;;;;;.;;;;;;;;''''
 [[[__[[\. ,[[ '[[, '[==/[[[[,,[[[,,,[[[  [[[__[[\.,[[     \[[,   [[
 $$""""Y$$c$$$cc$$$c  '''    $"$$$"""$$$  $$""""Y$$$$$,     $$$   $$
_88o,,od8P 888   888,88b    dP 888   "88o_88o,,od8P"888,_ _,88P   88,
""YUMMMP"  YMM   ""`  "YMmMY"  MMM    YMM""YUMMMP"   "YMMMMMP"    MMM

```

irc-bashbot
====

An irc bot written in bash with dynamic libraries

Usage
----
Base usage:
```
git clone git@github.com:cbodden/irc-bashbot.git
cd irc-bashbot
mv config/sample-irc_bashbot.config config/irc_bashbot.config
vi config/irc_bashbot.config
./irc-bashbot.sh
```

Base usage explained:
the (sample-)irc_bashbot.config file controls the nick, server, port,
chan, chan key if used, owner nick, owner password, and nickserv password
if used.

Once connected, the bot will join the specified nick where you can then
type ".help" to see what commands are available on the bot.


Requirements
----

- Bash (https://www.gnu.org/software/bash/)
- For AWS lib: AWS cli tools (https://aws.amazon.com/cli/)
- For Facts lib: Elinks (http://elinks.or.cz/)

License and Author
----

Author:: Cesar Bodden (cesar@pissedoffadmins.com)

Copyright:: 2016, Pissedoffadmins.com

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
