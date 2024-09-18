# ToPWR

![ToPWR file cover](/assets/png/topwr_header.png)

## 🇵🇱

ToPWR to aplikacja mobilna stworzona przez studentów dla studentów Politechniki Wrocławskiej. Licznik dni do sesji, mapka kampusu, informacje o dziekanatach, kółkach naukowych i licznik wolnych miejsc parkingowych na żywo - wszystko, co trzeba w jednym miejscu. Life made easy. 🚀

ToPWR to efekt naszych doświadczeń i pomysłów, którymi chcielibyśmy się podzielić z innymi studentami. Bo przecież każdy z nas zaczynał od zera, więc dlaczego by nie stworzyć czegoś, co ułatwiłoby życie na uczelni? Zależało nam, żeby każdy student miał w kieszeni takiego kumpla, co go wspiera i pomaga ogarnąć to wszystko. Bo studia to nie tylko nauka, to też odkrywanie, poznawanie, czasem trochę gubienie się i to jest w porządku.

## 🇬🇧

ToPWR is a mobile application created by students for students of Wrocław University of Science and Technology. A countdown to exams, a campus map, information about dean's offices, student science clubs and live free parking places counter – everything you need in one place. Life made easy. 🚀

ToPWR is the result of our experiences and ideas that we want to share with other students. After all, each of us started from scratch, so why not create something that would make university life easier? We wanted every student to have a friend in their pocket, supporting and helping them manage everything. Because university is not just about studying; it's also about discovering, meeting new people, sometimes getting a little lost, and that's okay.

## Projects history

It was initially created by KN Solvro members in native mobile technologies (Android & iOS) and Strapi backend back in 2022 (v0.5.1 was released in 3.10.2022).

Now we're redesigning and remaking it with fascinating new features in Flutter and Directus CMS, and we're coming close to our first release 🚀. Stay tuned 😎.

## Current team

- [@AleksaZakrzewska](https://github.com/AleksaZakrzewska) - Project Manager
- [@simon-the-shark](https://github.com/simon-the-shark) - Flutter Techlead
- [@mikolaj-jalocha](https://github.com/mikolaj-jalocha) - Flutter Developer
- [@gry-mar](https://github.com/gry-mar) - Flutter Developer, UI/UX Designer
- [@kamilfedio](https://github.com/kamilfedio) - Flutter Developer

We're using many UI/UX/graphic designs and assets made by [@domkakromka](https://github.com/domkakromka), [@AniaM727](https://github.com/AniaM727)

Read more at: https://solvro.pwr.edu.pl/portfolio/to-pwr

## Technologies used

- Flutter
- Riverpod
- Freezed
- graphql_codegen
- Dio
- google_maps_flutter
- fl_chart
- wiredash
- lottie

## Links

- https://www.figma.com/file/33ofdGYbBzWvDi2MabxIc1/ToPWR-(imported)?type=design&node-id=2%3A2091&mode=design&t=qILflhzpbN8xW8F6-1
- https://solvro.pwr.edu.pl/blog/fix-flutter-android-back-btn

  
## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Solvro/mobile-topwr&type=Date)](https://star-history.com/#Solvro/mobile-topwr&Date)


# Development

Recommended flutter version: `Channel stable, 3.24.0`

1. ### Google maps API key

   There are google maps api keys already defined, but their usage is restricted on Google Maps Panel to specific package/bundle ids.
   Web key is restricted for localhost usage only


   #### Android only

   On Android, apart from package id, restriction is for specific signing key's SHA1 fingerprints. So to test on Android, your debug signing key's fingerprint must be added to the maps panel. (Contact [@simon-the-shark](https://github.com/simon-the-shark) to include yours)

   _Instuctions pasted from Google Maps Panel:_
   #### How to get your debug key fingerprint?
   For Linux or macOS:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
   For Windows:
   ```bash
   keytool -list -v -keystore "%USERPROFILE%\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
   ```

   #### How to get your release certificate fingerprint?
   ```bash
   keytool -list -v -keystore your_keystore_name -alias your_alias_name
   ```



   

   

3. ### Before you start, you need to add `.env` file to project's root with appropriate content:

```bash
API_URL="https://<our-server-url>/graphql"
ASSETS_URL="https://<our-server-url>/assets"
IPARKING_URL="https://<secret parking's source>.pl"
WIREDASH_ID="<...>" # can be left empty
WIREDASH_SECRET="<...>" # can be left empty
```
If you need our server url please write us an email [kn.solvro@pwr.edu.pl](mailto:kn.solvro@pwr.edu.pl) or contact us via our [website](https://solvro.pwr.edu.pl/contact/)

3. ### For SVG files optimization we use `svg_optimizer` (which uses SVGO under the hood) that's why before you start you need to install [Node.js](https://nodejs.org/en/download/package-manager) and [SVGO optimization tool](https://svgo.dev/docs/introduction/) on your machine

3.  ### Code generation
    Some of app's dependecies utilize code generation feature and generated files **are not currently included** to control version and this github repository, so before building, running or developing application, it's crucial to run code generation (to generate all needed files) in terminal with:

- For one-time generation:

```zsh
dart run build_runner build
```

**OR**

- For watch mode and continous necessary rebuilds after every change to connected files (usufull for development):

```zsh
dart run build_runner watch
```

- If something doesn't build correctly, this might help:

```zsh
dart run build_runner build -d
```

4.  ### It's now possible to run or build the app in the usual way
    _Rebuilds are necessary after any updates or changes to affected files (`watch` command does it for you)_
   - Either with your IDE or
   - from Terminal:
   ```bash
   flutter run
   ```

5. **[OPTIONAL]** If you operate on many Flutter versions, I reccomend to you `fvm` Flutter version manager: https://fvm.app/
```bash
fvm dart run build_runner watch
fvm flutter run
// etc...
```
    

### Additional notes:

1. App's custom theme usage instructions: https://github.com/Solvro/topwr-mobile/tree/main/lib/theme
2. Introductions to internationalizing flutter apps (making them available in different languages): https://docs.flutter.dev/ui/accessibility-and-internationalization/internationalization
3. Api helper module instructions: https://github.com/Solvro/topwr-mobile/tree/main/lib/api_base
4. We use `flutter_gen` for generating asset paths: https://pub.dev/packages/flutter_gen 
5. For unified names read and follow: [taxonomy.md](./taxonomy.md)
6. For navigation we use `auto_route`, docs here: https://pub.dev/packages/auto_route
7. For SVG files optimization we use `svg_optimizer` (which uses SVGO under the hood), related article here: https://www.thedroidsonroids.com/blog/svg-open-source-flutter-package

# Before you push a commit
- run the linter
```bash
flutter analyze
```
- if you have any problems listed, try to autofix with
```bash
dart fix --apply
```
- run `analyze` again, if problems still persist, correct them manually. If you disagree with some of the rules, we can still discuss and adjust them. Hit me up @simon-the-shark or open an issue.
- run formatter
```bash
dart format .
```
## Github workflow
Don't worry if you've forgotten about the steps, automatic gh action will run the checks for you and notify if somthing's wrong.


## Working with git

### Github Solvro Handbook 🔥

https://docs.google.com/document/d/1Sb5lYqYLnYuecS1Essn3YwietsbuLPCTsTuW0EMpG5o/edit?usp=sharing

### SSH

Connecting to Github(Gh) repository via SSH on Windows, tutorial: https://www.youtube.com/watch?v=vExsOTgIOGw

### Building new feature

1. git checkout main -> checkout main branch
2. git pull origin main -> pull current changes from main branch
3. git fetch -> be up to date with remote branches
4. git checkout -b MOBILE-x_my_feature_branch -> x - stands for issue number; it is going to checkout and create new branch name MOBILE-x_my_feature_branch
   (... working on the feature, we are still on our branch named MOBILE-x_my_feature_branch)
5. git add . -> add all changes we have made
6. git commit -m "My changes description" -> commit made changes with proper description
7. git push origin MOBILE-x_my_feature_branch -> pushing our changes to remote branch
8. On Github we are going to make Pull Request (PR) from our remote branch

### Remarks

- Do not push directly to main branch!!! This is bad practice!
- local branch - is our branch on our computer not on the server if we do some chagnes and do checkout to diffrent branch without saving them(commiting) we might loose them, commit before checkout to different branch!
- remote branch - this is branch with our code in github's servers
- After code review which was successful, we can merge from our feature branch to main branch. After merging we should clean after ourself.

1. git branch -d MOBILE-x_my_feature_branch -> deletes our local branch
2. git push origin --delete MOBILE-x_my_feature_branch -> delete our remote branch
