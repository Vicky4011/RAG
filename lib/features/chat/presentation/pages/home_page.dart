import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rag_ai/core/services/file_picker_service.dart';
import 'package:flutter_rag_ai/core/services/upload_service.dart';
import 'package:flutter_rag_ai/features/chat/presentation/widgets/pdf_card.dart';
import 'package:flutter_rag_ai/features/chat/presentation/pages/chat_page.dart';

FilePickerService filePicker = FilePickerService();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlatformFile? selectedFile;

  final UploadService uploadService = UploadService();

  bool isLoading = false;

  Future<void> uploadPdf() async {
    if (selectedFile == null) return;

    setState(() {
      isLoading = true;
    });

    try {
      String message = await uploadService.uploadPdf(selectedFile!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => ChatPage(),
  ),
);

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Upload failed: $e"),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> pickPdf() async {
    final file = await filePicker.pickPdf();

    if (file != null) {
      setState(() {
        selectedFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RAG AI Assistant"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Ask Questions from your PDF documents",
              ),

              const SizedBox(height: 20),

              selectedFile == null
                  ? ElevatedButton(
                      onPressed: pickPdf,
                      child: const Text("Upload PDF"),
                    )
                  : PdfCard(
                      file: selectedFile!,
                      onRemove: () {
                        setState(() {
                          selectedFile = null;
                        });
                      },
                    ),

              const SizedBox(height: 20),

              if (selectedFile != null)
                ElevatedButton(
                  onPressed: isLoading ? null : uploadPdf,
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text("Continue"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}