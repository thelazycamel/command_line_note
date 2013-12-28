module Note
  class Add

    attr_reader :note, :title

    def initialize(note, title)
      @note = note
      @title = title
    end

    def add_note
      File.open("#{NOTE_PATH}/#{title}.txt", "a") do |f|
        f.write(note + "\n")
        puts "new note added to #{title} => #{note}"
      end 
    end

  end
end