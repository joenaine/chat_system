import 'package:auto_route/auto_route.dart';
import 'package:chat_system/presentation/auth/login/login_page.dart';
import 'package:chat_system/presentation/auth/register/register_page.dart';
import 'package:chat_system/presentation/chat/chat_page.dart';
import 'package:flutter/material.dart';
part 'routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.adaptive(); //.cupertino, .adaptive ..etc

  @override
  final List<AutoRoute> routes = [
    AdaptiveRoute(page: LoginRoute.page, initial: true),
    AdaptiveRoute(page: RegisterRoute.page),
    AdaptiveRoute(page: ChatRoute.page),
  ];
}
