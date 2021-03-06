# == Schema Information
#
# Table name: timecard_entries
#
#  id           :integer          not null, primary key
#  member_id    :integer
#  hours        :float
#  eventdate_id :integer
#  timecard_id  :integer
#  payrate      :float
#

class TimecardEntry < ActiveRecord::Base
	belongs_to :timecard

	belongs_to :member
	belongs_to :eventdate
	validates_presence_of :member_id, :eventdate_id, :hours
	validates_numericality_of :hours, :member_id
        validates_associated :member
	validates_inclusion_of :timecard_id, :in => Timecard.valid_timecards.map {|t| t.id} << nil, :message => 'is invalid'
	validate :eventdate_in_range, :check_submitted
	before_destroy :check_submitted

	attr_protected :member_id

	private
	def eventdate_in_range
		errors.add(:eventdate, 'is invalid') unless timecard.nil? or timecard.valid_eventdates.include? eventdate
	end

	def check_submitted
		return false if !timecard.nil? and timecard.submitted
	end

        public
        def gross_amount
          #TODO: I think it's a bug that payrate is not mandatory.
          (payrate and hours*payrate) or hours*member.payrate
        end
end
