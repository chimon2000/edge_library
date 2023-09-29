import 'package:edge_library_app/app/view/app.dart';
import 'package:edge_library_app/bootstrap.dart';
import 'package:edge_library_common/edge_library_common.dart';
import 'package:flutter/material.dart';

void main() {
  initializeMappers();

  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() => const App());
}
