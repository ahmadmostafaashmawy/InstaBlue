import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/utilities/resources/app_images.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({this.state});

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(AppImages.AppLogo),
            AppTextDisplay(
              text:
                  'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
            ),
          ],
        ),
      ),
    );
  }
}
