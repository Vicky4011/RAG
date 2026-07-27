import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PdfCard extends StatelessWidget {
  final PlatformFile file;
  final VoidCallback onRemove;

  const PdfCard({
    super.key,
    required this.file,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Card(
        child: ListTile(
          leading: const Icon(
            Icons.picture_as_pdf,
            color: Colors.red,
          ),
          title: Text(file.name),
          subtitle: Text(
            "${(file.size / 1024).toStringAsFixed(2)} KB",
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
          ),
        ),
      ),
    );
  }
}