SoundCloud Recorder
===================

Description
-----------

SoundCloud Recorder is a Flash application that allows the user to record a
sound using their microphone. They may then listen to the sound, re-record
another sound, or upload the sound to SoundCloud.

The user may specify the sound name, whether it will be public or private,
and any desired tags before uploading.

One the sound is uploaded, the user is offered a link to the uploaded sound's
SoundCloud page, or they may go back and record another sound.

The user must first grant the application access to their SoundCloud account.

It is available to use online: http://www.stuartkeith.com/soundcloud-recorder/

If the user is on a mobile device, they are presented with a webpage containing
a link to the relevant official SoundCloud app for their device. If the user is
not on a mobile device and they do not have Flash installed, they are given
a link to download Flash.

Recorded sounds are stored and played back using linked lists, for performance
reasons. See http://wonderfl.net/c/zKzb/


Issues
------

- Flash does not send progress events when uploading files, except when using
  FileReference - which only works with files selected by the user from their
  hard drive. So upload progress cannot be shown.


Libraries
---------

SoundCloud Recorder uses the following third-party libraries:

- MinimalComps (https://github.com/minimalcomps/minimalcomps)
- MultipartURLLoader (https://github.com/markpasc/MultipartURLLoader)
- Robotlegs (https://github.com/robotlegs/robotlegs-framework)
- swfobject (https://github.com/swfobject/swfobject)


Assets
------

- Loading spinner animation: http://labs.wondergroup.com/programs/flash/loading-spinner-animations-for-flash/
- Microphone icon: http://chrfb.deviantart.com/art/quot-ecqlipse-2-quot-PNG-59941546


Possible Improvements
---------------------

- Check source comments.
- Listen for IO Errors and Security Errors in the SoundCloudService.
- Handle invalid query strings (will throw an error at present).
- Add event metadata.
- Take appropriate action if a microphone is absent/not supported.
- Have a separate parser class that parses the XML, so JSON parsing could
  easily be added later.
- Improve appearance of alternative content for non-Flash users.
