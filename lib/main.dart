// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:study_flutter/src/learn/routes/Routes.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home:Tabs(),
      initialRoute: '/',     //初始化的时候加载的路由
      onGenerateRoute: onGenerateRoute
    );
  }
}