import 'package:flutter/material.dart';

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
            ElevatedButton
            (onPressed: (){},
             child: Text("Upload PDF")),
          ],
        ),
      ),
    );
  }
}