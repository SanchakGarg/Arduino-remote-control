// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: remoteControl(),
    );
  }
}





class remoteControl extends StatefulWidget {

  @override
  State<remoteControl> createState() => _remoteControlState();
}

class _remoteControlState extends State<remoteControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:HexColor("#679289"),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(),Row(),Row(),Row(),Row(),Row(),Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 60,
                      width: 60
                  ),
                  Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: HexColor("#EE2E31"),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [ IconButton(
                        icon: Icon(
                          Icons.shield,
                        ),
                        onPressed: () {print('Shield');_command('shield');},
                      ),
                      ],
                    ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 156,
                    width: 57,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: HexColor("#F4C095"),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [GestureDetector(
                        onLongPressUp: () {_command('forwardstop');print('forwardstop');
                        },
                        onLongPress: () {_command('forward');print('forward');
                        },
                        child:IconButton(
                          icon: Icon(
                            Icons.arrow_drop_up,
                          ),
                          onPressed: () {},
                        ),
                      ),




                        Text('ACC',),





                        GestureDetector(
                          onLongPressUp: () {_command('backstop');print('backstop');
                          },
                          onLongPress: () {_command('back');print('back');
                          },
                          child:IconButton(
                            icon: Icon(
                              Icons.arrow_drop_down,
                            ),
                            onPressed: () {},
                          ),
                        )




                      ],
                    ),
                  ),
                  Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),Container(),

                  Container(
                    height: 57,
                    width: 156,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: HexColor("#F4C095"),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        GestureDetector(
                          onLongPressUp: () {_command('leftstop');print('leftstop');
                          },
                          onLongPress: () {_command('left');print('left');
                          },
                          child:IconButton(
                            icon: Icon(
                              Icons.arrow_left,
                            ),
                            onPressed: () {},
                          ),
                        ),




                        Text('TURN',),




                        GestureDetector(
                          onLongPressUp: () {_command('rightstop');print('rightstop');
                          },
                          onLongPress: () {_command('right');print('right');
                          },
                          child:IconButton(
                            icon: Icon(
                              Icons.arrow_right,
                            ),
                            onPressed: () {},
                          ),
                        )




                      ],
                    ),
                  )
                ],
              )
            ],
          )
      ),
    );
  }
}
