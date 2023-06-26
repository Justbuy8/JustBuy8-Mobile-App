import 'package:flutter/material.dart';
import 'package:justbuyeight/constants/app_colors.dart';

class ToggleButtonsWidget extends StatefulWidget {
  final List<String> searchTypes;

  const ToggleButtonsWidget({Key? key, required this.searchTypes})
      : super(key: key);

  @override
  State<ToggleButtonsWidget> createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  int _selectedButtonIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: List.generate(
          widget.searchTypes.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedButtonIndex = index;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedButtonIndex == index
                      ? AppColors.primaryColor
                      : AppColors.transparentColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: Text(
                    widget.searchTypes[index],
                    style: TextStyle(
                      color: _selectedButtonIndex == index
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
