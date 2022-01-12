# Bingo - PR & SPC - front end module

Exam project for "Programming" university course @ UniCampus Rome - Developed by Paolo Ruggirello & Simone Pio Caronia.
The front end module has been developed using the UI toolkit Flutter, here the [online documentation](https://flutter.dev/docs), and Dart as programming language.


## Project structure

### Screens and state management
The app uses the provider pattern, made simple by using the [provider](https://pub.dev/packages/provider) package.
Basically the view is notified by a controller about the change of state. Controller can extend mixins, such as RouteMixin or ServiceMixin, which add functionalities. 

All the screens are located into the *"lib/screens"* folder.

Each screen has its Notifier class, which holds the state and access to data.
The screen uses the **Consumer** widget to retrieve the instance of its notifier.
Notifiers have to extend the **BaseNotifier** class, located into the *"lib/base"*, in order to provide screen the possibility to retrieve data from API and CACHE.
**BaseWidget** is a useful widget that contains the base components to build correctly the screen.

Example *build(BuildContext)* method with Consumer and BaseWidget:
```
Widget build(BuildContext context) {
  return Consumer<BaseNotifier>(
    builder: (_, notifier, __) => BaseWidget(
          safeAreaTop: true,
          overlayStyle: SystemUiOverlayStyle.dark,
          child: _buildChild(context, notifier),
        )
    );
}
```


### Navigation
The base Navigator is used in app. For navigating, you can extend the *RouteMixin* located into *"lib/navigation"* folder.
All screens are registered in *Routes* class, located into *"lib/navigation"* folder, and navigation between them is done using *RouteEnum*
So if you want to add new screen, please add a new enum value (and its name into extension) and register the route in the *Routes* class.


### API and Socket.IO
***API***
The api client used in app is [dio](https://pub.dev/packages/dio), a powerful Dart HTTP client.
**ApiClient**, located in *"lib/services/api"* folder, is the custom client, which permits to invoke all HTTP methods, passing the right parameters.
All endpoints called by app are stored in the **ApiService** class, located in *"lib/services/api"* folder. Each response is wrapped in a *ServiceResponse* object. If another endpoint is needed, please add a new method in the class just mentioned.
The base url of API is stored in ApiClient during its initialization.
Example:
```
Future<ServiceResponse<OnlinePlayersResponse>> getOnlinePlayersRoom(String roomCode, {CancelToken? cancelToken}) async {
    ServiceResponse<OnlinePlayersResponse> response = ServiceResponse();

    try{
      response.result = await client.makeGet<OnlinePlayersResponse>("/room/online_players/$roomCode",
          cancelToken: cancelToken,
          converter: (data) => OnlinePlayersResponse.fromJson(data));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }
```

***Socket.IO***
Socket is used in app in order to notify other users during game session about new number extracted, winners, etc...
The client is [socket_io_client](https://pub.dev/packages/socket_io_client), and you can create an instance of it by using the **SocketHelper** class, located in *"lib/services/socket"*. It provides methods to add listeners to socket events.


### Cache and local storage
Cache functionality is needed in app. The packages used are [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) for Android/iOS and [shared_preferences](https://pub.dev/packages/shared_preferences) for Web.
The distinction is needed as currently the web app is stored in a not secure server. As soon as the server is secured, FlutterSecureStorage will be used fro Web too.
All accesses to local storage are collected in **CacheService** class, located in *"lib/services/cache"* folder. Each response is wrapped in a *ServiceResponse* object. If another access to storage is needed, please add a new method in the class just mentioned.
To write, read or delete, you should use the private methods implemented in the service class, which use the right object methods based on type.
Example:
```
Future<ServiceResponse> saveIsHost(bool? isHost) async {
    ServiceResponse response = ServiceResponse();
    try{
      await _write(
          key: StorageKeys.isHost,
          value: (isHost ?? false).toString());
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }
```


### GetIt - ServiceLocator
*ApiService* and *CacheService* are registered once (Singleton) in app using the ServiceLocator package [get_it](https://pub.dev/packages/get_it).
The instances are retrieved in the **ServiceMixin**, so notifiers can just extend the mixin and access to cache and api methods transparently.


### Common widgets
You can find common widgets, such as **AppButton()**, **AppFormField**, etc... inside *"lib/widget"* folder.



## Build app

### Android
Run the command below and then you can find the *app-release.apk* file inside the *"build/app/outputs/flutter-apk"* folder.
```sh
flutter build apk
```
Note: Android SDK needed.

### iOS
Run the command below and then you have to Archive the .ipa file with XCode.
```sh
flutter build ios
```
Note: no iOS mobile provision is available for now.

### Web
Run the command below and then you can find the .html and .js files inside the *"build/web"* folder.
```sh
flutter build web
```



## npm - WEB APP solution
Inside the *"/npm-web"* folder, you can find the last web app version.
It's supported by a simple NODE.JS EXPRESS web server. Basically, node.js web app redirects all routes to the flutter app.

**RUN**
To run the web app, move inside the folder and just run these 2 commands:
```sh
npm install
```
And
```sh
npm start
```

The web app can also be started with Docker. Inside the folder, indeed, there's the *Dockerfile*.



## Building and run the entire BINGO project
You can find all instructions inside [bingo-core](https://github.com/PaoloRuggirello/bingo-core) > README.md file.
