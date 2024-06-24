import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart'; // Importe seu provider de favoritos aqui

class IngredientsResultScreen extends StatelessWidget {
  final String result;
  final String iconUrl = 'https://i.imgur.com/x1JogUD.gif'; // URL do GIF

  IngredientsResultScreen({required this.result});

  void _showSnackBar(BuildContext context) {
    // Obtém a instância do FavoritesProvider
    final favoritesProvider = Provider.of<FavoritesProvider>(context, listen: false);

    // Adiciona a receita aos favoritos
    favoritesProvider.addFavorite(result);

    // Mostra um SnackBar informando que a receita foi salva
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
                    content: Text(
                      'Receita salva nos favoritos!',
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    backgroundColor: Color(0xFF6D4C41), // Cor de fundo do SnackBar
                    duration: Duration(seconds: 2), // Tempo de exibição
                    behavior: SnackBarBehavior.floating, // SnackBar com comportamento flutuante
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                    ),
                  ),
      
    );
  }

  // Função para formatar os cabeçalhos "Ingredientes", "Modo de Preparo", "Dicas", "Tempo de Preparo" e "Informações Adicionais"
  List<InlineSpan> formatTextWithHeaders(String text) {
    final List<String> lines = text.split('\n');
    List<InlineSpan> spans = [];

    for (String line in lines) {
      if (line.contains('Ingredientes') ||
          line.contains('Modo de Preparo') ||
          line.contains('Dicas') ||
          line.contains('Tempo de Preparo') ||
          line.contains('Informações Adicionais')) {
        spans.add(
          TextSpan(
            text: '• $line\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF6D4C41),
            ),
          ),
        );
      } else if (spans.isEmpty || spans.last is WidgetSpan) {
        spans.add(
          TextSpan(
            text: '$line\n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF6D4C41),
              fontFamily: 'Montserrat',
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: '$line\n',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF6D4C41),
              fontFamily: 'Montserrat',
            ),
          ),
        );
      }
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Cor de fundo da tela
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta de navegação padrão
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza o título e ícones
          children: [
            Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
            SizedBox(width: 3),
            Text(
              'Resultado',
              style: TextStyle(
                color: Color(0xFFF5F5F5), // Cor do texto
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            SizedBox(width: 3),
            Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
          ],
        ),
        backgroundColor: Color(0xFF6D4C41), // Cor de fundo da barra de título
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5), // Cor de fundo do bloco
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Color(0xFF6D4C41), width: 1.0), // Borda
                  ),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: formatTextWithHeaders(result),
                        ),
                      ),
                      SizedBox(height: 5.0), // Aumenta a distância entre o texto e o GIF
                      Center(
                        child: Image.network(
                          iconUrl, // URL do GIF
                          height: 200, // Altura do GIF
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Divider(
              thickness: 1.0,
              color: Color(0xFF6D4C41), // Cor da barra divisória
              height: 32.0, // Altura da barra divisória
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF6D4C41)), // Cor de fundo do botão
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white), // Cor do texto do botão
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text('Voltar'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showSnackBar(context); // Chama a função para mostrar o SnackBar
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF6D4C41)), // Cor de fundo do botão
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white), // Cor do texto do botão
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text('Salvar nos Favoritos'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
