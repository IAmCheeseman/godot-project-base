extends Node
class_name ShadowGenerator

## Generates a shadow.
static func generate(width: int) -> ImageTexture:
	var image = Image.new()
	image.create(width + 2, 3, false, Image.FORMAT_RGBA8)
	
	image.fill(Color(0, 0, 0, 0.5))
	image.set_pixel(0,       0, Color.TRANSPARENT)
	image.set_pixel(width+1, 0, Color.TRANSPARENT)
	image.set_pixel(0,       2, Color.TRANSPARENT)
	image.set_pixel(width+1, 2, Color.TRANSPARENT)
	
	return ImageTexture.create_from_image(image)
