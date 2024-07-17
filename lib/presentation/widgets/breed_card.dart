import 'package:flutter/material.dart';
import 'package:pets_breeds/data/models/breed_model.dart';
import 'package:pets_breeds/presentation/pages/detail_page.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class BreedCard extends StatelessWidget {
  final BreedModel breed;
  const BreedCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(breed: breed)));
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          breed.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Más...',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: breed.imageUrl != null
                          ? FutureBuilder(
                              future: DefaultCacheManager()
                                  .getSingleFile(breed.imageUrl!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    return Image.file(snapshot.data!);
                                  } else {
                                    return const Placeholder(
                                      fallbackHeight: 200,
                                    );
                                  }
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              })
                          : const Placeholder(
                              fallbackHeight: 200,
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          breed.origin,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          breed.intelligence.toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ])),
        ));
  }
}
