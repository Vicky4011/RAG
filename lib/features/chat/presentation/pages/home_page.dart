import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_rag_ai/core/services/file_picker_service.dart';

FilePickerService FilePicker=FilePickerService();
class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("RAG AI Assistant"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Ask Questions from your PDF documents"),
            SizedBox(height: 20,),
            ElevatedButton
            (onPressed: ()async{
              final file = await FilePicker.pickPdf();
              if (file != null) {
              print(file.name);
              }
            },
             child: Text("Upload PDF")),
          ],
        ),
      ),
    );
  }
}