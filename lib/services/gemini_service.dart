import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey;

  GeminiService() : apiKey = dotenv.env['GEMINI_API_KEY']!;

  Future<String> analyzeIngredients(String ingredients, String cuisine) async {
    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);

    try {
      final response = await model.generateContent([
        Content.text("""Você é um provedor de receitas, um chef, e sua missão é identificar ingredientes, de acordo com a cozinha selecionada, que podem ser preparadas com o ingrediente do texto digitado e dar dicas de preparo.
Cite o título da receita, ingredientes utilizados, separando os que possam ser alergicos ou não, e em seguida: o tempo e o modo de preparo da receita.
Responda as orientações sobre as receitas em tópicos separados conforme a receita distinta. Gere apenas uma receita. Caso não receba nenhum ingrediente avise. Culinária: $cuisine."""),
        Content.text(ingredients),
      ]);

    String filteredResponse = response.text?.replaceAll(RegExp(r'[*]'), '').replaceAll(RegExp(r'##'), '') ?? "No response";
    return filteredResponse;
    } catch (e) {
      throw Exception('Erro ao chamar a API do Gemini: $e');
    }
  }
}
