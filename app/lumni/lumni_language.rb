module LumniLanguage
	def languageList
		list = {}
		options = ['es','en']
		list[:language] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list
	end
end	