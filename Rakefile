# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'xz'
require 'open-uri'
require 'json'
require 'oj'
require 'rake-progressbar'

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :db do
  desc "Fetches media sources and writes them to the database"
  task :update => :environment do
    puts "Update database..."
    puts "Fetching update links..."
    update_doc = File.open("app/data/update-json.xml") { |f| Nokogiri::XML(f) }
    update_link_list = update_doc.search('Server').map { |node| node.at('URL').text.strip }

    puts "Fetching update links complete!"

    for update_link in update_link_list
      puts "Fetching #{update_link}..."

      download = open(update_link)
      IO.copy_stream(download, "tmp/media/tmp.xz")

      puts "Fetching #{update_link} complete!"
      puts "Decompressing #{update_link}..."

      XZ.decompress_file("tmp/media/tmp.xz", "tmp/media/tmp.txt")

      line_count = `wc -l "tmp/media/test.txt"`.strip.split(' ')[0].to_i

      puts "Decompressing #{update_link} complete! Number of lines: #{line_count}"

      if line_count > 10

        puts "Declare all media database entries as expired"
        Media.update_all(expired: true)

        puts "Reading media links..."

        # Read JSON from a file, iterate over objects
        file = open("tmp/media/test.txt")

        current_station = ''
        urls = []

        bar = RakeProgressbar.new(line_count)

        IO.foreach(file) do |line|
          # process the line of text here

          if line.length > 5

            line[line.length-1]=''

            if line.end_with? ','
              line[line.length-1]=''
            end

            line = "{" + line if not line.start_with? "{"
            line += "}" if not line.end_with? "}"

            parsed = JSON.parse(line)

            if (parsed['X'] != nil)
              station = parsed['X'][0]
              if (parsed[1] != '')
                genre = parsed['X'][1]
              end
              title = parsed['X'][2]
              date = parsed['X'][3]
              duration = parsed['X'][5]
              description = parsed['X'][7]
              url = parsed['X'][8]
              website = parsed['X'][9]
            end

            if (station != '')
              current_station = station
            end

            if (!urls.include?(url))
              urls.push(url)


              dbMediaEntry = Media.find_by(media_url: url)

              if dbMediaEntry.blank?

                Media.create(
                    { station: current_station,
                      title: title,
                      genre: genre,
                      date: date,
                      duration: duration,
                      description: description,
                      media_url: url,
                      origin_url: website,
                      expired: false
                    })

              else
                dbMediaEntry.update(expired: false)
              end

            end

          end

          bar.inc
        end
        puts "Reading media links completed!"

        puts "Deleting deprecated links..."

        Media.destroy_all(expired: true)
        bar.finished
        break;
      else
        puts "#{update_link} is too small!"
      end
    end

  end

  desc "Cleans up database in case another rake tasks failes and messes up database"
  task :clean => :environment do
    Media.update_all(expired: false)
  end
end