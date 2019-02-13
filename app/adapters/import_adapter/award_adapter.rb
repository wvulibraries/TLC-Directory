module ImportAdapter  
    class AwardAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            @faculty.awards << [Award.find_or_create_by(starting_year: row["DTY_START"], ending_year: row["DTY_END"], name: row["NAME"], organization: row["ORG"], description: row["DESC"])]
        end

    end
end