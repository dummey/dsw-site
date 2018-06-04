ActiveAdmin.register Submission do

  menu parent: 'Sessions', priority: 1

  permit_params :start_day,
                :end_day,
                :year,
                :description,
                :format,
                :location,
                :notes,
                :internal_notes,
                :target_audience_description,
                :time_range,
                :title,
                :track_id,
                :contact_email,
                :estimated_size,
                :venue_id,
                :cluster_id,
                :budget_needed,
                :volunteers_needed,
                :start_hour,
                :end_hour,
                :state,
                :submitter_id,
                :slides_url,
                :video_url,
                :live_stream_url,
                :company_id,
                :coc_acknowledgement,
                :open_to_collaborators,
                :from_underrepresented_group

  controller do
    def scoped_collection
      resource_class.includes(:track,
                              :submitter,
                              :votes,
                              :user_registrations,
                              :venue,
                              :cluster,
                              :company,
                              sponsorship: :track)
    end

    def show
      @submission = Submission.find(params[:id])
      @versions = @submission.versions
      @submission = @submission.versions[params[:version].to_i].reify if params[:version]
      show!
    end
  end

  # Set a default year filter
  scope('Current', default: true, &:for_current_year)
  scope('Previous Year', &:for_previous_years)

  index do
    selectable_column
    column :title
    column :track, sortable: 'tracks.name'
    column :cluster, sortable: 'clusters.name'
    column :venue, sortable: 'venues.name'
    column('Time', sortable: 'start_hour') do |s|
      "#{s.human_start_day} #{s.human_time_range}".html_safe if s.time_assigned?
    end
    column('Status', sortable: :state) do |s|
      status_tag s.state.to_s.titleize, status_for_submission(s)
    end
    column :submitter, sortable: 'users.name'
    column(:votes, sortable: 'COUNT(votes.id)') { |s| s.votes.size }
    column(:attendees, sortable: 'COUNT(user_registrations.id)') { |s| s.user_registrations.size }
    column(:pending_updates, sortable: false) { |s| s.proposed_updates.present? ? 'Yes' : 'No' }
    actions
  end

  csv do
    column :id
    column :title
    column :description
    column :notes
    column :internal_notes
    column :track do |submission|
      submission.track.try(:name)
    end
    column :cluster do |submission|
      submission.cluster.try(:name)
    end
    column :venue do |submission|
      submission.venue.try(:name)
    end
    column :format
    column(:start_day, &:human_start_day)
    column(:start_time, &:human_start_time)
    column(:end_day, &:human_end_day)
    column(:end_time, &:human_end_time)
    column :submitter_name do |submission|
      submission.submitter.try(:name)
    end
    column :created_at
    column :updated_at
    column(:company_name) { |s| s.company.try(:name) }
    column :contact_email
    column :estimated_size
    column :volunteers_needed
    column :budget_needed
    column :year
    column :registrants do |submission|
      submission.registrants.size
    end
    column :votes do |submission|
      submission.votes.size
    end
    column(:state) do |submission|
      submission.state.to_s.titleize
    end
    column(:venue_name) do |s|
      s.venue.try(:name)
    end
    column(:venue_address) do |s|
      s.venue.try(:combined_address)
    end
  end

  filter :title
  filter :description
  filter :track
  filter :venue, as: :select, collection: -> { Venue.alphabetical }
  filter :company, as: :select, collection: -> { Company.all }
  filter :format
  filter :submitter_name_cont, as: :string, label: 'Submitter Name'
  filter :start_day, as: :select, collection: Submission::DAYS.invert
  filter :end_day, as: :select, collection: Submission::DAYS.invert
  filter :time_range, as: :select, collection: Submission::TIME_RANGES
  filter :format, as: :select, collection: Submission::FORMATS
  filter :state, as: :select, collection: -> { Submission.states }
  filter :cluster, as: :select, collection: -> { Cluster.all }

  form do |f|
    f.inputs 'Basics' do
      f.input :year
      f.input :submitter_id, as: :ajax_select, data: { url: filter_admin_users_path, search_fields: %i[name email] }
      f.input :track_id, as: :select, collection: Track.all.map { |t| [ t.name, t.id ] }, include_blank: false
      f.input :cluster_id,
              as: :select,
              collection: Cluster.all.map { |c| [ c.name, c.id, { disabled: !c.is_active? } ] },
              include_blank: true
      f.input :state,
              as: :select,
              collection: Submission.states.map { |s| [ s.to_s.titleize, s ] },
              include_blank: false
      f.input :title
      f.input :description, hint: 'This is processed with Markdown, and can include additional formatting'
    end
    f.inputs 'Time and Location' do
      f.input :start_day, as: :select, collection: Submission::DAYS.invert, include_blank: true
      f.input :start_hour, as: :select, collection: collection_for_hour_select, include_blank: false
      f.input :end_day, as: :select, collection: Submission::DAYS.invert, include_blank: true
      f.input :end_hour, as: :select, collection: collection_for_hour_select, include_blank: false
      f.input :venue_id, as: :select, collection: Venue.alphabetical.map { |v| [ v.name, v.id ] }, include_blank: true
    end
    f.inputs 'Submitter' do
      f.input :contact_email, hint: 'Multiple addresses are allowed; separate them with commas'
      f.input :company_id, as: :ajax_select, data: { url: filter_admin_companies_path, search_fields: [ :name ] }
      f.input :open_to_collaborators
      f.input :coc_acknowledgement, label: 'Code of Conduct Acknowledgement',
                                    hint: 'If submitting this session on behalf of someone else, you acknowledge that you have informed them of our Code of Conduct'
      f.input :notes, label: 'Pitch'
      f.input :target_audience_description
      f.input :slides_url
      f.input :video_url
      f.input :live_stream_url
    end
    f.inputs 'Additional Information' do
      f.input :estimated_size
      f.input :budget_needed
      f.input :volunteers_needed
      f.input :internal_notes
    end
    f.actions
  end

  sidebar :links, only: %i[edit show] do
    para { link_to('View in panel picker', submission_path(submission)) }
    para { link_to('View in schedule', schedule_path(submission)) }
  end

  sidebar 'Status', only: :show do
    status_tag submission.state.to_s.titleize, status_for_submission(submission)
  end

  sidebar 'Messaging', only: :show do
    span do
      button_to "E-mail #{number_with_delimiter(submission.registrants.count)} attendees",
                new_admin_submission_attendee_message_path(submission),
                method: :get
    end

    if submission.venue &&
        submission.venue.contact_email &&
        submission.contact_email &&
        submission.venue.contact_name
      span do
        button_to 'Send venue match email',
                  send_venue_match_email_admin_submission_path(submission),
                  method: :post,
                  data: { confirm: 'Are you sure?' }
      end
    end
    span do
      button_to 'Send acceptance email',
                send_accept_email_admin_submission_path(submission),
                method: :post,
                data: { confirm: 'Are you sure?' }
    end
    span do
      button_to 'Send rejection email',
                send_reject_email_admin_submission_path(submission),
                method: :post,
                data: { confirm: 'Are you sure?' }
    end
    span do
      button_to 'Send waitlist email',
                send_waitlist_email_admin_submission_path(submission),
                method: :post,
                data: { confirm: 'Are you sure?' }
    end
  end

  # Attendee export
  sidebar 'Attendees', except: :index do
    "#{submission.registrants.count} attending"
  end

  action_item :export_attendee_list, only: %i[edit show] do
    link_to 'Export attendee list', export_attendees_admin_submission_path(submission)
  end

  member_action :export_attendees, method: :get do
    registrations = Submission.find(params[:id]).user_registrations.includes(:user)
    csv_text = Enumerator.new do |lines|
      registrations.find_each do |registration|
        lines << [ registration.user.name,
                   registration.primary_role,
                   registration.user.email,
                   registration.zip,
                   registration.gender ].to_csv
      end
    end
    response.headers['Content-Type'] ||= 'text/csv'
    response.headers['Content-Disposition'] = 'attachment; filename=attendees.csv'
    response.headers['Content-Transfer-Encoding'] = 'binary'
    response.headers['Cache-Control'] = 'no-cache'
    self.response_body = csv_text
  end

  show do
    if submission.proposed_updates
      panel 'Proposed Updates' do
        attributes_table_for submission do
          submission.proposed_updates.keys.each do |k|
            row k do
              submission.proposed_updates[k]
            end
          end
        end
      end
    end

    tabs do
      tab :details do
        attributes_table(*(default_attribute_table_rows - [:proposed_updates]))
      end

      tab :comments do
        active_admin_comments
      end

      tab :feedback do
        panel 'Feedback' do
          table_for submission.feedback.order('created_at DESC') do
            column(:rating) do |f|
              status_tag f.human_rating, status_for_rating(f.rating)
            end
            column :comments
          end
        end
      end

      tab :email_notifications do
        panel 'E-mail Notifications' do
          table_for submission.sent_notifications.order('created_at DESC') do
            column(:kind) { |submission| submission.kind.titleize }
            column :recipient_email
            column 'Sent At', :created_at
          end
        end
      end

      tab :changelog do
        panel 'Recent Updates' do
          table_for submission.versions do
            column 'Modified at' do |v|
              v.created_at.to_s :long
            end
            column 'User' do |v|
              if user = User.where(id: v.whodunnit).first
                link_to user.name, admin_user_path(user)
              else
                'Unknown'
              end
            end
            column 'View' do |v|
              link_to 'View', version: v.index
            end
          end
        end
      end
    end
  end

  # Accept proposed session changes
  action_item :accept_updates, only: :show do
    if submission.proposed_updates
      link_to 'Accept updates',
              accept_update_admin_submission_path(submission),
              method: :post
    end
  end

  member_action :accept_update, method: :post do
    submission = Submission.find(params[:id])
    submission.promote_updates!
    redirect_to admin_submission_path(submission)
  end

  # State machine actions
  action_item :place_on_hold, only: :show do
    unless submission.on_hold?
      link_to 'Place on hold',
              place_on_hold_admin_submission_path(submission),
              method: :post
    end
  end

  member_action :place_on_hold, method: :post do
    submission = Submission.find(params[:id])
    submission.place_on_hold!
    redirect_to admin_submission_path(submission)
  end

  action_item :open_for_voting, only: %i[edit show] do
    unless submission.open_for_voting?
      link_to 'Open for voting',
              open_for_voting_admin_submission_path(submission),
              method: :post
    end
  end

  member_action :open_for_voting, method: :post do
    submission = Submission.find(params[:id])
    submission.open_for_voting!
    redirect_to admin_submission_path(submission)
  end

  batch_action :open_for_voting do |submission_ids|
    Submission.find(submission_ids).each(&:open_for_voting!)
    redirect_to admin_submissions_path
  end

  action_item :accept, only: %i[edit show] do
    if submission.open_for_voting?
      link_to 'Accept',
              accept_admin_submission_path(submission),
              method: :post
    end
  end

  member_action :accept, method: :post do
    submission = Submission.find(params[:id])
    submission.accept!
    redirect_to admin_submission_path(submission)
  end

  batch_action :accept do |submission_ids|
    Submission.find(submission_ids).each(&:accept!)
    redirect_to admin_submissions_path
  end

  action_item :confirm, only: %i[edit show] do
    if submission.accepted?
      link_to 'Confirm',
              confirm_admin_submission_path(submission),
              method: :post
    end
  end

  member_action :confirm, method: :post do
    submission = Submission.find(params[:id])
    submission.confirm!
    redirect_to admin_submission_path(submission)
  end

  batch_action :confirm do |submission_ids|
    Submission.find(submission_ids).each(&:confirm!)
    redirect_to admin_submissions_path
  end

  action_item :withdraw, only: %i[edit show] do
    link_to 'Withdraw',
            withdraw_admin_submission_path(submission),
            method: :post
  end

  member_action :withdraw, method: :post do
    submission = Submission.find(params[:id])
    submission.withdraw!
    redirect_to admin_submission_path(submission)
  end

  batch_action :withdraw do |submission_ids|
    Submission.find(submission_ids).each(&:withdraw!)
    redirect_to admin_submissions_path
  end

  action_item :reject, only: %i[edit show] do
    if submission.open_for_voting?
      link_to 'Reject',
              reject_admin_submission_path(submission),
              method: :post
    end
  end

  member_action :reject, method: :post do
    submission = Submission.find(params[:id])
    submission.reject!
    redirect_to admin_submission_path(submission)
  end

  batch_action :reject do |submission_ids|
    Submission.find(submission_ids).each(&:reject!)
    redirect_to admin_submissions_path
  end

  member_action :waitlist, method: :post do
    submission = Submission.find(params[:id])
    submission.waitlist!
    redirect_to admin_submission_path(submission)
  end

  action_item :waitlist, only: %i[edit show] do
    if submission.open_for_voting?
      link_to 'Waitlist',
              waitlist_admin_submission_path(submission),
              method: :post
    end
  end

  batch_action :waitlist do |submission_ids|
    Submission.find(submission_ids).each(&:waitlist!)
    redirect_to admin_submissions_path
  end

  member_action :confirm_venue, method: :post do
    submission = Submission.find(params[:id])
    submission.confirm_venue!
    redirect_to admin_submission_path(submission)
  end

  action_item :confirm_venue, only: %i[edit show] do
    if submission.confirmed?
      link_to 'Confirm Venue',
              confirm_venue_admin_submission_path(submission),
              method: :post
    end
  end

  batch_action :confirm_venue do |submission_ids|
    Submission.find(submission_ids).each(&:confirm_venue!)
    redirect_to admin_submissions_path
  end

  member_action :send_venue_match_email, method: :post do
    submission = Submission.find(params[:id])
    submission.send_venue_match_email!
    flash[:notice] = 'Email sent!'
    redirect_to admin_submission_path(submission)
  end

  batch_action :send_venue_match_email do |submission_ids|
    Submission.find(submission_ids).each(&:send_venue_match_email!)
    redirect_to admin_submissions_path
  end

  member_action :send_accept_email, method: :post do
    submission = Submission.find(params[:id])
    submission.send_accept_email!
    flash[:notice] = 'Email sent!'
    redirect_to admin_submission_path(submission)
  end

  batch_action :send_accept_email, confirm: 'Are you sure?' do |submission_ids|
    Submission.find(submission_ids).each(&:send_accept_email!)
    redirect_to admin_submissions_path
  end

  member_action :send_reject_email, method: :post do
    submission = Submission.find(params[:id])
    submission.send_reject_email!
    flash[:notice] = 'Email sent!'
    redirect_to admin_submission_path(submission)
  end

  batch_action :send_reject_email, confirm: 'Are you sure?' do |submission_ids|
    Submission.find(submission_ids).each(&:send_reject_email!)
    redirect_to admin_submissions_path
  end

  member_action :send_waitlist_email, method: :post do
    submission = Submission.find(params[:id])
    submission.send_waitlist_email!
    flash[:notice] = 'Email sent!'
    redirect_to admin_submission_path(submission)
  end

  batch_action :send_waitlist_email, confirm: 'Are you sure?' do |submission_ids|
    Submission.find(submission_ids).each(&:send_waitlist_email!)
    redirect_to admin_submissions_path
  end

  # Hooks
  after_build do |submission|
    submission.submitter ||= current_user
  end
end
