module ImportAdapter  
    class PublicationAdapter < BaseAdapter

        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            @faculty.publications << [Publication.find_or_create_by(starting_year: row["DTY_START"], ending_year: row["DTY_END"], title: row["TITLE"], url: row["WEB_ADDRESS"], description: row["ABSTRACT"])]
        end

    end
end