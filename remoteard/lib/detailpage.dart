// @dart=2.9
import 'dart:convert';
import 'dart:typed_data';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DetailPage extends StatefulWidget {

  final BluetoothDevice server;
  const DetailPage({this.server});
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
    BluetoothConnection connection;
    bool isConnecting = true;

  _DetailPageState();
    bool get isConnected => connection !=null && connection.isConnected;
    bool isDisconnecting =false;

    @override
  void initState() {
    super.initState();
    _getBTConnection();
  }

  @override
  void dispose(){
      if(isConnected) {
        isDisconnecting =true;
        connection.dispose();
        connection=null;
      }
      super.dispose();
  }
_getBTConnection(){
      BluetoothConnection.toAddress(widget.server.address).then((_connection){
        connection = _connection;
        isConnecting = false;
        isDisconnecting = false;
        setState(() {});
        connection.input.listen(_onDataReceived).onDone(() {
          if(isDisconnecting){
            print("Disconnecting locally");
          }else{
            print("Disconnecting Remotely");
          }if(this.mounted){
            setState(() {});
          }
          Navigator.of(context).pop();
        });

      }).catchError((error){
        Navigator.of(context).pop;
      });
}
void _onDataReceived(Uint8List data){}

void _command(String text) async{
  try{
    connection.output.add(utf8.encode(text));
    await connection.output.allSent;
  }catch (e){
    setState(() {});
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#679289"),
      appBar: AppBar(title: (isConnected ? Text('Connecting to ${widget.server.name}...')
          : isConnected ? Text('Connected with ${widget.server.name}') : Text('Disconnected with ${widget.server.name}')),),
      body: SafeArea(child: isConnected ? Column(children: <Widget>[Space(),Controller()

      ],) : Center(child: Text("Connecting...",style:TextStyle(fontSize: 24,fontWeight: FontWeight.bold,  color: Colors.white)),),),
    );
  }
  Widget Space(){
  return Container();
}
  Widget Controller(){
    // @dart=2.10

    GestureTapDownCallback? onTapDown;
    return Container
      (


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
                        children: [GestureDetector(
                        onTap: () {_command('shield');print('shield');
                        },
                        child:IconButton(
                          icon: Icon(
                            Icons.shield,
                          ),
                          onPressed: () {},
                        ),
                      ),]
                    ),),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 225,
                    width: 125,
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
                    height: 125,
                    width: 225,
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
      );
  }
}






