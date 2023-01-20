// @dart=2.9
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:remoteard/BluetoothDeviceListEntry.dart';
import 'package:flutter/services.dart';
import 'package:remoteard/detailpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(),debugShowCheckedModeBanner: false,);
  }
}

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{

  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> devices = List<BluetoothDevice>.empty(growable:true);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getBTstate();
    _stateChangeListener();
    _listBondedDevices();
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    if(state.index == 0){
      if(_bluetoothState.isEnabled){
        _listBondedDevices();
      }
    }
  }

  _getBTstate(){
    FlutterBluetoothSerial.instance.state.then((state) {
      _bluetoothState = state;
      if(_bluetoothState.isEnabled){
        _listBondedDevices();
      }
      setState(() {});

    });
  }

  _stateChangeListener(){
    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      _bluetoothState =state;
      if(_bluetoothState.isEnabled){
        _listBondedDevices();
      }else{
        devices.clear();
      }
      print("state is enabled: ${state.isEnabled}");
      setState(() {});
    });
  }
  _listBondedDevices() {
    FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((List<BluetoothDevice> bondedDevices) {
      devices = bondedDevices;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("rbo bluetooth serial"),),
      body: Container(
        child: Column(children: <Widget>[
          SwitchListTile(
            title: Text('Enable Bluetooth'),
            value: _bluetoothState.isEnabled,
            onChanged: (bool value){
              future() async{
                if(value){
                  await FlutterBluetoothSerial.instance.requestEnable();
                }else{
                  await FlutterBluetoothSerial.instance.requestDisable();
                }
                future().then((_){setState(() {
                });});
              }
            },
          ),
          ListTile(
            title: Text("Bluetooth STATUS"),
            subtitle: Text(_bluetoothState.toString()),
            trailing: ElevatedButton(child: Text("settings"),onPressed: (){
              FlutterBluetoothSerial.instance.openSettings();
            },),
          ),
          Expanded(
              child: ListView(
                children: devices
                    .map((_device) => BluetoothDeviceListEntry(
                  device: _device,
                  enabled: true,
                  onTap: ()  {
                    print("Item");
                    _startController(context, _device);
                  },
                ))
                    .toList(),
              )

          )









        ],),
      ),
    );
  }
  void _startController(BuildContext context, BluetoothDevice server){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return DetailPage(server: server);
    }));

  }
}

stless