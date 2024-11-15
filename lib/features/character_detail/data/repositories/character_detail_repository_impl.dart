import '../datasources/character_detail_remote_data_source.dart';
import '../../domain/repositories/character_detail_repository.dart';
import '../../domain/entities/character_detail.dart';

class CharacterDetailRepositoryImpl implements CharacterDetailRepository {
  final CharacterDetailRemoteDataSource remoteDataSource;

  CharacterDetailRepositoryImpl(this.remoteDataSource);

  @override
  Future<CharacterDetail> getCharacterDetail(int id) async {
    return await remoteDataSource.fetchCharacterDetail(id);
  }
}
