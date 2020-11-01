class Song < ApplicationRecord
    validates :title, presence: true 
    validates :release_year, presence: true, if: :released_true
    validate :cant_be_future, :same_song_twice_in_a_year


    def released_true
        released == true 
    end 

    def cant_be_future
        if released == true 
            if release_year.present? && release_year >= Time.now.year 
                errors.add(:release_year, "Isn't valid if the date hasn't happened yet")
            end 
        end 
    end

    def same_song_twice_in_a_year
        if released == true 
            if release_year.present? && Song.find_by(:title => self.title, :release_year => self.release_year, :artist_name => self.artist_name)
                errors.add(:title, "Can't have two of the same song released in the same year")
            end
        end     
    end 
end
