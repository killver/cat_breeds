import 'package:pets_breeds/core/error/exceptions.dart';
import 'package:pets_breeds/data/models/breed_model.dart';
import 'package:pets_breeds/data/sources/breed_remote_data_source.dart';

class BreedRepository {
  final BreedRemoteDataSource remoteDataSource;

  BreedRepository({required this.remoteDataSource});

  Future<List<BreedModel>> getBreeds(int limit, int page, String search) async {
    try {
      final breeds = await remoteDataSource.fetchBreeds(limit, page, search);
      return breeds;
    } on ServerException {
      throw ServerException();
    } on NetworkException {
      throw NetworkException();
    } catch (e) {
      throw UnexpectedException();
    }
  }
}
