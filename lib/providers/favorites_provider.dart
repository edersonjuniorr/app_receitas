import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favorites = []; // Lista de favoritos

  List<String> get favorites => _favorites; // Getter para acessar a lista de favoritos

  void addFavorite(String recipe) {
    _favorites.add(recipe); // Adiciona a receita à lista de favoritos
    notifyListeners(); // Notifica os ouvintes (consumidores) sobre a mudança
  }

  void removeFavorite(String recipe) {
    _favorites.remove(recipe); // Remove a receita da lista de favoritos
    notifyListeners(); // Notifica os ouvintes (consumidores) sobre a mudança
  }
}
