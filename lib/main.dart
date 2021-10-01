import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wifyfood/Helper/cart_count.dart';
import 'package:wifyfood/Helper/global_key.dart';
import 'package:wifyfood/Helper/push_notification.dart';
import 'package:wifyfood/Helper/restartwidget.dart';
import 'package:wifyfood/KitchenView/kitchendashboard.dart';
import 'package:wifyfood/KitchenView/signinscreen.dart';
import 'package:wifyfood/Language/localizations_deligate.dart';
import 'package:wifyfood/UserHandlers/user_latlong.dart';
import 'package:wifyfood/Language/locale_constant.dart';
import 'package:wifyfood/UserView/otpverificationscreen.dart';
import 'package:wifyfood/UserView/selecttypescreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wifyfood/UserView/userdashboard.dart';
import 'Helper/custom_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    print("first-------------------------------------------------------");
    SetKitchenId().getKitchenIdLocal().then((value) {
      if (value != null) {
        PushNotification().initializeKitchen(context);
      } else
        PushNotification().initialize();
    });
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  // final GlobalKey<NavigatorState> navigatorKey =
  //     GlobalKey(debugLabel: "Main Navigator");

  @override
  Widget build(BuildContext context) {
    //PushNotification().initializeKitchen();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);

    return ChangeNotifierProvider(create: (_) {
      return themeChangeProvider;
    }, child: Consumer<DarkThemeProvider>(
      builder: (BuildContext context, value, Widget child) {
        return ChangeNotifierProvider<CartCount>(
            create: (context) => CartCount(),
            builder: (BuildContext context, child) {
              return MaterialApp(
                navigatorKey: GlobalVariable.navState,
                debugShowCheckedModeBanner: false,
                //title: 'Flutter Demo',
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                // home: SlashScreen(),
                home: Navigate(),
                locale: _locale,
                supportedLocales: [
                  Locale('en', ''),
                  Locale('gu', ''),
                  Locale('hi', ''),
                  Locale('bn', ''),
                  Locale('ar', ''),
                  Locale('ta', ''),
                  Locale('ml', ''),
                ],
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale?.languageCode == locale?.languageCode &&
                        supportedLocale?.countryCode == locale?.countryCode) {
                      return supportedLocale;
                    }
                  }
                  return supportedLocales?.first;
                },
                // routes: {
                //   "root": (context) => SelectTypeScreen(),
                //   // "home": (context) => HomeScreen(),
                //   "KitchenDashboard": (context) => KitchenDashboard(),
                // },
                onGenerateRoute: routes,
              );
            });
      },
    ));
  }

  Route routes(RouteSettings settings) {
    if (settings.name == 'KitchenDashboard') {
      return MaterialPageRoute(builder: (context) => KitchenDashboard());
    } else {
      return MaterialPageRoute(builder: (context) => SlashScreen());
    }
  }
}

class DarkThemePreference {
  static const THEME_STATUS = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_STATUS) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: isDarkTheme ? Colors.black : Colors.white,
      backgroundColor: isDarkTheme ? Colors.white : Colors.grey[500],
      // indicatorColor: isDarkTheme ? Color(0xff0E1D36) : Color(0xffCBDCF8),
      // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      // hintColor: isDarkTheme ? Color(0xff280C0B) : Color(0xffEECED3),
      // highlightColor: isDarkTheme ? Color(0xff372901) : Color(0xffFCE192),
      // hoverColor: isDarkTheme ? Color(0xff3A3A3B) : Color(0xff4285F4),
      // focusColor: isDarkTheme ? Colors.red : Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      //textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      textSelectionTheme: isDarkTheme
          ? TextSelectionThemeData(
              selectionColor: Colors.white,
              selectionHandleColor: Colors.white,
              cursorColor: Colors.white)
          : TextSelectionThemeData(
              selectionColor: Colors.black,
              selectionHandleColor: Colors.black,
              cursorColor: Colors.black),
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.grey[800] : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      textTheme: isDarkTheme
          ? TextTheme(headline5: TextStyle(color: Colors.white))
          : TextTheme(headline5: TextStyle(color: Colors.black)),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    );
  }
}

class SetDeviceId {
  static const DEVICE_ID = "Device_Id";

  setDeviceIdLocal(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DEVICE_ID, uid);
  }

  Future<String> getDeviceIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DEVICE_ID);
  }

  Future removeDeviceIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(DEVICE_ID);
  }
}

class SetToken {
  static const TOKEN_ID = "Token_Id";

  setTokenIdLocal(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN_ID, uid);
  }

  Future<String> getTokenIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_ID);
  }

  Future removeTokenIdLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(TOKEN_ID);
  }
}

class SlashScreen extends StatefulWidget {
  @override
  _SlashScreenState createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  String deviceId;
  String tokenId;

  Future getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print("AndroidId: ${androidInfo.androidId}");
    setState(() {
      deviceId = androidInfo.androidId;
    });
    // print("Id: ${androidInfo.id}");
    // print("Board: ${androidInfo.board}");
    // print("Brand: ${androidInfo.brand}");
    // print("Device: ${androidInfo.device}");
    // print("Display: ${androidInfo.display}");
    // print("Hardware: ${androidInfo.hardware}");
    // print("Host: ${androidInfo.host}");
    // print("Type: ${androidInfo.type}");
    // print("Version: ${androidInfo.version.baseOS}");
    // print("DeviceId: $deviceId");
    return deviceId;
  }

  Future getTokenId() async {
    // FirebaseMessaging _msg = FirebaseMessaging();
    // String id = await _msg.getToken(
    // String id = await FirebaseMessaging.instance.getToken();
    // print("FIS 1");
    await FirebaseMessaging.instance.requestPermission();
    // print("FIS 2");
    String id;
    try {
      id = await FirebaseMessaging.instance.getToken();
    } catch (e) {
      print("******Firebase Error******");
      // Fluttertoast.showToast(
      //   msg: "Check Internet!!",
      //   fontSize: 20,
      //   textColor: Colors.white,
      //   backgroundColor: Colors.blue,
      //   toastLength: Toast.LENGTH_LONG,
      // );
    }
    // print("FIS 3");
    print("TokenId: $id");
    setState(() {
      tokenId = id;
    });
    // print("DeviceId: $deviceId");
    return tokenId;
  }

  checkLogin() async {
    // final c = context.watch<CartCount>();
    //var data = await Provider.of<CartCount>(context).navigateData;
    // print("navigateData------------------------${c.navigateData}");
    var _data = "Kitchen";
    // if (data != null) {
    //   print("package:wifyfood");
    //   return KitchenDashboard();
    // } else {
    //   print("SlashScreen");
    //   return SlashScreen();
    // }
    if (_data != null) {
      switch (_data) {
        case "Kitchen":
          return KitchenDashboard();

          break;
        case 'dataFound':
          // if (_commnallId != '') {
          //   return Pin();
          // } else {
          //   return Logout();
          // }
          return SlashScreen();
          break;
      }
    } else {
      return Container(
        // color: pBackgroundColor,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Future getLocation(String userId) async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isLocationServiceEnabled == true) {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(minutes: 1),
      ).then((value) {
        //print("$value");
        getUserLatLongData(
            value.latitude.toString(), value.longitude.toString(), userId);
      });
    } else {
      Geolocator.requestPermission();
      Geolocator.getCurrentPosition();
      // Fluttertoast.showToast(
      //   msg: "Turn on your GPS",
      //   fontSize: 20,
      //   textColor: Colors.white,
      //   backgroundColor: Colors.blue,
      //   toastLength: Toast.LENGTH_LONG,
      // );
    }
  }

  @override
  void initState() {
    // SharedPreferences.setMockInitialValues({});
    // Firebase.initializeApp();

    getTokenId().then((value) {
      SetToken().setTokenIdLocal(value);
      Timer(Duration(seconds: 5), () {
        SetKitchenId().getKitchenIdLocal().then((value) {
          if (value == null) {
            SetUserId().getUserIdLocal().then((value) {
              if (value == null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectTypeScreen(value),
                  ),
                );
              } else {
                print("## User Id Main: $value");
                Provider.of<CartCount>(context, listen: false)
                    .updateUserId(value);
                getLocation(value).then((value) {});
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => /*HomeScreen()*/ RestartWidget(
                      child: UserDashboardScreen(value),
                    ),
                  ),
                );
              }
            });
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                settings: RouteSettings(name: "KitchenDashboard"),
                builder: (context) => KitchenDashboard(),
              ),
            );
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundScreen(),
          BackgroundCircle(),
          Container(
            child: Container(
              //margin: EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Center(
                      child: SvgPicture.asset(
                          'assets/svg/Vector Smart Object-6.svg'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Transform.translate(
                      offset: Offset(0, 40),
                      child: Image.asset(
                        'assets/Group 2316.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Navigate extends StatefulWidget {
  @override
  _NavigateState createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  Widget checkLogin() {
    print("------------------------------------------------------dsfaf");
    final c = context.watch<CartCount>();
    //var data = await Provider.of<CartCount>(context).navigateData;
    // print("navigateData------------------------${c.navigateData}");
    var _data = c.navigateData;
    print("objectdata-------------$_data");
    // if (data != null) {
    //   print("package:wifyfood");
    //   return KitchenDashboard();
    // } else {
    //   print("SlashScreen");
    //   return SlashScreen();
    // }
    //  if (_data != null) {
    switch (_data.toString()) {
      case "KitchenDashboard":
        return KitchenDashboard();

        break;
      case "":
        // if (_commnallId != '') {
        //   return Pin();
        // } else {
        //   return Logout();
        // }
        return SlashScreen();
        break;
    }
    //  } else {
    //  return SlashScreen();
    //}
  }

  @override
  Widget build(BuildContext context) {
    return checkLogin();
  }
}
