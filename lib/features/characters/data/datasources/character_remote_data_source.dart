import '../../../../core/network/api_client.dart';
import '../../../../core/network/endpoints.dart';
import '../models/character_model.dart';
import 'character_local_data_source.dart';

class CharacterRemoteDataSource {
  final ApiClient apiClient;
  final CharacterLocalDataSource localDataSource;

  CharacterRemoteDataSource(this.apiClient, this.localDataSource);

  Future<List<CharacterModel>> fetchCharacters({int page = 1}) async {
    try {
      final response =
          await apiClient.get('${ApiEndpoints.characters}?page=$page');
      if (response.statusCode == 200) {
        final characters = (response.data['results'] as List)
            .map((json) => CharacterModel.fromJson(json))
            .toList();
        await localDataSource.cacheCharacters(page, characters);
        return characters;
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      return await localDataSource.getCachedCharacters(page);
    }
  }
}
