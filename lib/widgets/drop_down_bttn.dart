import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
String? selectedItem;
class DropDownBttn extends StatelessWidget {
  final List<String> items;
  final String selectedItemText;
  final Function(String?) onSelected;
  const DropDownBttn({super.key, required this.items, required this.selectedItemText, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: DropdownButtonHideUnderline(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            width: 140,
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text(selectedItemText,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
              value: selectedItem,
              onChanged: (String? value) {
                onSelected(value);
              },
            ),
          ),
        ),
      ),
    );
  }
}
