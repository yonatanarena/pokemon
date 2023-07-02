import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon.dart';
import 'app_colors.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailScreen({super.key,required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tfGrey,
      appBar: AppBar(
        backgroundColor: AppColors.tfGrey,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "${pokemon.name}",
          style: TextStyle(
            color: AppColors.darkBlue,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.darkBlue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColors.darkBlue,
                  image: DecorationImage(image: NetworkImage(pokemon.imageUrl??"",
                    scale: 0.9
                  )

                  )
              ),
              // child: ,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Moves",
              style: TextStyle(
                color: AppColors.darkBlue,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            if(pokemon.moves!=null && pokemon.moves!.isNotEmpty)
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      title: Text("\u2022 ${pokemon.moves![index]}",
                          style: TextStyle(
                            color: AppColors.darkBlue,
                          )),
                    );
                  },
                  itemCount: pokemon.moves!.length,
                  shrinkWrap: true,

                ),
              )
          ],
        ),
      ),
    );
  }
}
