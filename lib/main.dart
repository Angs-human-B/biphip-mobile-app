import 'package:bip_hip/controllers/common/binder_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bip_hip/utils/constants/imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BinderController().dependencies();
  await dotenv.load(fileName: Environment.fileName);
  ll("Filename : ${Environment.fileName}");
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Environment.apiKey, appId: Environment.appId, messagingSenderId: Environment.messagingSenderId, projectId: Environment.projectId));
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        initialRoute: krSplashScreen,
        getPages: routes,
        theme: ThemeData(useMaterial3: false),
      ),
    );
  }
}
