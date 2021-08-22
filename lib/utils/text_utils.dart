class TextUtils {
  /// capitalize each words in the string
  String capitalizeAll(String text) {
    if (text != null) {
      return text.trim().toLowerCase().split(' ').map((word) {
        String leftText =
            (word.length > 1) ? word.substring(1, word.length) : '';
        return word.length > 0 ? word[0].toUpperCase() + leftText : '';
      }).join(' ');
    }
    return null;
  }

  /// capitalize words after '.'s and 'i's in the string.
  static String capitalize(String text) {
    if (text != null) {
      return text
          .trim()
          .split(' ')
          .map(
            (word) => word.length == 1 && word == 'i'
                ? word[0].toUpperCase()
                : word.length > 0
                    ? word
                    : '',
          )
          .join(' ')
          .split('. ')
          .map((sentence) =>
              sentence[0].toUpperCase() +
              sentence.substring(1, sentence.length))
          .join('. ')
          .split('? ')
          .map((sentence) =>
              sentence[0].toUpperCase() +
              sentence.substring(1, sentence.length))
          .join('? ')
          .split('! ')
          .map((sentence) =>
              sentence[0].toUpperCase() +
              sentence.substring(1, sentence.length))
          .join('! ');
    }
    return null;
  }
}
