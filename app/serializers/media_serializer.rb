class MediaSerializer < ActiveModel::Serializer
  attributes :station, :title, :genre, :date, :duration, :description, :media_url
end