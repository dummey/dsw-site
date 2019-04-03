ActiveAdmin.register VenueAvailability do
  belongs_to :venue, optional: true
  # belongs_to :annual_schedule

  menu parent: 'Sessions'

  permit_params :venue_id, :submission_id, :year, :day, :time_block

  scope('Current', default: true, &:for_current_year)
  scope('Previous Year', &:for_previous_years)

  controller do
    def scoped_collection
      resource_class.includes(:venue,
                              :submission)
    end
  end

  index do
    selectable_column
    column :venue
    column :submission
    column :year
    column(:day) do |s|
      VenueAvailability::DAYS[s.day]
    end
    column(:time_block) do |s|
      VenueAvailability::TIME_BLOCK[s.time_block]
    end
    actions
  end

  filter :venue
  filter :submission
  filter :year
  filter :day
  filter :time_block

  form do |f|
    f.object.year ||= Date.today.year
    f.inputs do
      f.input :venue_id, as: :select, collection: Venue.alphabetical.map { |v| [ v.name, v.id ] }, include_blank: true
      f.input :submission_id, as: :select, collection: Submission.all.map { |v| [ v.title, v.id ] }, include_blank: true
      f.input :year
      f.input :day, as: :select, collection: VenueAvailability::DAYS.invert, include_blank: false
      f.input :time_block, as: :select, collection: VenueAvailability::TIME_BLOCK.invert, include_blank: false
    end
    f.actions
  end

end
