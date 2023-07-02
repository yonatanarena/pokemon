import 'package:flutter/material.dart';
import 'package:pokemon/pokemon_detail.dart';
import 'package:pokemon/resources/api_services/pokemon_api_service.dart';
import 'package:pokemon/resources/exceptions.dart';

import 'app_colors.dart';
import 'models/pokemon.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins",
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _searchLoading = false;

  final TextEditingController _txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tfGrey,
      body: LayoutBuilder(builder: (context, constraints) {
        double margin = constraints.maxWidth > 700
            ? MediaQuery.of(context).size.width * 0.20
            : 8.0;

        return Stack(
          children: [
            Opacity(
              opacity: 0.05,
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/pokemon_back_1.png",
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: margin),
                    child: Text(
                      'What Pokémon are you\nlooking for',
                      style: TextStyle(
                          color: AppColors.darkBlue,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Container(
                    padding: const EdgeInsets.all(3),
                    margin: EdgeInsets.symmetric(horizontal: margin),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            onFieldSubmitted: (val) {
                              if (_txtController.text.isNotEmpty) {
                                _searchPokemon(
                                    _txtController.text.toLowerCase());
                              }
                            },
                            controller: _txtController,
                            style: TextStyle(color: AppColors.darkBlue),
                            cursorColor: AppColors.darkBlue,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                suffixIcon: !_searchLoading
                                    ? IconButton(
                                        onPressed: () {
                                          if (_txtController.text.isNotEmpty) {
                                            _searchPokemon(_txtController.text
                                                .toLowerCase());
                                          }
                                        },
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        splashRadius: 16,
                                        icon: Icon(
                                          Icons.search,
                                          color: AppColors.darkBlue,
                                          // color: AppColors.darkGrey,
                                        ))
                                    : SizedBox(
                                        width: 8,
                                        height: 8,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.darkBlue,
                                          ),
                                        ),
                                      )),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  _searchPokemon(String name) async {
    setState(() {
      _searchLoading = true;
    });
    try {
      var pokemon = await PokemonService().getPokemonByName(name);

      if (!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (ctx) {
        return PokemonDetailScreen(
          pokemon: pokemon,
        );
      }));
    } catch (e) {
      if (e is AppException) {
        if (e is NotFoundException) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No pokemon by that name")));
          return;
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    } finally {
      setState(() {
        _searchLoading = false;
      });
    }
    return;
  }

  @override
  void dispose() {
    _txtController.dispose();
    super.dispose();
  }
}
