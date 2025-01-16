import 'package:flutter/material.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

class NetIcon extends StatelessWidget {
  const NetIcon({super.key, required this.netState});

  final NetState netState;

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    Map<NetState, Widget> netIcons = {
      NetState.cannotAccess:
          Icon(Icons.link_off_rounded, color: colorTheme.error),
      NetState.loading:
          SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
      NetState.success:
          Icon(Icons.wifi_tethering_rounded, color: colorTheme.primary)
    };
    return IconButton(
        onPressed: () {
          var globalState = Provider.of<GlobalState>(context, listen: false);
          globalState.initFormNet(context);
        },
        icon: netIcons[netState]!);
  }
}
