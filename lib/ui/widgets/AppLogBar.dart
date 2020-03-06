import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/widgets/AppLogBarPainter.dart';
import 'package:app_social/ui/widgets/AppWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../extensions/PageControllerExtension.dart';

class AppLogBar extends StatefulWidget {
  final String menu1;
  final String menu2;
  final PageController pageController;


  AppLogBar(
      {@required this.menu1,
      @required this.menu2,
      @required this.pageController});

  @override
  _AppLogBarState createState() => _AppLogBarState();
}

class _AppLogBarState extends State<AppLogBar> {


  AppGlobalStore store;

  @override
  void didChangeDependencies() {

    this.store ??= GetIt.instance<AppGlobalStore>();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var ratio = 1.2;
    return Container(
      width: MediaQuery.of(context).size.width / ratio,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
      child: CustomPaint(
        painter: AppLogBarPainter(pageController: widget.pageController, ratio: ratio),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[button(widget.menu1, 0), button(widget.menu2, 1)],
        ),
      ),
    );
  }

  Expanded button(String name, int idx) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          this.widget.pageController.next(idx);
          this.store.changeLogMenu(idx);
        },
        child: Observer(
          builder: (_) => Text(
            name,
            style: TextStyle(
              color: (idx == store.currentLogMenuIdx)
                  ? Colors.white
                  : darkGrey,
            ),
          ),
        ),
      ),
    );
  }
}
