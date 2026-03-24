/// A utility class for parsing deep link paths and extracting parameters.
///
/// This class uses regular expressions to match URL patterns and capture
/// dynamic segments identified by a colon (e.g., `:id`).
class LinkParser {
  // This class is not meant to be instantiated.
  LinkParser._();

  /// Parses an [actualPath] against a [pattern] and extracts dynamic parameters.
  ///
  /// Example:
  /// ```dart
  /// final params = LinkParser.parse('/product/:id', '/product/123');
  /// print(params?['id']); // Output: 123
  /// ```
  ///
  /// Returns a [Map] of parameter names to their values if the path matches,
  /// otherwise returns `null`.
  static Map<String, String>? parse(String pattern, String actualPath) {
    // Convert named parameters (e.g., :id) into Regex capture groups
    final String regExpPattern = pattern.replaceAllMapped(
      RegExp(r':([a-zA-Z0-9]+)'),
      (match) => '(?<${match[1]}>[^/]+)',
    );

    try {
      final RegExp regExp = RegExp('^$regExpPattern\$');
      final RegExpMatch? match = regExp.firstMatch(actualPath);

      if (match != null) {
        final Map<String, String> params = <String, String>{};
        for (final String name in match.groupNames) {
          params[name] = match.namedGroup(name) ?? '';
        }
        return params;
      }
    } catch (e) {
      // Return null if regex compilation fails or other errors occur
      return null;
    }
    
    return null;
  }
}