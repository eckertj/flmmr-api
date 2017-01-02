
namespace :db do
  desc "Fetches media sources and writes them to the database"
  task :update => :environment do

    puts "#{Time.now.utc.iso8601}: Update database..."

    puts "#{Time.now.utc.iso8601}: Rails root: #{Rails.root} \n"

    update_doc = File.open("app/data/update-json.xml") { |f| Nokogiri::XML(f) }

    update_link_list = update_doc.search('Server').map { |node| node.at('URL').text.strip }

    for update_link in update_link_list
      print "#{Time.now.utc.iso8601}: Fetching #{update_link}... "

      download = open(update_link)

      if !File.exists?("tmp/media/tmp.xz")
        
        path = "tmp/media"

        FileUtils.mkdir_p(path) unless File.exists?(path)

        File.open("tmp/media/tmp.xz", "w+") {}

        "#{Time.now.utc.iso8601}: Created #{path}"
      end

      IO.copy_stream(download, "tmp/media/tmp.xz")

      print "#{Time.now.utc.iso8601}: complete! \n"

      print "#{Time.now.utc.iso8601}: Decompressing #{update_link}..."

      XZ.decompress_file("tmp/media/tmp.xz", "tmp/media/tmp.txt")

      line_count = `wc -l "tmp/media/tmp.txt"`.strip.split(' ')[0].to_i

      print "#{Time.now.utc.iso8601}: complete! Number of lines: #{line_count} \n"

      if line_count > 10000

        puts "#{Time.now.utc.iso8601}: Set all old media database to delete after fetch"
        Media.update_all(to_delete: true)

        puts "#{Time.now.utc.iso8601}: Reading media links..."

        # Read JSON from a file, iterate over objects
        file = open("tmp/media/tmp.txt")

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
              date = parsed['X'][3].length<1 ? Time.now : Time.parse(parsed['X'][3])
              duration = parsed['X'][5].length<1 ? 0 : timestring_to_int(parsed['X'][5])
              description = parsed['X'][7]
              url = parsed['X'][8]
              website = parsed['X'][9]

              if (station != '')
                current_station = station
              end

              if (!urls.include?(url))
                urls.push(url)

                Media.create(
                    {station: current_station,
                     title: title,
                     genre: genre,
                     date: date,
                     duration: duration,
                     description: description,
                     media_url: url,
                     origin_url: website,
                     to_delete: false,
                     live: false
                    })

              end
            end
          end
          bar.inc
        end
        puts "#{Time.now.utc.iso8601}: Reading media links completed!"

        puts "#{Time.now.utc.iso8601}: Set new data live..."
        Media.update_all(live: true)
        puts "#{Time.now.utc.iso8601}: Deleting deprecated links..."
        Media.delete_all(to_delete: true)
        bar.finished
        break;
      else
        puts "#{Time.now.utc.iso8601}: #{update_link} is too small!"
      end
    end
    puts "#{Time.now.utc.iso8601}: Finished updating Database!"
  end

  desc "Cleans up database in case another rake tasks failes and messes up database"
  task :clean => :environment do
    puts "#{Time.now.utc.iso8601}: Setting all database entries to live..."
    Media.update_all(live: true)
    puts "#{Time.now.utc.iso8601}: Deleting old entries from database..."
    Media.delete_all(to_delete: true)
    puts "#{Time.now.utc.iso8601}: done!"
  end

end