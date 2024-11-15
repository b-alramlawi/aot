import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../features/character_detail/data/datasources/character_detail_remote_data_source.dart';
import '../features/character_detail/data/repositories/character_detail_repository_impl.dart';
import '../features/character_detail/domain/repositories/character_detail_repository.dart';
import '../features/character_detail/presentation/bloc/character_detail_bloc.dart';
import '../features/characters/data/datasources/character_local_data_source.dart';
import '../features/characters/data/datasources/character_remote_data_source.dart';
import '../features/characters/data/repositories/character_repository_impl.dart';
import '../features/characters/domain/repositories/character_repository.dart';
import '../features/characters/presentation/bloc/character_bloc.dart';
import '../features/characters/presentation/bloc/character_event.dart';
import 'network/api_client.dart';

class Providers {
  static List<RepositoryProvider> getRepositories() {
    final dio = Dio();
    final apiClient = ApiClient(dio);
    final localDataSource = CharacterLocalDataSource();
    final remoteDataSource =
        CharacterRemoteDataSource(apiClient, localDataSource);
    final characterDetailRemoteDataSource =
        CharacterDetailRemoteDataSource(apiClient);
    final characterRepository = CharacterRepositoryImpl(remoteDataSource);
    final characterDetailRepository =
        CharacterDetailRepositoryImpl(characterDetailRemoteDataSource);

    return [
      RepositoryProvider<CharacterRepository>(
          create: (_) => characterRepository),
      RepositoryProvider<CharacterDetailRepository>(
          create: (_) => characterDetailRepository),
    ];
  }

  static List<BlocProvider> getBlocs() {
    return [
      BlocProvider<CharacterBloc>(
        create: (context) =>
            CharacterBloc(RepositoryProvider.of<CharacterRepository>(context))
              ..add(LoadCharacters()),
      ),
      BlocProvider<CharacterDetailBloc>(
        create: (context) => CharacterDetailBloc(
            RepositoryProvider.of<CharacterDetailRepository>(context)),
      ),
    ];
  }
}
