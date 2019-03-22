# frozen_string_literal: true

module SearchService
  class FacultySearch
    def initialize(params = {})
      @college_id = params[:college]
      @dept_id = params[:department]
      @search_term = params[:search]
    end

    def perform
      return full_query unless passed_params?

      build_query
      execute_query
    end

    private

    def passed_params?
      @search_term.present? || @college_id.present? || @dept_id.present?
    end

    def build_query
      @search_definition = {
        query: {
          bool: {
          }
        }
      }

      #  sanitize and add search string to query
      if @search_term.present?
        sanitized_search = Sanitize.fragment @search_term.gsub(%r{\{|\}|\[|\]|\\|\/|\^|\~|\:|\!|\"|\'}, '')
        @search_definition[:query][:bool][:should] = [{ query_string: { query: sanitized_search } }]
      end

      # add filters to query
      term_array = []
      term_array.push(term: { college_id: @college_id }) if @college_id.present?
      term_array.push(term: { department_id: @dept_id }) if @dept_id.present?
      @search_definition[:query][:bool][:filter] = term_array if term_array.count > 0
    end

    def execute_query
      Faculty.search(@search_definition, size: 1000).records
             .includes(:college, :department)
             .where(visible: true, status: 'enabled')
             .order(:last_name, :first_name)
    end

    def full_query
      Faculty.includes(:college, :department)
             .where(visible: true, status: 'enabled')
             .order(:last_name, :first_name)
    end
  end
end
