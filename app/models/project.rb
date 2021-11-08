class Project < ApplicationRecord
  enum status: [:active, :abandoned, :acquired]
end