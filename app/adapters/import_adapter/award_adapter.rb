module ImportAdapter  
    class AwardAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            hash = {}
            hash[:starting_year] = row[:dty_start]
            hash[:ending_year] = row[:dty_end]
            hash[:name] = row[:name]
            hash[:organization] = row[:org]        
            hash[:description] = row[:desc]  

            @faculty.awards << [Award.find_or_create_by(hash)]
        end

    end
end