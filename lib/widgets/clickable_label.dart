import 'package:flutter/material.dart';
import 'package:octopush/widgets/section_label.dart';

class ClickableLabel extends StatelessWidget {
  final Function onTap;
  final IconData iconData;
  final String label;

  const ClickableLabel({Key key, this.onTap, this.iconData, this.label})
      : assert(onTap != null),
        assert(iconData != null),
        assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: InkWell(
        onTap: onTap,
        child: SectionLabel(
          iconData: iconData,
          label: label,
        ),
      ),
    );
  }
}
