## Philosophy

- Code is organic, and changes frequently, so as a team we should be aligned on how it grows, and is maintained. The base architecture should be built keeping [SOLID](https://www.digitalocean.com/community/conceptual-articles/s-o-l-i-d-the-first-five-principles-of-object-oriented-design) in mind. Allowing for flexibility when needed, but also dependable. It should be easy for newer people to ramp up, because no one likes to spend a month just to start contributing. Everyone has ownership of the codebase. Take a look [here](https://www.tatvasoft.com/outsourcing/2022/05/software-development-principles.html) for more direction!
- All ideas are welcomed, and no one person should override the consensus. Change is inevitable, so be flexible to change! Make sure to keep constant communication with your teammates, and any large sweeping changes should have an RFC in Confluence

## Getting Started With Flutter

If this is your first flutter project, don't worry, we will help you through it! Below are some great resources to get caught up to speed

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Architecture

Our architecture stems from [Flutter - Clean Architecture](https://github.com/guilherme-v/flutter-clean-architecture-example). We found this architecture to allow for ease of use and flexibility. You should be in good hands with it's documentation. Any changes we make that diverge from the proposed architecture should be noted here.

## Libraries and Frameworks Used

- State Management: [Flutter Riverpod](https://riverpod.dev/)
- Fonts: [Google Fonts](https://pub.dev/packages/google_fonts)
- Change App Package Name: [Name Change](https://pub.dev/packages/change_app_package_name) Allows you to change the project name through terminal instead of doing it manually. Feel free to remove it after forking!

## Style Guide

- Lint has been set to the [default](https://dart.dev/effective-dart/style) for Flutter/Dart. Feel free to make your own changes
- Naming Conventions:
  - Screens are the widgets you will display to the user and navigate to and from.
  - ScreenStates are the data that backs the Screens 
  - Notifiers are the glue connecting state change and the UseCases
  - UseCases contain the core business logic and coordinate the flow of data between the notifier and repositories
  - Repositories are in charge of doing some sort of specialty work (Network, Cache, Etc)


## How and What Do We Test?
UI Testing:
Requires the app to be running with flutter-driver in the background. Testing is being run using VSCode. Extensions that help make testing possible include:
- Dart language extension
- Flutter support extension

The flutter extension should allow you to run tests via the play button on the left in the lie number column.

To run a test, launch the app first via the launch configuration titled:
- Integration Tests: Launch App

Then, navigate to your test file and run each test via the play button. All tests in a test file can be run by clicking the play button at the start of a group.

Flutter test files do not restart the app state between each test. Meaning, a new test file needs to be created for each unrelated scenario.
For this reason, organisation of tests should include folders for each screen, with all test files contained therein.

This project follows the Page Object Model structure, with each screen having a screen file which should define all screen elements for reuse in all test files, as well as screen-specific test files.
