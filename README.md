# digiiNote
Diginote is your one stop shop for text digitilization. We use the Google Vision API to turn images of text, including handwriting, into searchable and editable text. We then send that text straight to your Google Drive.
## Installation
### Dependencies
This app uses Rails 5, Ruby 2.4 and PGSQL.

You will also need to obtain API keys and credentials for Google Cloud, Google Authentication and Google Drive.

This app requires use of the Google SDK for GCloud authorization
1. Use Homebrew to install the Google SDK by entering `` brew install Caskroom/cask/google-cloud-sdk ``
2. To get access to your GCloud resources enter `` gcloud auth application-default login ``
3. This will take you to your google account where you can log in. Vision OCR does eventually cost money, but if you sign up you'll get $300 of credit to spend in the first two months
## Usage
1. On the home page you can upload a photo or take a photo of handwriting or text.
2. You will be redirected to an "edit" page where you can check the accuracy, make changes and add more images to your document.
3. Once you're happy with your text, click "Save to Google Drive". This will redirect you to a Google Drive login.
4. Upon login you will see an embedded Google Doc that you can edit, and the file will be saved to your Google Drive.
5. Profit!!!
## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D
## History
Our team's Slack was filled with pictures of handwritten notes, mostly on whiteboards, Post-its, or binder paper. Most were unreadable and forget about searching through them! We knew there had to  be a better way. So we set out to make an app that would handle all our messy notes. We found google's api was effective, but there was no easy way to use it. And so began the saga of digiiNote
## Credits
Thanks to everyone who worked on the wrappers for the Google APIs, special thanks to @gimite for the ruby-google-drive gem. Thanks to @KDwinzel for inspiration with his Ocrad JS. Props to everyone who worked on Tesseract. Shout-out to Jared for the debugging help. 
