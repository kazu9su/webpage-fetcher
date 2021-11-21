require 'thor'

class Fetch < Thor
  default_task :fetch

  desc 'fetch URLs', 'fetching web pages of urls given as arguments'
  method_options metadata: :boolean, desc: 'Display metadata'
  def fetch(*urls)
    urls.each do |url|
      source  = FileSource.new
      content = source.download_content(URI.parse(url))

      File.open(source.fname, 'w') do |f|
        f.write(content)
      end

      if options[:metadata]
        source.metadata.each do |k, v|
          puts "#{k}: #{v}"
        end
      end
    rescue StandardError => e
      puts "An error of type #{e.class} happened, message is #{e.message}"
      puts e.backtrace
    end
  end
end
