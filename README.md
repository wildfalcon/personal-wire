# Personal Wire

Personal Wire is a tool that makes it simple to use social medial (Twitter, Facebook, Blogs etc) to market yourself as a photographer.

At the end of a shoot, all you have to do is export the photos you want to post online into a folder on your computer. On Monday, Personal Wire will post your first picture to your blog, to Facebook, to Twitter. On Wednesday it will post your second picture to the same places. On Friday your third picture. Read more on the [Personal Wire Site](http://wildfalcon.github.io/personal-wire/)

#What is it

Personal Wire is a Rails App that fetches photos from your Dropbox account and publishes them to Social Media sites.

It has a small web interface (for configufing social media sites) and seeing the photos it has imported, and published.

It is extensible so it can be extended to fetch photos from sources other than Dropbox, or to publish to different social media sites. 

Currently it supports Dropbox for fetching photos, and Wordpress blogs and Facebook for publishing photos

Personal Wire is can be run on a free [Heroku](http://heroku.com) Application. For normal usage it won't use enough processer hours to incur any cost. For heavy users turning off the web dyno will prevent it incurring any costs. Though (obviously) the web interface to Personal Wire can't be used if the web dyno is turned off


# Installation

These instructions show how to install Personal Wire on [Heroku](http://heroku.com). 

If you don't want to install and run Personal Wire yourself, and would be willing to pay $5-$10 / month, then [sign up here](http://eepurl.com/IBFnL). If there is enough interest I may set it up as a service


These instructions assume you are using the command line, so are suitable for anyone using Linux or Mac OS X.

Windows users can still use Personal Wire (it doesn't run on your computer - so your operating system doesn't effect the app at all), but I don't have step by step instructions for how to set it up on Windows


## Overview
1. Create a Heroku App
2. Clone Personal Wire from github, and deploy to Heroku
3. Set up S3 to store the photos
4. Set up the Dropbox integration (so you can fetch photos)
5. Set up the Wordpress Integration (so your photos can pushed to your blog)
6. Set up the Facebook Integration (so you photos can be pushed to your Facebook timeline and Pages)
7. Set up the cron job so it all happens automatically


###Create a Heroku Account

Visiti [Heroku](http://www.heroku.com]), create an account if needed. 

Download and install the [Heroku Toolbelt](https://toolbelt.heroku.com/)

If you are new to Heroku, [set up your ssh keys](https://devcenter.heroku.com/articles/keys)

###Clone Personal Wire from github, and deploy to Heroku
The following code will create a Herku app and deploy Personal Wire to it

```
git clone https://github.com/wildfalcon/personal-wire.git
cd personal wire
heroku create
git push heroku master
heroku run rake db:migrate

```

You can view the new app's website by running

```
heroku open
```

Make sure to take note of the URL heroku assigned to your app. You will need it later to configure the Dropbx and Facebook integration

###Set up S3 to store the photos
Create an [Amazon S3](http://aws.amazon.com/s3/) account if you don't already have one. Use Amazon's tools to create a new bucket for your photos to be stored in

Take note of your bucket name, and your S3 Key and Secret (both are available in S3 web application). 

The run the following commands to configure the S3 integration in Personal Wire

```
heroku config:set S3_BUCKET=<bucket-name>
heroku config:set S3_KEY=<s3-key>
heroku config:set S3_SECRET=<s3-secret>
```

###Set up the Dropbox integration (so you can fetch photos)

You need to create a "Dropbox App" in order to fetch photos from Dropbox. Don't worry - it's easy

Visit the [Dropbox Developer Page](https://www.dropbox.com/developers/apps), and click on "Create App"

Answer the questions, and take note of the App Key and App Secret.

Make sure you add ```https://<herokuapp-name>.herokuapp.com/sources/dropbox/create```
to the "OAuth redirec URIs". It's important to use HTTPS and not HTTP otherwise Dropbox will refuse to connect

Then you need to configure Personal Wire to use your new Dropbox App

```
heroku config:set DROPBOX_KEY=<dropbox-key>
heroku config:set DROPBOX_SECRET=<dropbox-secret>
```

Then you need to configure Personal Wire, telling it to read from Dropbox, and what folder to look for.

Go to the web interface for your app ```heroku open```, then Under "Available Services", find Dropbox and click on "Add Source"

This will take you to the Dropbox auth page where you have to approve access to your files, then redirect to to Personal Wire. If you are using the free Heroku app you will get an SSL warning. This is because the gloabl Heroku SSL certificate is being used. It's ok to accept the warning and continue anyway. 

Next fill in the form at the bottom of the Page on Personal Wire with the path to the folder in Dropbox where you will put your photos. 

Dropbox will now appear under "Configured Sources". Click on "enable"

You can test if this has worked by running the command

```
heroku run rake import_photos
```

This will import all photos from the specified folder in Dropbox into Personal wire



###Set up the Wordpress Integration (so your photos can pushed to your blog)

Visit the web interface of the app with ```heroku open```
Under Available Services find "Wordpress", and click "Add Destination"

Fill in the hostname, username and password for your blog

*  The hostname should be without http://
*  The password is saved in plan text (it has to be sent to wordpress in plain text) so do not use a sensitive password
*  Your wordpress blog needs to have a user account with the same username and password. This is the user that will be listed as the "Author" for the posts

Dropbox will now appear under "Configured Sources". Click on "enable"

You can test if this has worked by running the command

```
heroku run rake post_a_photo
```

Which will randomly select a photo, and post it to your blog

###Set up the Facebook Integration (so you photos can be pushed to your Facebook timeline and Pages)
Visit the [Facebook Apps Page](https://developers.facebook.com/apps) 

Then navigate to "apps > create new app"

Fill out details. You will need to tell Facebook the URL of your Heroku App

On the Settings > Basic page you can see your AppID and AppSecret

        heroku config:set FB_ID=<app-id>
        heroku config:set FB_SECRET=<app-secret>

Then you need to configure Personal Wire telling it to push to Facebook, and (optional) which Facebook Page

Go to the web interface for your app ```heroku open```, then Under "Available Services", find Facebook and click on "Add Destination"

This will take you to the Face auth page where you have to approve access to post to your timeline, and manage you pages. Then you will be redirected to to Personal Wire. 


Dropbox will now appear under "Configured Sources". Click on "enable" if you want to post photos to your **personal timelime**

If you don't want to post to your personal page, but would like to post to a Facebook Page then you need to add that as a separate Destination

Under "Available Services", look for facebook_page and click "Add Destination: _Facebook Name_"

A page will open showing all the Facebook Pages you have permissions to post on. Click the one you would like to post your photos on. 

Now you should see Your page appear under "Configured Destinations", click on "enable"

You can test if this has worked by running the command

```
heroku run rake post_a_photo
```

Which will randomly select a photo, post it to your blog and then post it to facebook with a link back to your blog

**KNOWN BUG** currently you can't post to Facebook unless you have a wordpress blog configured and enabled


###Set up the scheduled job so it all happens automatically

The last step is to add a scheduled job so that new photos are imported automatically and photos are posted automatically. 

Add the heroku scheduler

```
heroku addons:add scheduler:standard
```

Then to configure the schedule, open the config page by running

```
heroku addons:open scheduler
```

Create a dialy schedule, running at whatever time of day you want photos to be posted, and configure it to run the task

```
rake import_and_post
```

By default it posts photos on Mondays, Wednesday and Saturdays. If you want to chance this then you need to edit the file ```lib/tasks/wire.rake```

Change the line that reads

```
  if [1,3,6].include?(Time.now.wday) 
```

To show which days you want photos to be posted on. Monday = 1, Tuesday = 2 and so on

#Contributing
If you want to add code, please fork the project, make your changes and submit a pull request
