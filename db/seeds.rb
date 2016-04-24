# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

=begin
Media.create(
    [ { station: "ARD",
        title: "Sport im Osten extra: 1. FC Magdeburg - Dynamo Dresden",
        genre: "Sport im Osten",
        date: Time.parse("16.04.2016"),
        duration: timestring_to_int("02:05:00"),
        description: "",
        media_url: "http://pd-ondemand.swr.de/swr-fernsehen/sport-extra/855873.l.mp4",
        origin_url: "http://www.ardmediathek.de/tv/Sport-im-Osten/Sport-im-Osten-extra-1-FC-Magdeburg-/MDR-Fernsehen/Video?bcastId=7545380&documentId=34718538",
        live: true,
        to_delete: false
      },
      { station: "ARTE.DE",
        title: "Das Geisterhaus",
        genre: "Spielfilm",
        date: Time.parse("17.04.2016"),
        duration: timestring_to_int("02:18:37"),
        description: "Der junge Minenarbeiter Esteban Trueba (Jeremy Irons) arbeitet hart, um die gutb",
        media_url: "http://arte.gl-systemhaus.de/am/tvguide/default/036355-000-C_EQ_1_VA_02292794_MP4-1500_AMM-Tvguide.mp4",
        origin_url: "http://www.arte.tv/guide/de/036355-000-A/das-geisterhaus",
        live: true,
        to_delete: false
      }
    ])
=end

Token.create({api_key: "KgxkRicETXmQYgv3"})