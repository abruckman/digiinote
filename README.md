![digiinote]
(https://github.com/abruckman/digiinote/blob/development/public/images/header-smaller.png?raw=true)



<div style="text-align: center;" markdown="1">

![digiinote_image](https://github.com/abruckman/digiinote/blob/development/public/images/image_1.jpg?raw=true )

![digiinote_image2](https://github.com/abruckman/digiinote/blob/development/public/images/image_2.jpg?raw=true)
</div style="text-align: center;" markdown="1">




## Description
Digiinote is a Rails app that takes in an uploaded image of handwritten notes and digitizes them directly into a Google Drive document. After each submission, you are able to view the document on an embedded Google Drive

##Usage
* Visit the digiinote main page and upload an image
![](https://github.com/abruckman/digiinote/blob/development/public/images/demo_upload_digii.gif?raw=true)

* Or capture an image instantly
![](https://github.com/abruckman/digiinote/blob/development/public/images/demo_webcam.gif?raw=true)





---
The site is available live on [Heroku](https://evening-lake-82966.herokuapp.com)

---


### 0. Fork and then clone the repo

In your terminal run:
```bash
  git clone https://github.com/<your-username>/digiinote.git
```

### 1. Get and hide your API keys

### 2. Include dontenv gem in your gem file

##### You'll need to get API keys from:
- [Google API Console] (https://console.developers.google.com)
- Download the Google Credentials JSON

### .env file
This is what our .env file looks like, with the empty strings replaced with API keys.

```bash
GOOGLE_SECRET_KEY = ""
OAUTH = ""
CLIENT_SECRET = ""
PROJECT_ID = ""
AUTH_URI = ""
TOKEN_URI = ""
AUTH_PROVIDER_X509_CERT_URL = ""
REDIRECT_URIS = ""
TYPE = "service_account"
PRIVATE_KEY_ID = ""
PRIVATE_KEY = ""
CLIENT_EMAIL =" ""
CLIENT_ID = ""
CLIENT_X509_CERT_URL = ""
DEPLOYED_TO = "local"
```

### Google SDK

 This app requires use of the Google SDK for GCloud authorization

1. Use Homebrew to install the Google SDK by entering `` brew install Caskroom/cask/google-cloud-sdk ``
2. To get access to your GCloud resources enter `` gcloud auth application-default login ``
3. This will take you to your google account where you can log in


### 3. Navigate to the project
- Run bundle install to install the gems
- Start the rails server (localhost)

```bash
cd digiinote
bundle
rails s
```

Site will be live at https://localhost:3000/

## About digiinote

Our team noticed a trend of circulating images on our cohort’s Slack Channel that had various handwritten notes on whiteboards, post-its, and/or notebook paper that were impossible to keep track of. We integrated the Google Vision, Google Drive, and Google OAuth API to build a user-friendly application that digitizes handwritten notes.

#####Languages and technologies:
* Ruby on Rails
* Materialize
* HTML/CSS
* Javascript
* PostgreSQL


## Contributors

* [Valeria Martinez](https://github.com/valeria-martinez)
* [Sarav Shah](https://github.com/saravshah)
* [James Draper](https://github.com/jdraper9)
* [Andy Bruckman](https://github.com/abruckman)
* [Martin Murray](https://github.com/mjmurra4)


## Credits
Thanks to @KDwinzel for inspiration with his Ocrad JS.