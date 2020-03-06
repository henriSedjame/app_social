
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'InjectableConfig.iconfig.dart';

@injectableInit
void configureInjection() => $initGetIt(GetIt.instance);

