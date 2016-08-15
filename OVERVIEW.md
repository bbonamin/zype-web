# Zype Web - Overview

## Introduction

Zype Web is a Ruby on Rails 5 application, which uses the Zype API to show content.

Calling the Zype API to get a list of videos on every user request is avoided to technically allow the application to scale without impacting the Zype API. Instead, there's a recurrent job set up that calls `Video.refresh_all!` once a day, and it updates the whole video list, adding and updating those videos that have changed.

This period could be changed to a shorter or longer period if necessary. In the production environment, in order to accomplish this, we're using the `Heroku Scheduler`, but a cron job would do just as well.

When a user wants to view a video, we show them the player if it doesn't require a subscription, and  ask them to log in if the video requires a subscription. We then leverage the native Zype video players to show the content.

## Models
Zype Web has two models. One of them is an ActiveRecord model, `Video`, and it's used as the place to hold behavior related to deserializing the payloads from the Zype API into a ActiveRecord compatible format (it knows nothing about talking to the Zype API), and some nice virtual attributes, plus the standard ActiveRecord behaviors.

The other model, `VideoGateway`, deals with the communication between the Zype API and this application.

This low coupling allows changing very easily one model or the other, depending if the Zype API changes, or business requirements change.

## Controllers
Zype Web has two controllers. One of them is `VideoController`, which is a standard CRUD controller. Its responsibility is to ask the `Video` model for video records, and display them to the index or show views.

The other controller, `SessionsController` is responsible for allowing users to sign in to Zype via their OAUTH endpoint, so that they can be shown subscription videos.

## Views
There are several views, most of them are standard views backed by controller actions, and some of them have been split into partials in order to make their maintenance easier.