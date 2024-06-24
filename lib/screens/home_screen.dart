import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'ingredients_scan_screen.dart';
import 'favorites_screen.dart';

void main() => runApp(RecipeApp());

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF6D4C41),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFFC107),
        ),
        fontFamily: 'Montserrat',
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
         leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name != '/') {
              Navigator.pushNamed(context, '/');
            }
          },
        ),
        backgroundColor: Color(0xFF6D4C41),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Receitas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.restaurant_menu, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            }, 
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          CuisineCard('Italiana', 'https://i.imgur.com/YWQQncf.jpg', IngredientsScanScreen(cuisine: 'Culinária Italiana')),
          CuisineCard('Chinesa', 'https://i.imgur.com/h3UEVFm.jpg', IngredientsScanScreen(cuisine: 'Culinária Chinesa')),
          CuisineCard('Japonesa', 'https://images.pexels.com/photos/357756/pexels-photo-357756.jpeg', IngredientsScanScreen(cuisine: 'Culinária Japonesa')),
          CuisineCard('Francesa', 'https://i.imgur.com/6f37JcN.jpg', IngredientsScanScreen(cuisine: 'Culinária Francesa')),
          CuisineCard('Brasileira', 'https://i.imgur.com/LiZRvul.jpg', IngredientsScanScreen(cuisine: 'Culinária Brasileira')),
          CuisineCard('Tailandesa', 'https://i.imgur.com/xgexj2M.jpg', IngredientsScanScreen(cuisine: 'Culinária Tailandesa')),
        ],
      ),
    );
  }
}

class CuisineCard extends StatefulWidget {
  final String cuisine;
  final String imageUrl;
  final Widget destinationScreen;

  CuisineCard(this.cuisine, this.imageUrl, this.destinationScreen);

  @override
  _CuisineCardState createState() => _CuisineCardState();
}

class _CuisineCardState extends State<CuisineCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => widget.destinationScreen),
          );
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(vertical: 5),
          height: isHovered ? 160 : 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: widget.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Center(
                child: Text(
                  widget.cuisine,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
