# encoding: UTF-8	
require "optparse"
require "find"
require "pry"

NOTE_PATH = "/Users/#{ENV['USER']}/Dropbox/notational_data"

@options = {}

@option_parser = OptionParser.new do |opts|

	executable_name = File.basename($PROGRAM_NAME)

	opts.banner = "\nAdd notes via the command line to notational velocity and share on dropbox\n"
	opts.banner << "Change your notational velocity preferences to use the following path: #{NOTE_PATH}\n\n"
	opts.banner << "Usage: #{executable_name} <title> [options] <\"note\">"
	
	opts.on("-a ADD", "Add a new note") do |note|
		@options[:note] = note
	end

	opts.on("-d", "--delete", "delete an existing note") do
		@options[:delete] = true
	end

end

@option_parser.parse!

def add_note
  title = ARGV.join(" ").rstrip
	File.open("#{NOTE_PATH}/#{title}.txt", "a") do |f|
  	f.write(@options[:note] + "\n")
  	puts "new note added to #{title} => #{@options[:note]}"
	end	
end

def delete_note
	title = ARGV.join(" ").rstrip
	file_path = "#{NOTE_PATH}/#{title}.txt"
	if File.exists?(file_path)
		File.delete(file_path)
		puts "All Notes within #{title} have been deleted"
	else
		puts "Could note find note with title #{title}"
	end
end

def search_note
	if ARGV.empty?
		puts "You must supply some search criteria"
		puts @option_parser.help
		exit
	end
  search_param = ARGV.join(" ")
  Find.find("/Users/#{ENV['USER']}/Dropbox/notational_data/") do |file|
    unless file[".txt"].nil?
      if file["#{search_param}.txt"]
        File.open(file, "r").each_line do |line|
          puts line
        end
      else
        File.open(file, "r").each_line do |line|
          puts line if line.include?(search_param)
        end
      end
    end
  end
end

if @options[:note]
	add_note
elsif @options[:delete]
	delete_note
else
	search_note
end