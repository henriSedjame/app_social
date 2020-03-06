
import 'package:flutter/material.dart';

extension PageControllerExtension on PageController {

  void next(int page) {
    var currentPage = this.page.toInt();
    if (page != currentPage) {
      this.animateToPage(page, duration: Duration(milliseconds: 120), curve: Curves.decelerate);
    }
  }
}