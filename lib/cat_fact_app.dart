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

 final Map<String, String> languages = {
    '1': 'English',
    '2': 'Spanish',
    '3': 'French',
    '4': 'German',
    '5': 'Russian',
  };

  String selectedLanguage = 'English';

  Future<void> selectLanguage() async {
    print('\nSelect fact language:');
    languages.forEach((key, value) {
      print('$key. $value');
    });
    
    String? input;
    do {
      stdout.write('Your choice (1-${languages.length}): ');
      input = stdin.readLineSync()?.trim();
    } while (input == null || !languages.containsKey(input));
    
    selectedLanguage = languages[input]!;
    print('Selected language: $selectedLanguage\n');
  }

  
  Future<void> run() async {
    print('Welcome to Cat Facts App!');
    final fact = await fetchRandomCatFact();
    print('\nCat Fact: ${fact.fact}');
  }
}