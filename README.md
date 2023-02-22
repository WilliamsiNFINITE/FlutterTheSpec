# FlutterTheSpec

State machines, are a widely used tool for design, implementation and reasoning in software and computer engineering. Despite their usefulness and their omnipresence, there is still a major problem today which lies in the number of tools proposed to realize finite state machines as well as in the portability of the tools available on the various existing platforms. Therefore, the main objective of this project is to provide an interface for editing such automata, designed with a multi-platform tool: Flutter. The final product will therefore be inspired by existing software such as yEd or UPPAAL.

This readme shows how to setup the developping environment for the application and how to launch it on Windows 10

## Setup

### Prerequisite

You need to have the following installed :

- [Git](https://git-scm.com/downloads)
- [Flutter](https://docs.flutter.dev/get-started/install)
- [Node.js](https://nodejs.org/en/download/)

### Clone directory

You can clone this repository in the directory you want to make the installation with this command in the terminal:

```console
$>git clone https://github.com/WilliamsiNFINITE/FlutterTheSpec.git
```

## Launch the application

Note that the application can be found online [here](https://flutter-the-spec.surge.sh/)

Move into the repository before launching the application You will have the choice to choose between different devices to run it. 

```console
$>cd FlutterTheSpec
$>flutter run
Multiple devices found:
Windows (desktop) • windows • windows-x64    • Microsoft Windows [version 10.0.19044.2130]
Chrome (web)      • chrome  • web-javascript • Google Chrome 106.0.5249.119
Edge (web)        • edge    • web-javascript • Microsoft Edge 106.0.1370.42
[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)
Please choose one (To quit, press "q/Q"):
```

## Configuration

There is nothing to configure in this project.

## Tests

You can run tests from a terminal with the following command:

```console
$>flutter test
```

If you want to execute a specific set of test you can specify the name of the file you want to execute :


```console
$>flutter test myFile_test.dart
```


## Build and deploy

### Build

You can build the web application with the following commands:

```console
$>flutter build web
```
If you want to build the application on other platform you can take a look on how to do so for [macOS](https://docs.flutter.dev/deployment/macos), [Linux](https://docs.flutter.dev/deployment/linux), [Windows](https://docs.flutter.dev/deployment/windows), [Android](https://docs.flutter.dev/deployment/android), [iOS](https://docs.flutter.dev/deployment/ios).


### Deploy

The web application was deployed for a demo on [Surge](https://surge.sh/).

To deploy the web application follow these steps :

```console
$>cd .\build\web
$\build\web>surge
```

You will be asked for your login details if this is the first time you execute the command. Then you can choose the project and domain.

```console
   Running as williams.hoarau@ensta-bretagne.org (Student)

        project: C:\Users\Williams\Documents\GitHub\FlutterTheSpec\build\web\
         domain: flutter-the-spec.surge.sh
         upload: [====================] 100% eta: 0.0s (22 files, 21140218 bytes)
            CDN: [====================] 100%
     encryption: *.surge.sh, surge.sh (85 days)
             IP: 138.197.235.123

   Success! - Published to flutter-the-spec.surge.sh

```

Note: You will not be able to choose the same domain if I did not add you before. 

### Author

Contact me for any question :

[By mail](mailto:williams.hoarau@ensta-bretagne.org)

[By Linkedin](https://www.linkedin.com/in/whoarau)



