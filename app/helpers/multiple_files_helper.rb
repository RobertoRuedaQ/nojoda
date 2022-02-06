module MultipleFilesHelper



	def lumni_multiple_files object,f,options,config={}

		'<form action="/upload" class="dropzone needsclick my-4" id="dropzone-demo">
		  <div class="dz-message needsclick">
		    Drop files here or click to upload
		    <span class="note needsclick">(This is just a demo dropzone. Selected files are <strong>not</strong> actually uploaded.)</span>
		  </div>
		  <div class="fallback">
		    <input name="file" type="file" multiple >
		  </div>
		</form>'.html_safe
	end




end
