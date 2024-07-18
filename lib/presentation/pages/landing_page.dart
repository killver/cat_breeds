import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pets_breeds/presentation/providers/breed_provider.dart';
import 'package:pets_breeds/presentation/widgets/breed_card.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController _searchBreed = TextEditingController();
  ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BreedProvider>(context, listen: false);
      provider.fetchBreeds('init');
    });
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchBreed.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final provider = Provider.of<BreedProvider>(context, listen: false);
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !provider.isFetchingMore) {
      provider.fetchMoreBreeds('scroll', search: _searchQuery);
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final provider = Provider.of<BreedProvider>(context, listen: false);
      if (_searchQuery.isEmpty && provider.breeds.length >= 10) {
        _scrollController.addListener(_scrollListener);
      } else {
        _scrollController.removeListener(_scrollListener);
      }
      provider.fetchBreeds('Search timer', search: _searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CAT BREEDS'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: TextField(
                controller: _searchBreed,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search breed',
                    suffix: _searchQuery.isNotEmpty
                        ? IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchBreed.clear();
                                _searchQuery = '';
                                _scrollController.addListener(_scrollListener);
                              });
                              Provider.of<BreedProvider>(context, listen: false)
                                  .fetchBreeds('clear btn');
                            },
                          )
                        : const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                  _onSearchChanged();
                },
              ),
            ),
            Expanded(
              child:
                  Consumer<BreedProvider>(builder: (context, provider, child) {
                if (provider.isLoading ||
                    (!provider.isLoading &&
                        _searchQuery.isNotEmpty &&
                        _debounce?.isActive != null &&
                        _debounce?.isActive == true)) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.breeds.isEmpty) {
                  return const Center(
                    child: Text(
                      'No breeds found.',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                    controller: _scrollController,
                    itemCount: provider.breeds.length,
                    itemBuilder: (context, index) {
                      final breed = provider.breeds[index];
                      return BreedCard(breed: breed);
                    });
              }),
            ),
            if (Provider.of<BreedProvider>(context).isFetchingMore)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ));
  }
}
