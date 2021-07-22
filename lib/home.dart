import 'package:darklightmodechanger/themeManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late bool themeSwitch;
  late AnimationController _controller;
  // New: icon states: show menu vs. show close.
  bool isShowingMenu = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.3,
      duration: Duration(seconds: 3),
    )..repeat();

    ThemeData themeMode =
        Provider.of<ThemeNotifier>(context, listen: false).getTheme();
    if (themeMode.brightness == Brightness.dark) {
      print("DrkMode");
      setState(() {
        themeSwitch = true;
      });
    } else {
      print("LightMode");
      setState(() {
        themeSwitch = false;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hybrid Theme"),
          actions: [
            Icon(
              themeSwitch ? Icons.star_border : Icons.wb_sunny,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Consumer<ThemeNotifier>(
            builder: (context, theme, _) => Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "DarkMode ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Transform.scale(
                              scale: 1.3,
                              child: Switch(
                                splashRadius: 25,
                                value: themeSwitch,
                                onChanged: (bool newValue) {
                                  if (newValue == true) {
                                    theme.setDarkMode();
                                    setState(() {
                                      themeSwitch = newValue;
                                    });
                                  } else {
                                    theme.setLightMode();
                                    setState(() {
                                      themeSwitch = newValue;
                                    });
                                  }
                                },
                              ),
                            )
                          ]),
                      SizedBox(height: 70),
                      Container(
                        //  color: Colors.red,
                        height: 300,
                        child: AnimatedBuilder(
                          animation: CurvedAnimation(
                              parent: _controller, curve: Curves.linear),
                          builder: (context, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                //  _buildContainer(150 * _controller.value),
                                //  _buildContainer(200 * _controller.value),
                                _buildContainer(250 * _controller.value),
                                _buildContainer(300 * _controller.value),
                                _buildContainer(350 * _controller.value),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 100,
                                      backgroundColor:
                                          Colors.redAccent.shade200,
                                      child: CircleAvatar(
                                        radius: 96,
                                        backgroundImage:
                                            AssetImage('images/user.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Text(
                        "Veeraswamy Lingala",
                        style: TextStyle(fontSize: 30),
                      )
                    ]))));
  }

  Widget _buildContainer(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.withOpacity(1 - _controller.value),
      ),
    );
  }
}
