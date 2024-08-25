import 'package:flutter/material.dart';

class SwitchTile extends StatelessWidget {
  const SwitchTile(
      {super.key,
      required this.value,
      required this.onSwitchChange,
      required this.title,
      required this.subtitle,
      required this.type});

  final bool value;
  final void Function(bool isChecked, String type) onSwitchChange;
  final String title;
  final String subtitle;
  final String type;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: (isChecked) {
        onSwitchChange(isChecked, type);
      },
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
