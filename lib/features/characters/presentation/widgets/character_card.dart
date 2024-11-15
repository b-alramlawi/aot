import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isList;
  final VoidCallback onTap;

  const CharacterCard({
    super.key,
    required this.character,
    this.isList = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: isList
            ? const EdgeInsets.symmetric(vertical: 8, horizontal: 16)
            : const EdgeInsets.all(8.0),
        elevation: 4,
        child: isList
            ? Row(
                children: [
                  _characterImage(),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        character.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        '${character.gender}, Age: ${character.age}, ${character.occupation}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  _characterImage(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      character.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      character.occupation,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _characterImage() {
    final height = isList ? 100.0 : 120.0;
    final width = isList ? 100.0 : double.infinity;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: isList
            ? const BorderRadius.horizontal(left: Radius.circular(4))
            : const BorderRadius.vertical(top: Radius.circular(4)),
      ),
      child: character.img.isEmpty
          ? const Center(child: Icon(Icons.error, size: 50))
          : CachedNetworkImage(
              imageUrl: character.img,
              placeholder: (context, url) =>
                  Image.asset('assets/images/loading.gif', fit: BoxFit.cover),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
              fit: BoxFit.cover,
            ),
    );
  }
}
