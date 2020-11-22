import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sheet_test/features/form/presentation/screens/form_screen.dart';
import 'package:google_sheet_test/features/splash/widgets/feeback_logo.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'screens/splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    Future.delayed(Duration(seconds: 2), () {
      _navigateTo(context);
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  Future<void> _navigateTo(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(FormScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      allowFontScaling: false,
      designSize: Size(360, 750),
    );
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          FeebakcLogo(
            height: ScreenUtil().setHeight(250),
            width: ScreenUtil().setHeight(150),
          ),
          Spacer(
            flex: 1,
          ),
          SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
            size: ScreenUtil().setWidth(20),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
        ],
      ),
    );
  }
}
