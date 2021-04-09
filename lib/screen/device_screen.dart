import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insta_blue/screen/characteristic_tile.dart';
import 'package:insta_blue/screen/components/button_display.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/screen/service_tile.dart';
import 'package:insta_blue/utilities/localization/constains.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';

import 'descriptor_tile.dart';

class DeviceScreen extends StatelessWidget {
  BluetoothDevice device;

  List<int> _getRandomBytes() {
    final math = Random();
    return [
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255),
      math.nextInt(255)
    ];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () => c.read(),
                    onWritePressed: () async {
                      await c.write(_getRandomBytes(), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    device = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.PrimaryColor,
        title: AppTextDisplay(text: device.name, color: AppColor.White),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              return AppButtonDisplay(
                onTap: getPressCallback(snapshot.data),
                translation: getButtonText(snapshot.data),
                isUpper: true,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: AppTextDisplay(
                    text:
                        'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: AppTextDisplay(text: '${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      AppButtonDisplay(
                        child: Icon(Icons.refresh),
                        onTap: () => device.discoverServices(),
                      ),
                      AppButtonDisplay(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(AppColor.Grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onTap: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: AppTextDisplay(translation: kMTUSize),
                subtitle: AppTextDisplay(text: '${snapshot.data} bytes'),
                trailing: AppButtonDisplay(
                  child: Icon(Icons.edit),
                  onTap: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getButtonText(BluetoothDeviceState data) {
    switch (data) {
      case BluetoothDeviceState.connected:
        return kDisconnect;
        break;
      case BluetoothDeviceState.disconnected:
        return kConnect;
        break;
      default:
        return data.toString().substring(21).toUpperCase();
        break;
    }
  }

  getPressCallback(BluetoothDeviceState data) {
    switch (data) {
      case BluetoothDeviceState.connected:
        return device.disconnect();
        break;
      case BluetoothDeviceState.disconnected:
        return device.connect();
        break;
      default:
        return null;
        break;
    }
  }
}
