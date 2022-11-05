module Note
  class Search

    attr_reader :search_param

    def initialize(search_param)
      @search_param = search_param
    end

    def search_note
      #TODO Tidy this up
      Find.find(NOTE_PATH) do |file|
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
    
  end
end