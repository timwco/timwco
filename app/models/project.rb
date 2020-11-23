class Project < ApplicationRecord
  enum status: [:active, :abandoned, :sold, :shut_down]
end