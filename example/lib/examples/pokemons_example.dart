import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:flutter/material.dart';

/// Creating a class object.
class PokemonBook {
  PokemonBook({
    required this.urlImage,
    required this.pokemonName,
  });

  final String pokemonName;
  final String urlImage;
}

/// Simulates a background query with response a List of objects.
List<PokemonBook> pokemonBooks = [
  PokemonBook(
    urlImage: 'https://assets.pokemon.com/assets/cms2/img/pokedex/full/007.png',
    pokemonName: 'Squirtle',
  ),
  PokemonBook(
    urlImage: 'https://assets.stickpng.com/images/580b57fcd9996e24bc43c31a.png',
    pokemonName: 'Bulbasaur',
  ),
  PokemonBook(
    urlImage:
        'https://i.pinimg.com/originals/f2/95/76/f295769d9bd3c34ffc552e837f5304ae.png',
    pokemonName: 'Charmander',
  ),
];

/// Widget class example.
class PokemonsExample extends StatelessWidget {
  const PokemonsExample({
    required this.horizontalView,
    super.key,
  });

  final bool horizontalView;

  Size get heightSize => const Size.fromHeight(225);

  Size get widthSize => const Size.fromWidth(160);

  @override
  Widget build(BuildContext context) {
    /// List of all objects.
    return ListView.separated(
      /// Physics.
      physics: const BouncingScrollPhysics(),

      /// Scroll axis.
      scrollDirection: horizontalView ? Axis.horizontal : Axis.vertical,

      /// Separator of list.
      separatorBuilder: (context, index) => horizontalView
          ? const SizedBox(width: 20)
          : const SizedBox(height: 20),

      /// None clip.
      clipBehavior: Clip.none,

      /// Number of items on the list.
      itemCount: pokemonBooks.length,

      /// Item constructor.
      itemBuilder: (_, index) {
        final imagePokemonBooks = Image.network(pokemonBooks[index].urlImage);

        final headlineSmallStyle = Theme.of(context).textTheme.headlineSmall;

        final bgColorWhitewithOpacity = Colors.white.withValues(alpha: 0.8);

        /// For each object we return a widget with the data..
        return AnimatedBookWidget(
          //Size perameter
          size: horizontalView ? widthSize : heightSize,

          /// Cover parameter.
          cover: ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(10)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.red.shade300, Colors.red],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'PoKéMoN?',
                    style: headlineSmallStyle!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: bgColorWhitewithOpacity,
                    radius: 70,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.7),
                        BlendMode.modulate,
                      ),
                      child: imagePokemonBooks,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Content parameter.
          content: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade300, Colors.blue],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  pokemonBooks[index].pokemonName,
                  style: headlineSmallStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: bgColorWhitewithOpacity,
                  radius: 70,
                  child: imagePokemonBooks,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
