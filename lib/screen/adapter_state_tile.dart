// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/utilities/resources/app_color.dart';

class AdapterStateTile extends StatelessWidget {
  const AdapterStateTile({@required this.state});

  final BluetoothState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.PrimaryRedColor,
      child: ListTile(
        title: AppTextDisplay(
          text: 'Bluetooth adapter is ${state.toString().substring(15)}',
        ),
        trailing: Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead?.color,
        ),
      ),
    );
  }
}
