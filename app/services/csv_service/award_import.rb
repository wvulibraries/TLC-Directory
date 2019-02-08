module CSVService 
    class AwardImport
        require 'csv'

        attr_reader :import_count

        def initialize(params = {})
            @filename = params[:filename]        
        end

        def perform
            read_csv_file
        end    
        
        private

        def read_csv_file
            @import_count = 0
            CSV.foreach(@filename, headers: true, liberal_parsing: true) do |row|
                #hash = process_row(row)
                faculty = Faculty.find_by(wvu_username: row["USERNAME"])

                if faculty.present?
                    faculty.awards << [Award.find_or_create_by(starting_year: row["DTY_START"], ending_year: row["DTY_END"], name: row["NAME"], organization: row["ORG"], description: row["DESC"])]
                    faculty.save(validate: false)
                end
                @import_count += 1
            end
            return true
        end

        def process_row(row)
            puts row.inspect
            hash = {}

            hash[:wvu_username] = row["USERNAME"]

            # find or create optional items
            hash[:awards] = [Award.find_or_create_by(starting_year: row["DTY_START"], ending_year: row["DTY_END"], name: row["NAME"], organization: row["ORG"], description: row["DESC"])] 
            return hash
        end

    end
end