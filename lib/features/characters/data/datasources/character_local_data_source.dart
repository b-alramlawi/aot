import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';

class CharacterLocalDataSource {
  Future<void> cacheCharacters(
      int page, List<CharacterModel> characters) async {
    final prefs = await SharedPreferences.getInstance();
    final characterList =
        characters.map((character) => character.toJson()).toList();

    final cachedData = prefs.getString('cached_characters');
    Map<String, List<dynamic>> cachedMap;

    if (cachedData != null) {
      final decodedData = jsonDecode(cachedData);
      if (decodedData is Map) {
        cachedMap = Map<String, List<dynamic>>.from(decodedData);
      } else {
        cachedMap = {};
      }
    } else {
      cachedMap = {};
    }

    cachedMap[page.toString()] = characterList;
    prefs.setString('cached_characters', jsonEncode(cachedMap));
  }

  Future<List<CharacterModel>> getCachedCharacters(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_characters');

    if (cachedData != null) {
      final decodedData = jsonDecode(cachedData);
      if (decodedData is Map<String, dynamic>) {
        if (decodedData.containsKey(page.toString())) {
          final List<dynamic> jsonList = decodedData[page.toString()];
          return jsonList.map((json) => CharacterModel.fromJson(json)).toList();
        }
        throw Exception('No cached data found for this page');
      }
      throw Exception('Cached data is not in the expected format');
    }
    throw Exception('No cached data found');
  }
}
