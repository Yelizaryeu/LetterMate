import 'package:auto_route/auto_route.dart';
import 'package:chats_view/chats_view.dart';
import 'package:domain/models/chat/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:profile_view/profile_view.dart';
import 'package:chat_view/chat_view.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute (
      path: '/',
      page: HomeScreen,
      initial: true,
      children: [
        AutoRoute(
          name: 'chatsViewRoute',
          page: ChatsViewScreen,
          path: 'chats_view',
        ),
        AutoRoute(
          name: 'profileViewRoute',
          page: ProfileViewScreen,
          path: 'profile_view',
        ),
      ]
    ),
    AutoRoute(
      name: 'chatViewRoute',
      page: ChatViewScreen,
      path: 'chat_view',
    ),
  ],
)
class AppRouter extends _$AppRouter {}



// part 'app_router.gr.dart';
//
// @AutoRouterConfig()
// class AppRouter extends _$AppRouter {
//
//   @override
//   List<AutoRoute> get routes => [
//     // AutoRoute(
//     //   path: '/',
//     //   page: HomeScreen,
//     //   initial: true,
//     // ),
//     // AutoRoute(
//     //   name: 'chatsViewRoute',
//     //   page: ChatsViewScreen,
//     //   path: 'chats_view/:id',
//     // ),
//     // AutoRoute(
//     //   name: 'chatViewRoute',
//     //   page: ChatViewScreen,
//     //   path: 'chat_view',
//     // ),
//   ];
// }

