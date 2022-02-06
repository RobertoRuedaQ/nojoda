module CheckObjectsHelper

	def check_object_header
		[CheckObject.human_attribute_name('label'),
		CheckObject.human_attribute_name('name'),
		CheckObject.human_attribute_name('rows'),
		CheckObject.human_attribute_name('migrate'),
		'Progress']
	end

	def check_object_rows
		temp_progress = CheckField.where(status: 'migrated').kept.group(:check_object_id).size
		temp_total = CheckField.where(status: ['migrated','pending']).kept.group(:check_object_id).size

		progress = {}
		temp_progress.each do |p|
			progress[p.first] = p.last
		end

		total = {}
		temp_total.each do |t|
			total[t.first] = t.last
		end
		@check_object.map{|row| [(link_to row.label,edit_check_object_path(row),class: 'text_primary'),
			row.name,row.rows,(row.migrate ? 'to_migrate' : 'not_migrate'),progress_bar_number(progress[row.id],total[row.id]).html_safe]}
	end

	def progress_bar_number progress, total
		percentage = (total == 0 || total.nil?) ? 100 : (progress.to_f/total.to_f * 100).round(1)

		content_tag :div, class: 'progress' do
			concat content_tag :div,percentage, class: 'progress-bar bg-success',role: 'progressbar', style: "width: #{percentage}%",aria: {valuenow: percentage, valuemin: 0,valuemax: 100}
		end
	end
end
