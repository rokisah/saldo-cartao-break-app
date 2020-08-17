import 'package:flutter/cupertino.dart';

class BooleanEditingController extends ValueNotifier<bool> {
  bool value = false;

  BooleanEditingController() : super(false);
}
