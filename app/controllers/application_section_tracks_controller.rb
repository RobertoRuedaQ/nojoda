class ApplicationSectionTracksController < ApplicationController
	def index
		@application_section_track = ApplicationSectionTrack.lumniStart(params,current_company, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		contactApplicationSectionTrack = @application_section_track.lumniSave(params,current_user, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		lumniClose(@application_section_track,contactApplicationSectionTrack)
	end

	def new
		@application_section_track = ApplicationSectionTrack.lumniStart(params,current_company, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		contactApplicationSectionTrack = @application_section_track.lumniSave(params,current_user, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		lumniClose(@application_section_track,contactApplicationSectionTrack)
	end

	def create
		@application_section_track = ApplicationSectionTrack.lumniStart(params,current_company, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		contactApplicationSectionTrack = @application_section_track.lumniSave(params,current_user, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		lumniClose(@application_section_track,contactApplicationSectionTrack)
	end

	def edit
		@application_section_track = ApplicationSectionTrack.lumniStart(params,current_company, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		contactApplicationSectionTrack = @application_section_track.lumniSave(params,current_user, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		lumniClose(@application_section_track,contactApplicationSectionTrack)
	end

	def update
		@application_section_track = ApplicationSectionTrack.lumniStart(params,current_company, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		contactApplicationSectionTrack = @application_section_track.lumniSave(params,current_user, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		lumniClose(@application_section_track,contactApplicationSectionTrack)
	end
	def destroy
		@application_section_track = ApplicationSectionTrack.lumniStart(params,current_company, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		contactApplicationSectionTrack = @application_section_track.lumniSave(params,current_user, list: current_user.template('ApplicationSectionTrack','application_section_tracks',current_user))
		lumniClose(@cluster,contactApplicationSectionTrack)
	end
end