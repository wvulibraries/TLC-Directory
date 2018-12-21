# app/controllers/concerns/directory_search.rb 
module DirectorySearch
  extend ActiveSupport::Concern

  def self.directory_search(search_term = nil, college_id = nil, dept_id = nil)
    search_definition = search_all(search_term, college_id, dept_id) if search_term.present? && college_id.present? && dept_id.present?
    search_definition = search_college(search_term, college_id) if search_term.present? && college_id.present?
    search_definition = search_dept(search_term, dept_id) if search_term.present? && dept_id.present?
    search_definition = search(search_term) unless college_id.present? || dept_id.present?

    results = Faculty.search(search_definition, size: 1000).records
                     .includes(:college, :department)
                     .order(:last_name, :first_name);
    return results
  end
  
  private

  def self.search(search_term)
    search_definition = {}
    search_definition[:query]  = { query_string:  { query: search_term } }
    return search_definition
  end

  def self.search_college(search_term, college_id)
    search_definition = {}
    search_definition[:query]  = { query_string:  { query: '(' + search_term + ') AND (' + 'college_id:' + college_id + ')'} }
    return search_definition
  end
  
  def self.search_dept(search_term, dept_id)
    search_definition = {}
    search_definition[:query]  = { query_string:  { query: '(' + search_term + ') AND (' + 'department_id:' + dept_id + ')'} }
    return search_definition
  end

  def self.search_all(search_term, college_id, dept_id)
    search_definition = {}
    search_definition[:query]  = { bool:{
         must:{
            query_string:{
               query: search_term
            }
         },
         filter:{
            term:{ college_id: college_id, department_id: dept_id }
         }
        }}
    return search_definition
  end

end