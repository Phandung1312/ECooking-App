# Base source flutter

Base source flutter

## Getting Started

This project is Base source flutter.

### Prerequisites
Make sure you have the following tools installed:
- Clone `.env.example` file with 3 env (`.env` for dev, `.env-stg` for staging, `.env-prod` for production)
- Add file keystore to `{project}/android` path with 3 env (`dev.keystore` for dev, `staging.keystore` for staging, `production.keystore` for production)
- Clone `android/key.properties.example` and rename to `key.properties` (Please contact email `anhxtanh1411998@gmail.com` or admin to get information in this file.)
- Run `flutter pub get` to install the dependencies
- Run `dart run build_runner build --delete-conflicting-outputs --verbose` in auto generator

### Run the app
Using Visual Studio Code:
- Press `Shift + Cmd + D` to open the debug panel, select the run mode and then click the play button to run the app
- You can change the run environment by editing the `--flavor` flag in `.vscode/launch.json` file
Using Android Studio:
- Select the run mode and then click the play button to run the app
- You can change the run environment by editing the flavor field in the run script
Using terminal:
- Run `flutter run --flavor=dev` to run the app in development environment.
- Run `flutter run --flavor=staging` to run the app in staging environment.
- Run `flutter run --flavor=production` to run the app in production environment.

### When adding a new translated text

- Add the translated text to `lib/core/languages/translations/<langualge>.json`

- Run this script to generate the translation keys

```bash
flutter pub run easy_localization:generate \
  -f keys \
  -S lib/core/languages/translations \
  -O lib/core/languages \
  -o translation_keys.g.dart
```

### When adding new page

- Run this script to activate `mason_cli` (if you haven't done it before)

```bash
flutter pub global activate mason_cli
mason get
```

- Run this script to generate a new page with basic bloc

```bash
mason make bloc_page
```

