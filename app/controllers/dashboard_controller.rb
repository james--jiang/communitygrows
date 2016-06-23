class DashboardController < ActionController::Base
    layout "base"
    before_filter :authenticate_user!
    
    def index
        # updating calendar
        @curr_calendar = Calendar.all[0] #Calendar.first rather than .all
        if @curr_calendar
            @curr_calendar_id = @curr_calendar.html
        end
        @announcement_list = Announcement.where(committee_type: "dashboard").order(created_at: :DESC)
        @subcomittee_announcements_list = Announcement.where.not(committee_type: "dashboard").order(created_at: :DESC)
        @events = Event.all
    end
end
