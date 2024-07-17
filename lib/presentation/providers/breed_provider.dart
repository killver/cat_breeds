import 'package:flutter/material.dart';
import 'package:pets_breeds/data/models/breed_model.dart';
import 'package:pets_breeds/data/repositories/breed_repository.dart';

class BreedProvider with ChangeNotifier {
  final BreedRepository repository;

  BreedProvider({required this.repository});

  List<BreedModel> _breeds = [];
  List<BreedModel> _filteredBreeds = [];
  bool _isLoading = true;

  List<BreedModel> get breeds => _breeds;

  List<BreedModel> get filteredBreeds => _filteredBreeds;

  bool get isLoading => _isLoading;

  Future<void> fetchBreeds() async {
    _isLoading = true;
    notifyListeners();
    _breeds = await repository.getBreeds();
    _filteredBreeds = _breeds;
    _isLoading = false;
    notifyListeners();
  }

  void filterBreedsByName(String name) {
    _isLoading = true;
    if (name.isEmpty) {
      _filteredBreeds = _breeds;
    } else {
      _filteredBreeds = _breeds
          .where((breed) =>
              RegExp(name.toLowerCase()).hasMatch(breed.name.toLowerCase()))
          .toList();
    }
    _isLoading = false;
    notifyListeners();
  }
}
