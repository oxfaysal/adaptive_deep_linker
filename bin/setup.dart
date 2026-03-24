// ignore_for_file: avoid_print

import 'dart:io';

/// The entry point for the setup CLI tool.
///
/// This script automates the configuration of AndroidManifest.xml and Info.plist
/// for deep linking. Usage: `dart run adaptive_deep_linker:setup <your-domain>`
void main(List<String> args) {
  print('🚀 Adaptive Deep Linker Setup Starting...');

  if (args.isEmpty) {
    print('❌ Error: Please provide your domain.');
    print('Example: dart run adaptive_deep_linker:setup loomix.dev');
    return;
  }

  final String domain = args[0];
  const String scheme = 'https'; // Default secure scheme

  _setupAndroid(domain, scheme);
  _setupIOS(domain);
}

/// Configures the [AndroidManifest.xml] file for Android deep linking.
///
/// It injects an intent-filter with [domain] and [scheme] into the primary activity.
void _setupAndroid(String domain, String scheme) {
  const String manifestPath = 'android/app/src/main/AndroidManifest.xml';
  final File file = File(manifestPath);

  if (!file.existsSync()) {
    print('⚠️ Android: AndroidManifest.xml not found. Skipping Android setup.');
    return;
  }

  try {
    String content = file.readAsStringSync();
    final String intentFilter = '''
        <intent-filter android:autoVerify="true">
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="$scheme" android:host="$domain" />
        </intent-filter>''';

    if (content.contains(domain)) {
      print('ℹ️ Android: Domain $domain already configured.');
    } else if (content.contains('</activity>')) {
      // Inject before the closing activity tag
      content = content.replaceFirst(
        '</activity>',
        '$intentFilter\n        </activity>',
      );
      file.writeAsStringSync(content);
      print('✅ Android: Intent filter added successfully.');
    } else {
      print('❌ Android: Could not find </activity> tag in manifest.');
    }
  } catch (e) {
    print('❌ Android: An error occurred: $e');
  }
}

/// Configures the [Info.plist] file for iOS deep linking.
///
/// Enables [FlutterDeepLinkingEnabled] and sets up [CFBundleURLTypes].
void _setupIOS(String domain) {
  const String plistPath = 'ios/Runner/Info.plist';
  final File file = File(plistPath);

  if (!file.existsSync()) {
    print('⚠️ iOS: Info.plist not found. Skipping iOS setup.');
    return;
  }

  try {
    String content = file.readAsStringSync();

    final String iosScheme = '''
    <key>FlutterDeepLinkingEnabled</key>
    <true/>
    <key>CFBundleURLTypes</key>
    <array>
      <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLName</key>
        <string>$domain</string>
        <key>CFBundleURLSchemes</key>
        <array>
          <string>https</string>
        </array>
      </dict>
    </array>''';

    if (content.contains('FlutterDeepLinkingEnabled')) {
      print('ℹ️ iOS: Deep linking already enabled in Info.plist.');
    } else if (content.contains('<dict>')) {
      // Inject after the first dictionary opening
      content = content.replaceFirst('<dict>', '<dict>\n$iosScheme');
      file.writeAsStringSync(content);
      print('✅ iOS: Info.plist updated successfully.');
    } else {
      print('❌ iOS: Could not find <dict> tag in Info.plist.');
    }
  } catch (e) {
    print('❌ iOS: An error occurred: $e');
  }

  print('\n🔔 IMPORTANT FOR iOS:');
  print('To complete Universal Links setup, please add "applinks:$domain"');
  print('in Xcode -> Signing & Capabilities -> Associated Domains.');
}
