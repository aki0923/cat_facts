import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CatFact {
  final String fact;
  final int length;

  CatFact({required this.fact, required this.length});

  @override
  String toString() => fact;
}

class CatFactApp {
  Future<CatFact> fetchRandomCatFact() async {
    final response = await http.get(Uri.parse('https://catfact.ninja/fact'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return CatFact(
        fact: data['fact'],
        length: data['length'],
      );
    } else {
      throw Exception('Failed to load cat fact');
    }
  }

  Future<void> run() async {
    print('Welcome to Cat Facts App!');
    final fact = await fetchRandomCatFact();
    print('\nCat Fact: ${fact.fact}');
  }
}