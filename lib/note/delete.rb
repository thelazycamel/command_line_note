module Note
  class Delete

    attr_reader :note, :title

    def initialize(note, title)
      @note = note
      @title = title
    end

    def delete_note
      file_path = "#{NOTE_PATH}/#{title}.txt"
      if File.exists?(file_path)
        File.delete(file_path)
        puts "All Notes within #{title} have been deleted"
      else
        puts "Could note find note with title #{title}"
      end
    end

  end
end