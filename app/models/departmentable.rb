class Departmentable < ApplicationRecord
  belongs_to :faculty
  belongs_to :department
end