import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/image_info_text.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/img_thumbnail.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/img_viewer_dialog.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  ImageUploaderState createState() => ImageUploaderState();
}

class ImageUploaderState extends State<ImageUploader> {
  final List<Uint8List> _images = [];

  Future<void> _pickImages() async {
    if (_images.length >= 3) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      allowMultiple: true,
    );

    if (result != null) {
      List<Uint8List> selectedImages = result.files
          .where((file) => file.bytes != null)
          .map((file) => file.bytes!)
          .toList();

      if (_images.length + selectedImages.length > 3) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You can upload up to 3 images")),
        );
        return;
      }

      setState(() {
        _images.addAll(selectedImages);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final image = _images.removeAt(oldIndex);
      _images.insert(newIndex, image);
    });
  }

  void _showImageViewer(int initialIndex) {
    showDialog(
      context: context,
      builder: (context) => ImageViewerDialog(
        images: _images,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_images.isEmpty)
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: 409,
              height: 152,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 2),
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.transparent,
                    ),
                    child: const Center(
                      child: Icon(Icons.add, color: Colors.orange, size: 12),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Оберіть файл або перенесіть сюди",
                    style: TextStyle(color: Colors.black54, fontSize: 17),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            width: 409,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: _images.length == 3
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 10,
                    alignment: _images.length == 3
                        ? WrapAlignment.center
                        : WrapAlignment.start,
                    children: List.generate(_images.length, (index) {
                      return MouseRegion(
                        cursor: SystemMouseCursors.grab,
                        child: Draggable<int>(
                          data: index,
                          feedback: Material(
                            child: Image.memory(
                              _images[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.4,
                            child: ImageThumbnail(
                              image: _images[index],
                              isFirst: index == 0,
                              onTap: () => _showImageViewer(index),
                              onRemove: () => _removeImage(index),
                            ),
                          ),
                          child: DragTarget<int>(
                            onAccept: (oldIndex) => _onReorder(oldIndex, index),
                            builder: (context, candidateData, rejectedData) {
                              return MouseRegion(
                                cursor: candidateData.isNotEmpty
                                    ? SystemMouseCursors.grabbing
                                    : SystemMouseCursors.grab,
                                child: ImageThumbnail(
                                  image: _images[index],
                                  isFirst: index == 0,
                                  onTap: () => _showImageViewer(index),
                                  onRemove: () => _removeImage(index),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 10),
                if (_images.length < 3)
                  GestureDetector(
                    onTap: _pickImages,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: Colors.orange,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 10),
        ImageInfoText(imageCount: _images.length),
      ],
    );
  }
}
