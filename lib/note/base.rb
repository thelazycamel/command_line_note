# encoding: UTF-8

module Note

  NOTE_PATH = "/Users/#{ENV['USER']}/Library/CloudStorage/Dropbox/"

  class Base

    attr_reader :note

    def initialize
      @options = {}
      @option_parser = option_parser
      @option_parser.parse!
      @note = @options[:note]
    end

    def parse
      quit if ARGV.empty?
      if @options[:note]
        Note::Add.new(note, title).add_note
      elsif @options[:delete]
        Note::Delete.new(note, title).delete_note
      else
        Note::Search.new(search_param).search_note
      end
    end

    private

    def quit
      puts "You must supply some search criteria"
      puts @option_parser.help
      exit
    end

    def option_parser
      OptionParser.new do |opts|
        executable_name = File.basename($PROGRAM_NAME)

        opts.banner = "\nAdd notes via the command line to notational velocity and share on dropbox\n"
        opts.banner << "Change your notational velocity preferences to use the following path: #{NOTE_PATH}\n\n"
        opts.banner << "Usage: #{executable_name} <title> [options] <\"note\">"

        opts.on("-a ADD", "Add a new note") do |note|
          @options[:note] = note
        end

        opts.on("-o", "--open", "open editor at #{NOTE_PATH}") do
          @options[:open] = true
        end

        opts.on("-d", "--delete", "delete an existing note") do
          @options[:delete] = true
        end
      end
    end

    def title
      ARGV.join(" ").strip
    end

    def search_param
      ARGV.join(" ")
    end

  end
end

Note::Base.new.parse
