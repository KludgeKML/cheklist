class Trigger < ApplicationRecord
  belongs_to :repository
  has_many :checks

  def handle(event_type, data)
    if event_type == action
      checks.each do |check|
        if check.passed?(pr_id: data[:number])
          repository.create_status(event_type, data, 'success',
            context: 'chekblok', description: check.description)
        else
          repository.create_status(event_type, data, 'failure',
            context: 'chekblok', description: check.description)
        end
      end
    end
  end
end
