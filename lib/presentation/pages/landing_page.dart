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

  bool activeTimer = false;
  int startTime = 300;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<BreedProvider>(context, listen: false);
      provider.fetchBreeds();
    });
    _scrollController.addListener(() {
      final provider = Provider.of<BreedProvider>(context, listen: false);
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !provider.isFetchingMore) {
        provider.fetchMoreBreeds(search: _searchQuery);
      }
    });
  }

  void starTimerSearch() {
    const oneDecimal = Duration(milliseconds: 100);
    Timer.periodic(
        oneDecimal,
        (Timer timer) => setState(() {
              if (startTime < 100) {
                timer.cancel();

                Provider.of<BreedProvider>(context, listen: false)
                    .fetchBreeds(search: _searchQuery);
                setState(() {
                  startTime = 300;
                  activeTimer = false;
                });
              } else {
                startTime = startTime - 100;
              }
            }));
    setState(() {
      activeTimer = true;
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
                    suffix: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                  if (!activeTimer) {
                    starTimerSearch();
                  } else {
                    setState(() {
                      startTime = 300;
                    });
                  }
                },
              ),
            ),
            Expanded(
              child:
                  Consumer<BreedProvider>(builder: (context, provider, child) {
                if (provider.isLoading && provider.breeds.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.breeds.isEmpty) {
                  return const Center(
                    child: Text('No breeds found.'),
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
