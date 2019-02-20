module ImportAdapter  
    class PublicationAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            hash = {}
            hash[:starting_year] = row[:dty_start]
            hash[:ending_year] = row[:dty_end]
            hash[:title] = row[:title]
            hash[:url] = row[:web_address]        
            hash[:description] =  row[:abstract]    
            
            @faculty.publications << [Publication.find_or_create_by(hash)]
        end

    end
end