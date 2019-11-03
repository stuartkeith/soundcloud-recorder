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

If the user is on a mobile device, they are presented with a webpage containing
a link to the relevant official SoundCloud app for their device. If the user is
not on a mobile device and they do not have Flash installed, they are given
a link to download Flash.

Recorded sounds are stored and played back using linked lists, for performance
reasons. See http://wonderfl.net/c/zKzb/

Configuration (maximum recording time, SoundClient client ID, required URLs) is
specified in index.html, so the Flash content does not need to be rebuilt if
configuration needs to be changed.


Libraries
---------

SoundCloud Recorder uses the following third-party libraries:

- MinimalComps (https://github.com/minimalcomps/minimalcomps)
  A lightweight set of components. Chosen for small file size and low memory
  footprint. Downside is minimal layout support and customisation of
  appearance.
  
- MultipartURLLoader (https://github.com/markpasc/MultipartURLLoader)
  Used to easily create a multipart/form-data POST request with variables and
  files.
  
- Robotlegs (https://github.com/robotlegs/robotlegs-framework)
  Used to help separate the project into models, views, mediators, and
  commands. Reduces boilerplate code. Encourages loose coupling, making it 
  easier to refactor and add components.

- swfobject (https://github.com/swfobject/swfobject)
  Used to insert the SWF into the HTML page, or provide alternative content if
  that cannot be done.


Issues
------

- Flash does not send progress events when uploading files, except when using
  FileReference - which only works with files selected by the user from their
  hard drive. So upload progress (bytes uploaded/bytes total) cannot be shown.


Assets
------

- Loading spinner animation:
  http://labs.wondergroup.com/programs/flash/loading-spinner-animations-for-flash/

- Microphone icon:
  http://chrfb.deviantart.com/art/quot-ecqlipse-2-quot-PNG-59941546


Possible Improvements/Outstanding Issues
----------------------------------------

- Add a preloader.

- Look at MP3 encoding library for ActionScript to shorten upload times.

- Visual appearance of the app could be improved.

- MinimalComponents could be replaced with Flex. MinimalComps does not seem to
  remove event listeners it creates when components are taken off the stage, so
  it creates a small memory leak problem.

- Listen for IO Errors and Security Errors in the SoundCloudService.

- Investigate workarounds to get upload progress when uploading sound
  (sockets?).

- Handle invalid query strings (will throw an error at present).

- Add event metadata.

- Take appropriate action if a microphone is absent/not supported/blocked by
  user.

- Have a separate parser class that parses the XML, so JSON parsing could
  easily be added later.

- Improve appearance of alternative content for non-Flash users.
