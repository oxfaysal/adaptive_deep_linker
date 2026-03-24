<div align="center">
  <img src="assets/banner.png" alt="Adaptive Deep Linker Banner" width="50%">
  <h1>🔗 Adaptive Deep Linker</h1>

  <a href="https://pub.dev/packages/adaptive_deep_linker" style="display: inline-block;">
    <img src="https://img.shields.io/pub/v/adaptive_deep_linker?color=blue" alt="Pub Version">
  </a>
  <a href="https://opensource.org/licenses/MIT" style="display: inline-block;">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT">
  </a>
  <a href="https://oxfaysal.github.io" style="display: inline-block;">
    <img src="https://img.shields.io/badge/Maintained%20by-LoomixDev-blueviolet" alt="LoomixDev">
  </a>

  <br>
  
  <p style="max-width: 600px;">
    <p>A lightweight, highly adaptive deep linking solution for Flutter. <code>adaptive_deep_linker</code> simplifies URL parsing, dynamic parameter extraction, and automates native configurations for Android and iOS with a single CLI command.</p>
  </p>
</div>

<br>


---

<br>

## ✨ Features

* 🚀 **One-Line Routing:** Map complex URL patterns to widgets effortlessly.
* 🧠 **Smart Dynamic Parsing:** Automatically extract parameters (like :id, :slug, or :username) from paths.
* 🛠️ **Automation CLI:** Setup AndroidManifest.xml and Info.plist in seconds using dart run.
* 🛡️ **Type-Safe & Lightweight:** Built with zero external dependencies to keep your app fast.
* 🚦 **Fallback Handling:** Custom 404/NotFound page support out of the box.


<br>


## 📦 Getting Started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
    adaptive_deep_linker: ^1.0.0
```

Then run:

```bash
flutter pub get
```


<br>

## 🛠️ Automated Native Setup (The Magic!)

Stop manually editing XML and Plist files. Configure your `Android and iOS` projects with one command:

```bash
dart run adaptive_deep_linker:setup yourdomain.com
```

* **Android:** Automatically adds the required `<intent-filter>` to your manifest.

* **iOS:** Enables `FlutterDeepLinkingEnabled` and configures `CFBundleURLTypes` in your `Info.plist`.



<br>


## 🚀 Usage

#### 1. Define Your Routes

Set up your `AdaptiveDeepLinker` instance with the desired paths:

```dart
final linker = AdaptiveDeepLinker(
  routes: [
    AdaptiveRoute(
      path: '/',
      builder: (params) => const HomeScreen(),
    ),
    AdaptiveRoute(
      path: '/product/:id',
      builder: (params) => ProductDetails(id: params['id']!),
    ),
  ],
  fallbackPage: const NotFoundPage(),
);
```


#### 2. Connect to MaterialApp

Plug the linker into your app's `onGenerateRoute`:


```dart
MaterialApp(
  onGenerateRoute: linker.handleRoute,
  // ... other properties
);
```

<br>

## 📖 Advanced Usage

#### Manual Navigation
You can also navigate using string URLs manually:

```dart
AdaptiveDeepLinker.navigateTo(context, 'https://yourdomain.com/product/505');
```


<br>

## 🤝 Contributing
Found a `bug` or want to `add` a new font?

* Fork the Project.

* Create your Feature Branch (git checkout -b feature/update).

* Commit your Changes (git commit -m 'Add new update').

* Push to the Branch (git push origin feature/update).

* Open a Pull Request.


<br>

## 📧 Contact & Support

If you have any questions, feedback, or run into issues while using `adaptive_deep_linker`, feel free to reach out:

* **Email:** [loomixdev@gmail.com](mailto:loomixdev@gmail.com)
* **GitHub:** [https://github.com/oxfaysal](https://github.com/oxfaysal)
* **Facebook:** [https://facebook.com/0xfaysal](https://facebook.com/0xfaysal)

I'm happy to help you with any improvements or fixes!


<br>

---

<p align="center">
  <img src="https://img.shields.io/badge/Developed%20with-❤️-black?style=for-the-badge" alt="Developed with love">
  <br>
  <b>Maintained by <a href="https://github.com/oxfaysal">Faysal (LoomixDev)</a></b>
</p>
