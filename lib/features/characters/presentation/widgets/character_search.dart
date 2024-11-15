import 'package:flutter/material.dart';

class CharacterSearch extends StatelessWidget {
  final String searchTerm;
  final Function(String) onChanged;

  const CharacterSearch({
    super.key,
    required this.searchTerm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIcon: const Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
