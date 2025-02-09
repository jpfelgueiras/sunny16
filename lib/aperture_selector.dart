import 'package:flutter/material.dart';

class ApertureSelector extends StatefulWidget {
  final List<double> apertureValues;
  final int selectedIndex;
  final Function(int) onApertureSelected;

  const ApertureSelector({
    super.key,
    required this.apertureValues,
    required this.selectedIndex,
    required this.onApertureSelected,
  });

  @override
  _ApertureSelectorState createState() => _ApertureSelectorState();
}

class _ApertureSelectorState extends State<ApertureSelector> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
  }

  @override
  void didUpdateWidget(ApertureSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelectedIndex();
      });
    }
  }

  double _calculateScrollOffset(int index) {
    const itemWidth = 80.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final centerOffset = (screenWidth - itemWidth) / 2;
    return index * itemWidth - centerOffset;
  }

  void _scrollToSelectedIndex() {
    final offset = _calculateScrollOffset(widget.selectedIndex);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Aperture",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Horizontal Scrollable Aperture Selector
            Container(
              height: 100, // Height of the selector
              child: ListView.builder(
                controller: _scrollController, // Attach the ScrollController
                scrollDirection: Axis.horizontal,
                itemCount: widget.apertureValues.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      widget.onApertureSelected(index);
                    },
                    child: Container(
                      width: 80, // Width of each aperture item
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: widget.selectedIndex == index
                            ? Colors.blue
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "f/${widget.apertureValues[index]}",
                          style: TextStyle(
                            fontSize: widget.selectedIndex == index ? 24 : 18,
                            fontWeight: widget.selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: widget.selectedIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }
}
