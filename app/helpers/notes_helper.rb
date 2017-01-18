module NotesHelper
  def camera_reader(picture)
  	# controller receives base64 encoded png string. This must be decoded to ascii-8bit then 
  	# written to a tempfile before it is sent to Google Vision API
		png = Base64.decode64(picture['data:image/png;base64,'.length .. -1])
		prefix = 'photo_data'
		suffix = '.png'
		file = Tempfile.new [prefix, suffix], "#{Rails.root}/tmp", :encoding => 'ascii-8bit'
		file.write(png)
		file.rewind
		scanned_image = VISION.image(file.path).text
		file.close
		file.unlink
		return scanned_image.text
	end
end
