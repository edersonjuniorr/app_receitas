import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart'; // Importe seu provider de favoritos aqui
import 'home_screen.dart'; // Importe a tela HomeScreen aqui

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém a instância do FavoritesProvider
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6D4C41), // Cor de fundo do AppBar
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white), // Ícone de casa
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Centraliza os elementos
          children: [
            Spacer(), // Espaço para alinhar com o ícone de casa à esquerda
            Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
            SizedBox(width: 3),
            Text(
              'Meus Favoritos',
              style: TextStyle(
                color: Color(0xFFF5F5F5), // Cor do texto do AppBar
                fontSize: 24,
                fontWeight: FontWeight.bold, // Texto em negrito
              ),
            ),
            SizedBox(width: 3),
            Icon(Icons.restaurant_menu, color: Colors.white, size: 24),
            Spacer(), // Espaço para alinhar com o ícone de casa à direita
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white), // Ícone de informação
              onPressed: () {
                // Snackbar com estilo polido e visualmente agradável
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Esta página é onde serão salvas suas receitas favoritas pesquisadas pelo app.',
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
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF5F5F5), // Cor de fundo da página
      body: ListView.builder(
        itemCount: favoritesProvider.favorites.length,
        itemBuilder: (context, index) {
          final favoriteRecipe = favoritesProvider.favorites[index];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0), // Margin maior entre os containers
            padding: EdgeInsets.all(16.0), // Padding maior dentro do container
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5), // Cor de fundo do bloco de receita
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFF6D4C41), width: 1.0), // Borda
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Receita\n.......', // Delimitador
                  style: TextStyle(
                    color: Color(0xFF6D4C41),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  favoriteRecipe, // Nome da receita
                  style: TextStyle(
                    color: Color(0xFF6D4C41),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
