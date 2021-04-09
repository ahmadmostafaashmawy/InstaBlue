import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:insta_blue/screen/components/text_display.dart';
import 'package:insta_blue/utilities/localization/constains.dart';

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback onReadPressed;
  final VoidCallback onWritePressed;

  const DescriptorTile(
      {@required this.descriptor, this.onReadPressed, this.onWritePressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTextDisplay(translation: kDescriptor),
          AppTextDisplay(
              text:
                  '0x${descriptor.uuid.toString().toUpperCase().substring(4, 8)}')
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.value,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) =>
            AppTextDisplay(text: snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}
