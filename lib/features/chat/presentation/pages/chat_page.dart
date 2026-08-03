import 'package:flutter/material.dart';
import 'package:flutter_rag_ai/core/services/api_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final TextEditingController controller =
      TextEditingController();

  List<Map<String, String>> messages = [];

  bool loading = false;

  Future<void> sendMessage() async {

    if (controller.text.trim().isEmpty) return;

    String question = controller.text;

    setState(() {
      messages.add({
        "role": "user",
        "text": question,
      });
      loading = true;
    });

    controller.clear();

    try {

      String answer =
          await ApiService.askQuestion(question);

      setState(() {

        messages.add({
          "role": "bot",
          "text": answer,
        });

        loading = false;

      });

    } catch (e) {

      setState(() {

        messages.add({
          "role": "bot",
          "text": "Error: $e",
        });

        loading = false;

      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Chat with PDF"),
      ),

      body: Column(

        children: [

          Expanded(

            child: ListView.builder(

              itemCount: messages.length,

              itemBuilder: (context, index) {

                bool isUser =
                    messages[index]["role"] == "user";

                return Align(

                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  child: Container(

                    margin: const EdgeInsets.all(8),

                    padding: const EdgeInsets.all(12),

                    decoration: BoxDecoration(

                      color: isUser
                          ? Colors.blue
                          : Colors.grey.shade300,

                      borderRadius:
                          BorderRadius.circular(12),

                    ),

                    child: Text(

                      messages[index]["text"]!,

                      style: TextStyle(

                        color: isUser
                            ? Colors.white
                            : Colors.black,

                      ),

                    ),

                  ),

                );

              },

            ),

          ),

          if (loading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

          Row(

            children: [

              Expanded(

                child: Padding(

                  padding: const EdgeInsets.all(8),

                  child: TextField(

                    controller: controller,

                    decoration: const InputDecoration(
                      hintText: "Ask anything...",
                      border: OutlineInputBorder(),
                    ),

                  ),

                ),

              ),

              IconButton(
                onPressed: sendMessage,
                icon: const Icon(Icons.send),
              ),

            ],

          )

        ],

      ),

    );

  }

}