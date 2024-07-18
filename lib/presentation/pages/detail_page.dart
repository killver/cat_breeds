import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pets_breeds/data/models/breed_model.dart';

class DetailPage extends StatelessWidget {
  final BreedModel breed;
  const DetailPage({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(breed.name),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Flexible(
            flex: 1,
            child: breed.imageUrl != null
                ? FutureBuilder(
                    future:
                        DefaultCacheManager().getSingleFile(breed.imageUrl!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Image.file(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
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
          const SizedBox(height: 16),
          Flexible(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        breed.description,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                              text: 'Origin: ',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF64C4A9)),
                              children: [
                                TextSpan(
                                    text: breed.origin,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white))
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                              text: 'Intelligence: ',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF64C4A9)),
                              children: [
                                TextSpan(
                                    text: breed.intelligence.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white))
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                              text: 'Adaptability: ',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF64C4A9)),
                              children: [
                                TextSpan(
                                    text: breed.adaptability.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white))
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: RichText(
                          text: TextSpan(
                              text: 'Life Span: ',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF64C4A9)),
                              children: [
                                TextSpan(
                                    text: breed.lifeSpan,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white))
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ]));
  }
}
