# Spaced Repetition System

## Introduction

Spaced Repetition is a learning system that incorporates increasing interval time between
subsequent reviews of the previously learned material in order to exploit the psychological
spacing effect.

You can check the app at [heroku](https://mysrs.herokuapp.com). It might take a while for the site to load at first since heroku is firing up the dyno.

## Setting up the rails app

1. First run ```bundle install --without production``` to install gems needed

2. ```rails db:migrate && rails db:seed``` to seed the database with data

3. Finally, run the test suite to verify that everything is working correctly: ```rails test```

4. ```rails server``` to launch the server and head to ```http://localhost:3000``` on your web browser
