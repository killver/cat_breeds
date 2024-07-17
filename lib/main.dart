import 'package:flutter/material.dart';
import 'package:pets_breeds/core/network/api_client.dart';
import 'package:pets_breeds/data/repositories/breed_repository.dart';
import 'package:pets_breeds/data/sources/breed_remote_data_source.dart';
import 'package:pets_breeds/presentation/pages/splash_page.dart';
import 'package:pets_breeds/presentation/providers/breed_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => BreedProvider(
                repository: BreedRepository(
                    remoteDataSource: BreedRemoteDataSource(
                        apiClient: ApiClient(client: http.Client()))))
              ..fetchBreeds(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cat Breeds App',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF282828),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xFF64C4A9)),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SplashPage(),
        ));
  }
}
