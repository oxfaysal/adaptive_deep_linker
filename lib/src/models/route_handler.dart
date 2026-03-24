import 'package:flutter/material.dart';

/// A function signature for building a widget based on extracted path parameters.
/// 
/// The [params] map contains dynamic segments from the URL (e.g., {'id': '123'}).
typedef AdaptiveRouteBuilder = Widget Function(Map<String, String> params);

/// A model representing a single deep link route configuration.
/// 
/// Each [AdaptiveRoute] maps a URL pattern [path] to a specific [builder] function.
@immutable
class AdaptiveRoute {
  /// The URL pattern to match, e.g., '/product/:id'.
  final String path;

  /// The widget builder that will be executed if the [path] matches.
  final AdaptiveRouteBuilder builder;

  /// Creates an [AdaptiveRoute] with a required [path] and [builder].
  /// 
  /// Example:
  /// ```dart
  /// AdaptiveRoute(
  ///   path: '/user/:name',
  ///   builder: (params) => ProfilePage(name: params['name']!),
  /// );
  /// ```
  const AdaptiveRoute({
    required this.path,
    required this.builder,
  });
}