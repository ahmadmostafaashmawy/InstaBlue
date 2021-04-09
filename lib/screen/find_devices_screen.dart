import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insta_blue/screen/components/button_display.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/screen/scan_result_tile.dart';
import 'package:insta_blue/screen/adapter_state_tile.dart';
import 'package:insta_blue/utilities/localization/constains.dart';
import 'package:insta_blue/utilities/navigator.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';
import 'package:insta_blue/utilities/routes.dart';

class FindDevicesScreen extends StatefulWidget {
  @override
  _FindDevicesScreenState createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryColor,
        title: AppTextDisplay(translation: kFindDevices, color: AppColor.White),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 10)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildBluetoothDevices(context),
              buildScanResult(context),
            ],
          ),
        ),
      ),
      floatingActionButton: buildSearchButton(),
    );
  }

  StreamBuilder<bool> buildSearchButton() {
    return StreamBuilder<bool>(
      stream: FlutterBlue.instance.isScanning,
      initialData: false,
      builder: (c, snapshot) {
        if (snapshot.data) {
          return FloatingActionButton(
            child: Icon(Icons.stop),
            onPressed: () => FlutterBlue.instance.stopScan(),
            backgroundColor: AppColor.PrimaryRedColor,
          );
        } else {
          return FloatingActionButton(
              backgroundColor: AppColor.PrimaryColor,
              child: Icon(Icons.search),
              onPressed: () => FlutterBlue.instance
                  .startScan(timeout: Duration(seconds: 10)));
        }
      },
    );
  }

  StreamBuilder<List<ScanResult>> buildScanResult(BuildContext context) {
    return StreamBuilder<List<ScanResult>>(
      stream: FlutterBlue.instance.scanResults,
      initialData: [],
      builder: (c, snapshot) => Column(
          children: snapshot.data
              .map(
                (r) => ScanResultTile(
                  result: r,
                  onTap: () => AppButtonDisplay(
                    translation: kOpen,
                    isUpper: true,
                    onTap: () => pushName(context, AppRoute.DeviceScreen,
                        arguments: r.device),
                  ),
                ),
              )
              .toList()),
    );
  }

  StreamBuilder<List<BluetoothDevice>> buildBluetoothDevices(
      BuildContext context) {
    return StreamBuilder<List<BluetoothDevice>>(
      stream: Stream.periodic(Duration(seconds: 8))
          .asyncMap((_) => FlutterBlue.instance.connectedDevices),
      initialData: [],
      builder: (c, snapshot) => Column(
        children: snapshot.data
            .map((d) => ListTile(
                  title: AppTextDisplay(text: d.name),
                  subtitle: AppTextDisplay(text: d.id.toString()),
                  trailing: StreamBuilder<BluetoothDeviceState>(
                    stream: d.state,
                    initialData: BluetoothDeviceState.disconnected,
                    builder: (c, snapshot) {
                      return AppButtonDisplay(
                          translation:
                              snapshot.data == BluetoothDeviceState.connected
                                  ? kOpen
                                  : snapshot.data.toString(),
                          isUpper: true,
                          onTap: () => () {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected)
                                  pushName(context, AppRoute.DeviceScreen,
                                      arguments: d);
                              });
                    },
                  ),
                ))
            .toList(),
      ),
    );
  }
}
