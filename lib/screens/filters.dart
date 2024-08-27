import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:flutter/material.dart';
import 'package:meals_navigation/widgets/switch_tile.dart';
import "package:meals_navigation/providers/filters.dart";

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _glutonFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegFilterSet = false;
  bool _vegunFreeFilterSet = false;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(filtersProvider);
    _glutonFreeFilterSet = filters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = filters[Filter.lactoseFree]!;
    _vegFilterSet = filters[Filter.veg]!;
    _vegunFreeFilterSet = filters[Filter.vegun]!;
  }

  _onSwitchChange(bool isChecked, String type) {
    switch (type) {
      case "glutton":
        setState(() {
          _glutonFreeFilterSet = isChecked;
        });
        ref
            .read(filtersProvider.notifier)
            .setFilter(Filter.glutenFree, isChecked);
        break;
      case "lactose":
        setState(() {
          _lactoseFreeFilterSet = isChecked;
        });
        ref
            .read(filtersProvider.notifier)
            .setFilter(Filter.lactoseFree, isChecked);
        break;
      case "veg":
        setState(() {
          _vegFilterSet = isChecked;
        });
        ref.read(filtersProvider.notifier).setFilter(Filter.veg, isChecked);
        break;
      case "vegun":
        setState(() {
          _vegunFreeFilterSet = isChecked;
        });
        ref.read(filtersProvider.notifier).setFilter(Filter.vegun, isChecked);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Meals'),
      ),
      // drawer: MainDrawer(
      //   onNavigate: (type) {
      //     Navigator.of(context).pop();
      //     if (type == "meals") {
      //       Navigator.of(context)
      //           .push(MaterialPageRoute(builder: (ctx) => const TabsScreen()));
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: true,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _glutonFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.veg: _vegFilterSet,
            Filter.vegun: _vegunFreeFilterSet,
          });

          // Navigator.of(context).pop({
          //   Filter.glutenFree: _glutonFreeFilterSet,
          //   Filter.lactoseFree: _lactoseFreeFilterSet,
          //   Filter.veg: _vegFilterSet,
          //   Filter.vegun: _vegunFreeFilterSet,
          // });
        },
        child: Column(
          children: [
            SwitchTile(
              value: _glutonFreeFilterSet,
              onSwitchChange: _onSwitchChange,
              title: "Gluton-Free",
              subtitle: "Only filter gluton-free",
              type: "glutton",
              key: const ValueKey("glutton"),
            ),
            SwitchTile(
              value: _lactoseFreeFilterSet,
              onSwitchChange: _onSwitchChange,
              title: "Lactose-Free",
              subtitle: "Only filter lactose-free",
              type: "lactose",
              key: const ValueKey("lactose"),
            ),
            SwitchTile(
              value: _vegFilterSet,
              onSwitchChange: _onSwitchChange,
              title: "Vegetarian",
              subtitle: "Only filter vegetarian item",
              type: "veg",
              key: const ValueKey("veg"),
            ),
            SwitchTile(
              value: _vegunFreeFilterSet,
              onSwitchChange: _onSwitchChange,
              title: "Vegun",
              subtitle: "Only filter vegun",
              type: "vegun",
              key: const ValueKey("vegun"),
            )
          ],
        ),
      ),
    );
  }
}
