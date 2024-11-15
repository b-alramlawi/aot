import '../../../../core/network/api_client.dart';
import '../../../../core/network/endpoints.dart';
import '../models/character_detail_model.dart';

class CharacterDetailRemoteDataSource {
  final ApiClient apiClient;

  CharacterDetailRemoteDataSource(this.apiClient);

  Future<CharacterDetailModel> fetchCharacterDetail(int id) async {
    final response = await apiClient.get('${ApiEndpoints.characters}/$id');
    if (response.statusCode == 200) {
      return CharacterDetailModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load character details');
    }
  }
}
