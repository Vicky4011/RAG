import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_rag_ai/core/services/file_picker_service.dart';
import 'package:flutter_rag_ai/core/services/upload_service.dart';
import 'package:flutter_rag_ai/features/chat/presentation/widgets/pdf_card.dart';

FilePickerService FilePicker=FilePickerService();
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlatformFile? selectedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("RAG AI Assistant"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Ask Questions from your PDF documents"),
              SizedBox(height: 20,),
              selectedFile == null? ElevatedButton(
                  onPressed: () async {
                    final file = await FilePicker.pickPdf();
                    if (file != null) {
                      setState(() {
                        selectedFile = file;
                      });
                     }
                    },
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
              SizedBox(height: 20,),
              if(selectedFile != null)
                ElevatedButton(
                onPressed: (){
                  print("Ready for backend upload");
                }, 
                child: Text("Continue"))
            ],
          ),
        ),
      ),
    );
  }
}