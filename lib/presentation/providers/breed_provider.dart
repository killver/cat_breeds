import 'package:flutter/material.dart';
import 'package:pets_breeds/data/models/breed_model.dart';
import 'package:pets_breeds/data/repositories/breed_repository.dart';

class BreedProvider with ChangeNotifier {
  final BreedRepository repository;

  BreedProvider({required this.repository});

  List<BreedModel> _breeds = [];
  bool _isLoading = false;
  bool _isFetchingMore = false;
  int _page = 0;
  int _limit = 10;

  List<BreedModel> get breeds => _breeds;

  bool get isLoading => _isLoading;

  bool get isFetchingMore => _isFetchingMore;

  Future<void> fetchBreeds(String from, {String search = ''}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _page = 0;
      _breeds = await repository.getBreeds(_limit, _page, search);
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreBreeds(String from, {String search = ''}) async {
    if (_isFetchingMore || _isLoading) return;

    _isFetchingMore = true;
    _page++;
    notifyListeners();

    try {
      final moreBreeds = await repository.getBreeds(_limit, _page, search);
      _breeds.addAll(moreBreeds);
    } catch (e) {
      print("Error: $e");
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }
}
