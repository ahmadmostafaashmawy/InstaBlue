import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insta_blue/screen/characteristic_tile.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/utilities/localization/constains.dart';

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile(
      {@required this.service, @required this.characteristicTiles});

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.length > 0) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppTextDisplay(translation: kService),
            AppTextDisplay(
                text:
                    '0x${service.uuid.toString().toUpperCase().substring(4, 8)}')
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: AppTextDisplay(translation: kService),
        subtitle: AppTextDisplay(
            text: '0x${service.uuid.toString().toUpperCase().substring(4, 8)}'),
      );
    }
  }
}
