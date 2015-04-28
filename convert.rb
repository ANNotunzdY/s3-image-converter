require 'rmagick'

files = Dir["tmp/*"]

files.each do |file|
  p file
  img = Magick::Image.read(file)[0]
  img.strip!
  basename = File.basename(file,File.extname(file))
  img.write("tmp2/#{basename}.jpg") {
    self.quality = 100
  }
end
