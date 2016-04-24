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
flmmr.tv/api?q=tatort
```

#### Response
```json
{
  media: [
    {
      station: "ARD",
      title: "Tatort: Kaltblütig (Video tgl. ab 20 Uhr)",
      genre: "",
      date: "09.03.2016",
      duration: "01:29:00",
      description: "Roza Lanczeck, die Freundin des .....",
      media_url: "http://pd-ondemand.swr.de/swr-fernsehen/filmserie/847022.l.mp4"
    }
  ]
}
```


### Try it


There is some sample data so that you can test the API out. If you find a problem please let me know and I'll fix it :)


### Credits

Mediathekdirekt project: [https://gitlab.com/mediathekdirekt/mediathekdirekt](https://gitlab.com/mediathekdirekt/mediathekdirekt)

EasyContacts API created for a Ruby Meetup Talk: [https://github.com/aomran/api-presentation](https://github.com/aomran/api-presentation)
