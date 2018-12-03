# Searchable
#
# @author David J. Davis
# @modified_by Tracy A. McCormick
# @concern
# @since 0.0.2
module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    index_name [base_class.to_s.pluralize.underscore, Rails.env].join('_')

    # set number of shards
    settings number_of_shards: 1

    # create
    after_commit on: [:create] do
      __elasticsearch__.index_document if status == 'enabled'
    end

    # update
    after_commit on: [:update] do
        __elasticsearch__.index_document
        __elasticsearch__.delete_document unless status == 'enabled'
    end

    # delete
    after_commit on: [:destroy] do
      __elasticsearch__.delete_document if status == 'enabled'
    end
  end
end