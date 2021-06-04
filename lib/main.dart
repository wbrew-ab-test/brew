import 'package:brew/bindings/brewbind.dart';
import 'package:brew/views/brew.dart';
import 'package:flutter/material.dart';

void main() async {
  BrewBind().dependencies();
  runApp(Brew());
}
