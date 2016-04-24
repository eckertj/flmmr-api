# flmmr-api

flmmr-api ist eine Ruby on Rails RESTful JSON API für die Mediatheken der deutschen öffentlich-rechtlichen Rundfunkanstalten.


### Getting up and running

```
$ git clone git@github.com:eckertj/flmmr-api.git
$ bundle install
$ rake db:setup
$ rake db:update #loads data and fills database
```

### Usage
The data can be accessed by passing several url parameters. Currently the following parameters are implemented:

```ruby
q             # query on tv station, title, genre and description
station       # limits response to a specific tv station
after_date    # limits response to media that was published after a specific date
before_date   # limits response to media that was published before a specific date
min_duration  # limits response to media to a minimum duration (in seconds)
max_duration  # limits response to media to a maximum duration (in seconds)
```

#### Request
```
flmmr-api.herokuapp.com/api?q=tatort
```

#### Response
```json
{
    media: [
        {
            station: "ARD",
            title: "Rechtsmedizin - Hinter den Kulissen",
            genre: "",
            date: "2015-06-16T00:00:00.000Z",
            duration: 300,
            description: "Ein Blick hinter die Kulissen der Bonner Rechtsmedizin. In meterlangen Regalen lagern hier Haar- und Blutproben. Und eines wird sofort klar: In den Laboren braucht es viel mehr Geduld als ein Fernsehtatort vermuten lässt.",
            media_url: "http://ondemand-ww.wdr.de/medp/fsk0/72/729223/729223_7872044.mp4"
        }
    ]
}
```


### Try it

Try it live at [```flmmr-api.herokuapp.com/api?q=searchterm```](https://flmmr-api.herokuapp.com/api?q=searchterm)!

There is also some sample data in the ```seeds.rb``` that can be commented in so that you can test the API without filling it with real data. Currently, the application was tested only on Ruby 2.3.0.


### Credits

Mediathekdirekt project: [https://gitlab.com/mediathekdirekt/mediathekdirekt](https://gitlab.com/mediathekdirekt/mediathekdirekt)

EasyContacts API created for a Ruby Meetup Talk: [https://github.com/aomran/api-presentation](https://github.com/aomran/api-presentation)
