class SeedPhraseModel {
  SeedPhraseModel(String? phrase) : phrase = phrase ?? '' {
    _words = null;
  }

  SeedPhraseModel.fromWords(List<String> list) {
    phrase = list.join(' ');
    _words = list;
  }

  SeedPhraseModel.empty() : this(null);

  late final String phrase;
  late final List<String> words = _words ?? phrase.split(' ');

  late final wordsCount = words.length;

  late final isEmpty = phrase.isEmpty;
  late final isNotEmpty = !isEmpty;

  late final List<String>? _words;
}
