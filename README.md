# TB-100

`macOS` app for transcribing spoken word audio files into text. Just drag an audio file in Finder and drop it onto the app, then tap a button to transcribe it into text.

### To Do
- [ ] user able to reset to accept another dropped file
- [ ] error handling
  - [ ] adjust app if transcribing is not available
    - [ ] or if the transcriber fails initialization
    - [ ] audio file playback error
    - [ ] `transcribe(fileURL:)` fails

### Done
- [x] able to play the dropped audio file
- [x] able to stop playing an audio file
  - [x] reset `currentTime` to `0`
- [x] able to detect when playback has finished
- [x] able to transcribe the dropped audio file
- [x] able to display the transcribed text
- [x] user able to copy transcribed text to the clipboard
