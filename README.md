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
- Check model/VO names.
- WAVE file should not be built every time, only when recording changes.
- Merge UploadEvent and UploadRequestEvent.
- Are relevant errors being listened to/acted upon?
- Add event metadata.
- Invalid query strings cause the application to throw an unhandled error.
- Event listeners in views are not removed when view is removed.
- Does not take appropriate action if a microphone is absent/not supported.
