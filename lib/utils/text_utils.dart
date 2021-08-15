class TextUtils {
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
}
