import 'package:app_receita/screens/ingredients_result_screen.dart';
import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class IngredientsScanScreen extends StatefulWidget {
  final String cuisine;
  IngredientsScanScreen({required this.cuisine});

  @override
  _IngredientsScanScreenState createState() => _IngredientsScanScreenState();
}

class _IngredientsScanScreenState extends State<IngredientsScanScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showLoadingDialog(BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Fundo transparente
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(                 
                  width: 246,
                  height: 150,
                  child: Padding
                  (
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Image.network('https://i.imgur.com/SkPV7Es.gif', fit: BoxFit.fill),
                  ), 
                  // Substitua 'https://example.com/cozinhando.gif' pela URL do seu GIF
                ),
                SizedBox(height: 16.0),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Gerando receita",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Opacity(
                          opacity: _animation.value,
                          child: Text(
                            "...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _hideLoadingDialog(BuildContext context) {
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context); // Pop the loading dialog
  }

  void _showInfoDialog(BuildContext context) {
    String infoText = '';

    // Definir o texto de informação baseado no tipo de cuisine selecionado
    switch (widget.cuisine) {
      case 'Culinária Italiana':
        infoText =
            'A culinária italiana é uma das mais famosas do mundo, conhecida por suas massas e molhos deliciosos.';
        break;
      case 'Culinária Chinesa':
        infoText =
            'A culinária chinesa é diversificada, com pratos que variam de região para região, incluindo arroz, macarrão, legumes e carne.';
        break;
      case 'Culinária Japonesa':
        infoText =
            'A culinária japonesa é conhecida por sua simplicidade e frescor, com destaque para sushi, sashimi e tempurá.';
        break;
      case 'Culinária Francesa':
        infoText =
            'A culinária francesa é sofisticada e renomada, com pratos clássicos como coq au vin, foie gras e croissants.';
        break;
      case 'Culinária Brasileira':
        infoText =
            'A culinária brasileira é diversificada, com influências indígenas, africanas e europeias, destacando-se pratos como feijoada, moqueca e acarajé.';
        break;
      case 'Culinária Tailandesa':
        infoText =
            'A culinária tailandesa é conhecida por seu equilíbrio de sabores, misturando doce, salgado, azedo e picante, com pratos como pad thai e curry.';
        break;
      default:
        infoText = 'Informações não disponíveis para esta culinária.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF6D4C41), // Cor de fundo da dialog
          title: Text(
            '${widget.cuisine}',
            style: TextStyle(
              color: Color(0xFFF5F5F5), // Cor do título em negrito
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            infoText,
            style: TextStyle(color: Color(0xFFF5F5F5)), // Cor do texto
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFF5F5F5)), // Borda ao redor do botão
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Fechar',
                  style: TextStyle(
                    color: Color(0xFFF5F5F5), // Cor do texto do botão
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5), // Cor de fundo da tela
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            if (ModalRoute.of(context)?.settings.name != '/') {
              Navigator.pushNamed(context, '/');
            }
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant_menu, color: Colors.white),
                  SizedBox(width: 2), // Espaço entre o ícone e o texto
                  Text(
                    '${widget.cuisine}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(width: 2), // Espaço entre o texto e o ícone
                  Icon(Icons.restaurant_menu, color: Colors.white),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.info, color: Colors.white),
              onPressed: () {
                _showInfoDialog(context);
              },
            ),
          ],
        ),
        backgroundColor: Color(0xFF6D4C41),
      ),
      body: IgnorePointer(
        ignoring: _isLoading, // Impede cliques na tela se estiver carregando
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: Image.network('https://i.imgur.com/WUqWTWV.gif', fit: BoxFit.cover),
                    // Substitua 'https://example.com/cozinhando.gif' pela URL do seu GIF
                  ),
                  SizedBox(height: 30.0),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Insira os ingredientes',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF6D4C41)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color(0xFF6D4C41), width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      String ingredients = _controller.text;

                      _showLoadingDialog(context); // Mostra o dialogo de carregamento

                      try {
                        String result =
                            await GeminiService().analyzeIngredients(ingredients, widget.cuisine);
                        _hideLoadingDialog(context); // Es
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IngredientsResultScreen(result: result),
                          ),
                        );

                        // Mostrar o SnackBar ajustado
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                    content: Text(
                      'Receita gerada com sucesso.',
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
                      } catch (e) {
                        _hideLoadingDialog(context); // Esconde o dialogo de carregamento em caso de erro

                        ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                    content: Text(
                      'Erro ao contatar API Gemini $e.',
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
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey; // Cor de fundo quando desabilitado
                        }
                        return Color(0xFF6D4C41); // Cor de fundo padrão
                      }),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.white; // Cor do texto quando desabilitado
                        }
                        return Colors.white; // Cor do texto padrão
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    child: Text('Analisar Ingredientes'),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
