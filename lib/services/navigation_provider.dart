// lib/services/navigation_provider.dart
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _activeSection = 0;
  final ScrollController scrollController = ScrollController();

  // Map section index to GlobalKey
  final List<GlobalKey> sectionKeys = List.generate(7, (_) => GlobalKey());

  int get activeSection => _activeSection;

  void setActiveSection(int index) {
    if (_activeSection != index) {
      _activeSection = index;
      notifyListeners();
    }
  }

  void scrollToSection(int index) {
    final key = sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
      setActiveSection(index);
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
