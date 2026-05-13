@tool
extends EditorScript

const IMAGE_EXTENSIONS: Array = ["png", "jpg", "jpeg", "webp", "bmp", "tga", "svg", "exr", "hdr"]

func _run() -> void:
	var fs: EditorFileSystem = EditorInterface.get_resource_filesystem()
	var root_dir: EditorFileSystemDirectory = fs.get_filesystem()
	var image_paths: Array[String] = []

	_collect_images(root_dir, image_paths)

	print("Images Reimporter: found %d images" % image_paths.size())

	for path: String in image_paths:
		print("  Reimporting: %s" % path)

	fs.reimport_files(image_paths)

	print("Images Reimporter: done.")


func _collect_images(dir: EditorFileSystemDirectory, result: Array[String]) -> void:
	for i: int in dir.get_file_count():
		var ext: String = dir.get_file(i).get_extension().to_lower()
		if ext in IMAGE_EXTENSIONS:
			result.append(dir.get_file_path(i))

	for i: int in dir.get_subdir_count():
		_collect_images(dir.get_subdir(i), result)
