# Cálculo Trivial

> Learn calculus as a journey, not as a sequence of formulas.

Cálculo Trivial is an Android-first educational app built with Flutter. It helps students strengthen their mathematical foundations, study calculus progressively, practice with focused exercise sessions, and track their learning in one continuous experience.

The app is currently in active development and was created for the RevenueCat Shipaton 2026. Its interface is presently available in Brazilian Portuguese.

## Why it exists

Calculus is often one of the first major barriers faced by students in science, technology, engineering, and mathematics. Many learners reach the subject with gaps in algebra, equations, or functions, making a formula-first approach frustrating and ineffective.

Cálculo Trivial turns that process into a structured learning journey by combining:

- progressive lessons;
- focused practice and challenges;
- measurable progress;
- rewards and content unlocking;
- a foundation that can later support adaptive learning and AI-assisted explanations.

## Current experience

The project currently includes:

- email and password authentication;
- an initial diagnostic flow;
- a student dashboard;
- a progressive learning path;
- lessons covering mathematical foundations and introductory calculus;
- multiple-choice exercise sessions;
- result, reward, and content-unlocking flows;
- XP and virtual gold;
- cloud-synchronized user progress;
- performance statistics;
- profile and account settings;
- Premium access control powered by RevenueCat;
- account deletion and password recovery;
- offline-friendly access to already available core content.

Current learning areas include fundamental algebra, equations and inequalities, functions, limits, and derivatives. The content and question bank continue to be reviewed and expanded.

## Exercise and progression rules

Exercise sessions are designed to measure understanding instead of repeated guessing:

- each session contains 10 questions selected from a larger topic pool;
- an incorrect answer is recorded and the student advances to the next question;
- the passing score is 80% or higher;
- XP, gold, and new content are granted only after passing;
- a failed attempt does not unlock the next lesson;
- retries use different questions whenever the available pool allows it;
- the result screen reports correct and incorrect answers separately.

## Free and Premium experience

The free experience is intended to provide a useful path through essential foundations and introductory content. Premium access is designed for expanded learning paths, advanced practice, detailed statistics, and future adaptive-learning features.

RevenueCat manages entitlement checks, paywall presentation, purchase restoration, and Premium state. During development, purchases use the RevenueCat Test Store. Production builds must use the public Android SDK key from a real Google Play configuration.

## Technology stack

- **Flutter and Dart** — cross-platform application development;
- **Material 3** — interface foundation;
- **Firebase Authentication** — account creation, login, password recovery, and account deletion;
- **Cloud Firestore** — per-user progress synchronization;
- **Firebase App Check** — backend abuse protection with Play Integrity on Android;
- **Shared Preferences** — local persistence and offline-friendly state;
- **RevenueCat** — Premium entitlements, paywalls, and purchase restoration.

## Project structure

```text
lib/
├── features/          Feature-oriented screens and flows
├── shared/data/       Learning and exercise data
├── shared/services/   Firebase and RevenueCat integrations
├── shared/state/      Application progress and shared state
├── shared/theme/      Colors, typography, and spacing
└── shared/widgets/    Reusable interface components
```

## Getting started

### Requirements

- Flutter SDK compatible with the project's `pubspec.yaml`;
- Android Studio and the Android SDK;
- an Android device or emulator;
- a Firebase project if you want to run your own backend configuration.

### Install and analyze

```bash
git clone https://github.com/LucasZion01/Calcivium.git
cd Calcivium
flutter pub get
flutter analyze
```

### Run without purchases

```bash
flutter run
```

When no RevenueCat key is provided, the free experience remains available and Premium features stay locked.

### Run with the RevenueCat Test Store

```bash
flutter run --dart-define=REVENUECAT_API_KEY=YOUR_PUBLIC_TEST_STORE_KEY
```

Use only a public RevenueCat SDK key in the client. Never commit secret keys, service-account credentials, passwords, or signing files. A Test Store key is for development builds only and must not be included in a production release.

## Firebase configuration

The repository contains the client-side Firebase configuration required by FlutterFire. Contributors who want to connect a separate Firebase project can generate their own configuration with:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Firestore access is restricted to the authenticated user's own document tree. App Check is integrated to support Play Integrity in Android production builds and a debug provider during local development.

## Android release signing

Release credentials are intentionally excluded from the repository. Create your own upload keystore and local `android/key.properties` file before producing a signed release. Both the keystore and properties file must remain private and are ignored by Git.

Build commands:

```bash
flutter build apk --release
flutter build appbundle --release
```

A production build that enables purchases must be built with the public Android RevenueCat SDK key associated with the Google Play app configuration.

## Quality checks

Before opening a pull request or preparing a release, run:

```bash
dart format lib
flutter analyze
flutter test
```

The Android release target is API level 36.

## Privacy and security

The project follows several baseline protections:

- authenticated users can access only their own Firestore data;
- App Check supports validation of requests to Firebase resources;
- account deletion is available from the app;
- release signing material is kept outside version control;
- RevenueCat secret keys are never stored in the client;
- the public privacy policy is available at [calculo-trivial-app-646bb.web.app](https://calculo-trivial-app-646bb.web.app).

Security issues should be reported privately to [support.calculotrivial@gmail.com](mailto:support.calculotrivial@gmail.com). Please do not publish sensitive vulnerability details in a public issue before a fix is available.

## Roadmap

Planned expansions include:

- Calculus II and multivariable calculus;
- linear algebra and vectors;
- vector-valued functions;
- probability and statistics;
- numerical methods;
- ordinary differential equations;
- solid mechanics and fluid mechanics;
- richer lessons with videos and selected reading material;
- adaptive review and AI-assisted tutoring;
- accessibility, localization, and broader platform support.

## Shipaton 2026

Cálculo Trivial is being prepared for the RevenueCat Shipaton 2026. The project emphasizes a working educational experience, meaningful RevenueCat integration, transparent open-source development, and a clear path from mathematical foundations to advanced study.

## Contributing

Issues and pull requests are welcome. Before contributing, please run the quality checks above and avoid committing generated build artifacts, credentials, API secrets, keystores, or local configuration files.

## License

The source code is licensed under the [Apache License 2.0](LICENSE).

The license does not grant permission to use the Cálculo Trivial name, logo, or other brand assets as an endorsement of a derived product.

## Contact

- Support and security: [support.calculotrivial@gmail.com](mailto:support.calculotrivial@gmail.com)
- Privacy policy: [https://calculo-trivial-app-646bb.web.app](https://calculo-trivial-app-646bb.web.app)
