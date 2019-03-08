module ImportAdapter  
    class PublicationAdapter < BaseAdapter
        require 'uri'
        
        private

        # placeholder for adding additional fields for the faculty model
        def add_optional_items(row)
            if row[:status] == 'Published'
                hash = {}
                hash[:starting_year] = row[:dty_start]
                hash[:ending_year] = row[:dty_end]

                hash[:author] = build_author_list(row)

                hash[:title] = row[:title]
                hash[:url] = row[:web_address]        
                hash[:description] = row[:abstract]
                hash[:status] = row[:status]
                hash[:publisher] = row[:publisher]
                hash[:pagenum] = row[:pagenum]
                hash[:issue] = row[:issue]
                hash[:volume] = row[:volume]

                @faculty.publications << [Publication.find_or_create_by(hash)]
            end
        end

        def build_author_list(row)
            authors = []
            if row[:intellcont_auth_1_lname].present? && row[:intellcont_auth_1_fname].present?
                authors << (row[:intellcont_auth_1_lname] + ', ' + row[:intellcont_auth_1_fname]).strip
            end
            if row[:intellcont_auth_2_lname].present? && row[:intellcont_auth_2_fname].present?
                authors << (row[:intellcont_auth_2_lname] + ', ' + row[:intellcont_auth_2_fname]).strip
            end        
            if row[:intellcont_auth_3_lname].present? && row[:intellcont_auth_3_fname].present?
                authors << (row[:intellcont_auth_3_lname] + ', ' + row[:intellcont_auth_3_fname]).strip
            end   
            if row[:intellcont_auth_4_lname].present? && row[:intellcont_auth_4_fname].present?
                authors << (row[:intellcont_auth_4_lname] + ', ' + row[:intellcont_auth_4_fname]).strip
            end 
            if row[:intellcont_auth_5_lname].present? && row[:intellcont_auth_5_fname].present?
                authors << (row[:intellcont_auth_5_lname] + ', ' + row[:intellcont_auth_5_fname]).strip
            end
            if row[:intellcont_auth_6_lname].present? && row[:intellcont_auth_6_fname].present?
                authors << (row[:intellcont_auth_6_lname] + ', ' + row[:intellcont_auth_6_fname]).strip
            end                        
            return_string = authors.to_sentence
            return_string.sub('and', '&')
        end

    end
end