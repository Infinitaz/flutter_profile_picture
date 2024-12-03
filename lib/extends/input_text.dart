class InitialName {
  static String parseName(String name, int? letterLimit) {
    // Separate each word
    var parts = name.trim().split(' '); // Split by whitespace
    var initial = '';

    // Helper function to check if a character is a valid letter
    bool isLetter(String char) {
      if (char.isEmpty) return false;
      int code = char.codeUnitAt(0);
      return (code >= 65 && code <= 90) || // A-Z
          (code >= 97 && code <= 122) || // a-z
          (code >= 192 &&
              code <=
                  687); // Letters with accents and extended Latin characters
    }

    // Handle cases where parts might be empty or letterLimit is greater than parts length
    if (parts.isNotEmpty) {
      if (letterLimit != null) {
        for (var i = 0; i < letterLimit && i < parts.length; i++) {
          if (parts[i].isNotEmpty) {
            // Extract the first valid letter from the part
            for (var rune in parts[i].runes) {
              String char = String.fromCharCode(rune);
              if (isLetter(char)) {
                initial += char;
                break; // Stop after finding the first valid letter
              }
            }
          }
        }
      } else {
        // Default case: Use the first two parts if available
        int addedLetters = 0;
        for (var part in parts) {
          if (addedLetters >= 2) break;
          for (var rune in part.runes) {
            String char = String.fromCharCode(rune);
            if (isLetter(char)) {
              initial += char;
              addedLetters++;
              break; // Stop after finding the first valid letter in each part
            }
          }
        }
      }
    }

    // Ensure at least a fallback empty string is returned
    return initial.toUpperCase();
  }
}
