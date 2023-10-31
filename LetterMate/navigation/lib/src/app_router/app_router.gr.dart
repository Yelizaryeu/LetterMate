// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    ChatViewRoute.name: (routeData) {
      final args = routeData.argsAs<ChatViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ChatViewScreen(
          key: args.key,
          chatId: args.chatId,

          ///chatName: args.chatName,
          ///userName: args.userName,
        ),
      );
    },
    ChatsViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ChatsViewScreen(),
      );
    },
    ProfileViewRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ProfileViewScreen(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          HomeRoute.name,
          path: '/',
          children: [
            RouteConfig(
              ChatsViewRoute.name,
              path: 'chats_view',
              parent: HomeRoute.name,
            ),
            RouteConfig(
              ProfileViewRoute.name,
              path: 'profile_view',
              parent: HomeRoute.name,
            ),
          ],
        ),
        RouteConfig(
          ChatViewRoute.name,
          path: 'chat_view',
        ),
      ];
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [ChatViewScreen]
class ChatViewRoute extends PageRouteInfo<ChatViewRouteArgs> {
  ChatViewRoute({
    Key? key,
    required String chatId,
    required String chatName,
    required String userName,
  }) : super(
          ChatViewRoute.name,
          path: 'chat_view',
          args: ChatViewRouteArgs(
            key: key,
            chatId: chatId,
            chatName: chatName,
            userName: userName,
          ),
        );

  static const String name = 'ChatViewRoute';
}

class ChatViewRouteArgs {
  const ChatViewRouteArgs({
    this.key,
    required this.chatId,
    required this.chatName,
    required this.userName,
  });

  final Key? key;

  final String chatId;

  final String chatName;

  final String userName;

  @override
  String toString() {
    return 'ChatViewRouteArgs{key: $key, chatId: $chatId, chatName: $chatName, userName: $userName}';
  }
}

/// generated route for
/// [ChatsViewScreen]
class ChatsViewRoute extends PageRouteInfo<void> {
  const ChatsViewRoute()
      : super(
          ChatsViewRoute.name,
          path: 'chats_view',
        );

  static const String name = 'ChatsViewRoute';
}

/// generated route for
/// [ProfileViewScreen]
class ProfileViewRoute extends PageRouteInfo<void> {
  const ProfileViewRoute()
      : super(
          ProfileViewRoute.name,
          path: 'profile_view',
        );

  static const String name = 'ProfileViewRoute';
}
