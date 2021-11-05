class Project < ApplicationRecord
  enum status: [:active, :abandoned, :acquired, :shut_down]
end