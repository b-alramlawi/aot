import '../../domain/entities/character_detail.dart';

abstract class CharacterDetailRepository {
  Future<CharacterDetail> getCharacterDetail(int id);
}
