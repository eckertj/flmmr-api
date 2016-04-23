# mAPI

mAPI ist eine Ruby on Rails RESTful JSON API für die Mediatheken der deutschen öffentlich-rechtlichen Rundfunkanstalten.


### Getting up and running

```
$ git clone git@github.com:eckertj/mAPI.git
$ bundle install
$ rake db:migrate
$ rake db:update #loads data and fills database
```

### Usage
The data can currently only search by a simple keyword search that can contain the station, title, date etc.

#### Request
```
someurl.io/api?q=tatort
```

#### Anwser
```
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
