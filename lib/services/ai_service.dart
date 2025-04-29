import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AIService {
  static final String _apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  static const String _endpoint = 'https://api.openai.com/v1/chat/completions';

  static Future<String> validarTextoComAI(String prompt) async {
    if (_apiKey.isEmpty) {
      throw Exception('API Key não configurada.');
    }

    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "gpt-4o",
        "messages": [
          {"role": "system", "content": "Você é um verificador de perfis de fãs de esports."},
          {"role": "user", "content": prompt}
        ],
        "temperature": 0.2,
        "max_tokens": 200,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final text = data['choices'][0]['message']['content'];
      return text.trim();
    } else {
      print('Erro na resposta da IA: ${response.body}');
      throw Exception('Erro ao validar com IA: ${response.statusCode}');
    }
  }
}
