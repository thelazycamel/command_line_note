require "optparse"
require "find"
require "pry"

NOTE_PATH = "/Users/#{ENV['USER']}/Dropbox/notational_data"

@options = {}

option_parser = OptionParser.new do |opts|
	
	opts.on("-a ADD") do |note|
		@options[:note] = note
	end

	opts.on("-d", "--delete") do
		@options[:delete] = true
	end

end

option_parser.parse!

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