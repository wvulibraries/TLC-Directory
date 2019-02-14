module ImportAdapter  
    class PublicationAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            @faculty.publications << [Publication.find_or_create_by(starting_year: row[:dty_start], ending_year: row[:dty_end], title: row[:title], url: row[:web_address], description: row[:abstract])]
        end

    end
end