module ImportAdapter  
    class AwardAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            @faculty.awards << [Award.find_or_create_by(starting_year: row[:dty_start], ending_year: row[:dty_end], name: row[:name], organization: row[:org], description: row[:desc])]
        end

    end
end