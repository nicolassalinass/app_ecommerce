import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadBox extends StatefulWidget {
  final Function(XFile? file) onImageSelected;

  const ImageUploadBox({super.key, required this.onImageSelected});

  @override
  State<ImageUploadBox> createState() => _ImageUploadBoxState();
}

class _ImageUploadBoxState extends State<ImageUploadBox> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _selectedImage = image);
      widget.onImageSelected(image);
    }
  }

  Future<void> pickFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() => _selectedImage = image);
      widget.onImageSelected(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surface,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(
        //   color: Colors.grey.shade200,
        //   width: 1,
        //   style: BorderStyle.solid,
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.upload_file, size: 40, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            "Selecciona la imágen",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          Text(
            "PNG, JPG",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
          const SizedBox(height: 12),

          // Botón
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.grey,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => _bottomSheet(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text("Seleccionar Archivo"),
          ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.white),
            title: const Text("Galería", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              pickFromGallery();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.white),
            title: const Text("Cámara", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              pickFromCamera();
            },
          ),
        ],
      ),
    );
  }
}
