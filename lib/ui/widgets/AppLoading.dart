import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:app_social/ui/widgets/AppPadding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitWave(
              color: blueLight,
              type: SpinKitWaveType.center,
            ),
            AppPadding(child: Text('Chargement en cours ... '))
          ],
        )
      ),
    );
  }
}
