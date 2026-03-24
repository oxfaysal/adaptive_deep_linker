library adaptive_deep_linker;

import 'package:flutter/material.dart';
import 'src/core/link_parser.dart';
import 'src/models/route_handler.dart';

export 'src/models/route_handler.dart';

/// The core class for managing deep links in a Flutter application.
/// 
/// [AdaptiveDeepLinker] intercepts route settings and matches them against
/// a list of predefined [AdaptiveRoute] configurations.
class AdaptiveDeepLinker {
  /// A list of routes that the linker will attempt to match.
  final List<AdaptiveRoute> routes;

  /// A widget to display if no route matches the requested path.
  final Widget? fallbackPage;

  /// Creates an [AdaptiveDeepLinker] instance.
  /// 
  /// Requires a list of [routes] and an optional [fallbackPage].
  const AdaptiveDeepLinker({
    required this.routes,
    this.fallbackPage,
  });

  /// A handler to be used in [MaterialApp.onGenerateRoute].
  /// 
  /// This method iterates through the [routes] and returns a [MaterialPageRoute]
  /// if a match is found using [LinkParser].
  Route<dynamic>? handleRoute(RouteSettings settings) {
    final String path = settings.name ?? '/';

    for (final AdaptiveRoute route in routes) {
      final Map<String, String>? params = LinkParser.parse(route.path, path);
      
      if (params != null) {
        return MaterialPageRoute<dynamic>(
          settings: settings,
          builder: (BuildContext context) => route.builder(params),
        );
      }
    }

    // Return fallback page if no match is found
    if (fallbackPage != null) {
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) => fallbackPage!,
      );
    }
    
    return null;
  }

  /// Navigates to a specific [url] using the existing navigator.
  /// 
  /// This is useful for handling external links or manual navigation 
  /// via string URLs.
  static void navigateTo(BuildContext context, String url) {
    try {
      final Uri uri = Uri.parse(url);
      // Handles both path and optional query parameters
      Navigator.pushNamed(context, uri.path);
    } catch (e) {
      debugPrint('AdaptiveDeepLinker Error: Invalid URL - $url');
    }
  }
}