import 'package:edge_library_app/app/view/app.dart';
import 'package:edge_library_app/bootstrap.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() => const App());
}
