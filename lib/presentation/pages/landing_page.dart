import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final breedProvider = Provider.of<BreedProvider>(context);

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
                  breedProvider.filterBreedsByName(value);
                },
              ),
            ),
            Expanded(
              child:
                  Consumer<BreedProvider>(builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.filteredBreeds.isEmpty) {
                  return const Center(
                    child: Text('No breeds found.'),
                  );
                }

                return ListView.builder(
                    itemCount: provider.filteredBreeds.length,
                    itemBuilder: (context, index) {
                      final breed = provider.filteredBreeds[index];
                      return BreedCard(breed: breed);
                    });
              }),
            )
          ],
        ));
  }
}
