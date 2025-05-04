import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/image_info_text.dart';
import 'package:flutter_application_1/src/ui/widgets/product_creation/img_thumbnail.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/show_full_screen_slider.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key});

  @override
  ImageUploaderState createState() => ImageUploaderState();
}

class ImageUploaderState extends State<ImageUploader> {
  final List<Uint8List> _images = [];

  List<Uint8List> get images => _images;
  String? _errorText;

  Future<void> _pickImages() async {
    if (_images.length >= 5) return;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
      allowMultiple: true,
    );

    if (result != null) {
      final List<Uint8List> validNewImages = [];

      for (var file in result.files) {
        if (file.bytes == null) continue;

        if (file.size > 12 * 1024 * 1024) {
          setState(() {
            _errorText = 'Зображення надто великого розміру';
          });
          return;
        }

        final ext = file.extension?.toLowerCase();
        if (!(ext == 'png' || ext == 'jpg' || ext == 'jpeg' || ext == 'heic')) {
          setState(() {
            _errorText = 'Невідповідний формат зображення';
          });
          return;
        }

        validNewImages.add(file.bytes!);
      }

      final int availableSlots = 5 - _images.length;
      final List<Uint8List> imagesToAdd =
          validNewImages.take(availableSlots).toList();

      setState(() {
        _errorText = null;
        _images.addAll(imagesToAdd);
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
      builder: (_) => FullScreenImageSlider(
        images: _images
            .map((bytes) => MemoryImage(bytes) as ImageProvider)
            .toList(),
        initialIndex: initialIndex,
      ),
    );
  }

  void clearImages() {
    setState(() {
      _images.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 781,
      height: 236,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (_images.isEmpty)
            GestureDetector(
              onTap: _pickImages,
              child: Container(
                width: double.infinity,
                height: 212,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFCF7),
                  border: Border.all(color: const Color(0xFFFFC66B), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_upload_outlined,
                        size: 24, color: Colors.black54),
                    const SizedBox(height: 8),
                    const Text(
                      "Макс. 12 MB, у форматах PNG, JPG, HEIC",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _pickImages,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9F2C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        elevation: 0,
                        fixedSize: const Size(200, 40),
                      ),
                      child: const Text(
                        "Вибрати файл",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Container(
              padding: const EdgeInsets.all(10),
              height: 212,
              decoration: BoxDecoration(
                color: const Color(0xFFFEFCF7),
                border: Border.all(color: const Color(0xFFFFC66B), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: _images.length == 5
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_images.length, (index) {
                          return MouseRegion(
                            cursor: SystemMouseCursors.grab,
                            child: Draggable<int>(
                              data: index,
                              feedback: Material(
                                child: SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.memory(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              childWhenDragging: Opacity(
                                opacity: 0.4,
                                child: SizedBox(
                                  width: 150,
                                  height: 150,
                                  child: Image.memory(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              child: DragTarget<int>(
                                onAccept: (oldIndex) =>
                                    _onReorder(oldIndex, index),
                                builder:
                                    (context, candidateData, rejectedData) {
                                  return MouseRegion(
                                    cursor: candidateData.isNotEmpty
                                        ? SystemMouseCursors.grabbing
                                        : SystemMouseCursors.grab,
                                    child: SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: ImageThumbnail(
                                        image: _images[index],
                                        isFirst: index == 0,
                                        onTap: () => _showImageViewer(index),
                                        onRemove: () => _removeImage(index),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  if (_images.length < 5)
                    GestureDetector(
                      onTap: _pickImages,
                      child: Container(
                        width: 150,
                        height: 150,
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
          Align(
            alignment: Alignment.bottomRight,
            child: ImageInfoText(
                imageCount: _images.length, errorText: _errorText),
          ),
        ],
      ),
    );
  }
}
