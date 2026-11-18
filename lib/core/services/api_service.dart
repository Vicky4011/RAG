import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://rag-backend-bay.vercel.app";

  static Future<String> askQuestion(String question) async {
    final response = await http.get(
      Uri.parse(
        "$baseUrl/ask?question=${Uri.encodeComponent(question)}",
      ),
    );

    if (response.statusCode == 200) {
      return response.body;
    }

    throw Exception("Failed to get answer");
  }
}