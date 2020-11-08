# Downtime Detector

https://downtimedetector.xyz

It is a simple downtime detector. You can add any URL and the application will ping it every 5 minutes showing the result in the user's dashboard and optionally notifying the user via email about any problems occured.

## A note about the architecture

I developed it using Ruby on Rails framework and [ActiveInteraction](https://github.com/AaronLasseigne/active_interaction) gem. I consider such an approach much cleaner, more scalable and simply more convenient than using "The Rails Way" with its fat models, Active Record callbacks, validations etc.
