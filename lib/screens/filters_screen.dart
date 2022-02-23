import "package:flutter/material.dart";

import "../widgets/main_drawer.dart";

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filters";
  
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    super.initState();
    
    _glutenFree = widget.currentFilters["glutenFree"];
    _lactoseFree = widget.currentFilters["lactoseFree"];
    _vegan = widget.currentFilters["vegan"];
    _vegetarian = widget.currentFilters["vegetarian"];
  }

  Widget _buildSwitchList (String title, String description, bool currentValue, Function updateHandler) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                "glutenFree": _glutenFree,
                "lactoseFree": _lactoseFree,
                "vegan": _vegan,
                "vegetarian": _vegetarian,
              };

              widget.saveFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Adjust your meal selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchList(
                  "Gluten-free",
                  "Only includes gluten-free meals",
                  _glutenFree,
                  (newValue) {
                    setState(() => _glutenFree = newValue);
                  },
                ),
                _buildSwitchList(
                  "Lactose-free",
                  "Only includes lactose-free meals",
                  _lactoseFree,
                  (newValue) {
                    setState(() => _lactoseFree = newValue);
                  },
                ),
                _buildSwitchList(
                  "Vegetarian",
                  "Only includes vegetarian meals",
                  _vegetarian,
                  (newValue) {
                    setState(() => _vegetarian = newValue);
                  },
                ),
                _buildSwitchList(
                  "Vegan",
                  "Only includes vegan meals",
                  _vegan,
                  (newValue) {
                    setState(() => _vegan = newValue);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}