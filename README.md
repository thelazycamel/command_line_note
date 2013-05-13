command_line_note
=================

Add and search notes to Notational Velocity via the command line

Ruby command line app to add and search notes from the command line.  I have integrated this with Notational Velocity (http://notational.net/) and dropbox, so that you can share the notes to all your computers and view them via Notational Velocity.

Usage
=====

Searching
>note ruby

Adding A Note
>note ruby -a "Ruby is an awesome tool for making command line apps"

Deleting a notea

>note ruby -d

Setting Up Notational Velocity
==============================

Download from: (http://notational.net/)

To sync note with Notational Velocity, simply add a folder "notational_data" to dropbox and point Notational Velocity to use that folder:

Notational Velocity > Preferences > "Read notes from folder"

You also need change the setting "Store and read notes on disk" as "Plain Text Files *"