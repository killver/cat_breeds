import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

  Future<void> fetchBreeds({String search = ''}) async {
    _isLoading = true;
    notifyListeners();

    _breeds = await repository.getBreeds(_limit, _page, search);
    _isLoading = false;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> fetchMoreBreeds({String search = ''}) async {
    if (_isFetchingMore) return;

    _isFetchingMore = true;
    _page++;
    notifyListeners();

    final moreBreeds = await repository.getBreeds(_limit, _page, search);
    _breeds.addAll(moreBreeds);

    _isFetchingMore = false;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
