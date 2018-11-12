# Used to create serialized hashes which send formatted data to hashes
# for use in the API
#
# @author David J. Davis
# @since 0.0.1
module Version1
  # Specific Module is Building
  # V1 will be extended by Each Model that will need an API
  module EmployeesSerializer
    include Version1::BaseSerializer
    # Creates an array of Buildings used in API Generation
    #
    # @author David J. Davis
    # @since 0.0.1
    def serialize_faculties(faculties)
      {
        faculties: faculties.map do |faculty|
          serialize_faculty(faculty)
        end
      }
    end

    # Creates an array of Buildings used in API Generation
    #
    # @author David J. Davis
    # @since 0.0.1
    def serialize_faculty(faculty)
      {
        id: faculty.id,
        display_name: faculty.display_name.strip,
        name: faculty.name,
        first_name: faculty.first_name,
        last_name: faculty.last_name,
        middle_name: faculty.middle_name,
        title: faculty.title, 
        image: "#{request.base_url}#{faculty.image.url}",
        #phones: serialize_phones(faculty.phones),
        #addresses: serialize_addresses(faculty.addresses),
        #departments: serialize_departmentable(faculty.departmentable),
        #subjects: faculty.subjects.pluck(:name), 
        cv: ("#{request.base_url}#{faculty.resume.url}" if faculty.resume?)
      }
    end

    # Creates an array of department and role
    #
    # @author David J. Davis
    # @since 0.0.1
    # def serialize_departmentable(departmentable)
    #   {
    #     department: departmentable.map do |d|
    #       {
    #         name: d.department.name,
    #         role: d.leadership_role
    #       }
    #     end
    #   }
    # end
  end
end