import 'package:flutter/material.dart';
import 'package:adaptive_deep_linker/adaptive_deep_linker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AdaptiveDeepLinker linker;

  @override
  void initState() {
    super.initState();

    // ১. রাউটগুলো কনফিগার করা
    linker = AdaptiveDeepLinker(
      routes: [
        AdaptiveRoute(
          path: '/',
          builder: (params) => const HomeScreen(),
        ),
        AdaptiveRoute(
          path: '/product/:id',
          builder: (params) => ProductDetailsScreen(id: params['id'] ?? '0'),
        ),
        AdaptiveRoute(
          path: '/profile/:username',
          builder: (params) =>
              ProfileScreen(user: params['username'] ?? 'Guest'),
        ),
      ],
      fallbackPage: const NotFoundScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Deep Linker Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // ২. লিঙ্কারকে MaterialApp এ সেট করা
      onGenerateRoute: linker.handleRoute,
      initialRoute: '/',
    );
  }
}

// --- স্যাম্পল স্ক্রিনগুলো নিচে ---

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoomixDev Linker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Try clicking these simulated links:'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/product/505'),
              child: const Text('Go to Product 505'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/profile/oxfaysal'),
              child: const Text('View @oxfaysal Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final String id;
  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Center(
          child: Text('Viewing Product ID: $id',
              style: const TextStyle(fontSize: 24))),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final String user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Center(
          child: Text('Welcome, $user!', style: const TextStyle(fontSize: 24))),
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('404 - Page Not Found')));
  }
}
