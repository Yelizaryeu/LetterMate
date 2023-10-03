import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:chats_view/chats_view.dart';
import 'package:profile_view/profile_view.dart';
import 'package:auto_route/auto_route.dart';


class HomeScreenApp extends StatelessWidget {
  const HomeScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        ChatsViewRoute(),
        ProfileViewRoute(),
    ],
        bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
            // here we switch between tabs
            tabsRouter.setActiveIndex(index);
            },
          backgroundColor: Colors.grey.shade400,
            items: const [
            BottomNavigationBarItem(label: 'Chats', icon: Icon(Icons.message_rounded),),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person),),
            ],
        );
        }
    );
  }

//   @override
//   State<HomeScreen> createState() =>
//       _HomeScreenState();
// }

// class _HomeScreenState
//     extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static List<Widget> _widgetOptions = <Widget>[
//
//     ChatsViewScreen(),
//     ProfileViewScreen(),
//
//     //ChatsViewScreen(),
//     //ChatsPage(),
//     //ProfilePage(),
//   ];
//
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

  // @override
  // Widget build(BuildContext context) {
  //   // return AutoTabsRouter(
  //   //     // list of your tab routes
  //   //     // routes used here must be declared as children
  //   //     // routes of /dashboard
  //   //     routes: const [
  //   //     UsersRoute(),
  //   // PostsRoute(),
  //   // SettingsRoute(),
  //   // ],
  //   // transitionBuilder: (context,child,animation)=> FadeTransition(
  //   // opacity: animation,
  //   // // the passed child is technically our animated selected-tab page
  //   // child: child,
  //   // ),
  //   // builder: (context, child) {
  //   // // obtain the scoped TabsRouter controller using context
  //   // final tabsRouter = AutoTabsRouter.of(context);
  //   // // Here we're building our Scaffold inside of AutoTabsRouter
  //   // // to access the tabsRouter controller provided in this context
  //   // //
  //   // //alterntivly you could use a global key
  //   // return Scaffold(
  //   // body: child,
  //   // bottomNavigationBar: BottomNavigationBar(
  //   // currentIndex: tabsRouter.activeIndex,
  //   // onTap: (index) {
  //   // // here we switch between tabs
  //   // tabsRouter.setActiveIndex(index);
  //   // },
  //   // items: [
  //   // BottomNavigationBarItem(label: 'Chats',...),
  //   // BottomNavigationBarItem(label: 'Profile',...),
  //   // ],
  //   // ));
  //
  //   return Scaffold(
  //     body: Center(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       items: const <BottomNavigationBarItem>[
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.message_rounded),
  //           label: 'Chats',
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           label: 'Profile',
  //         ),
  //       ],
  //       currentIndex: _selectedIndex,
  //       selectedItemColor: Colors.amber[800],
  //       onTap: _onItemTapped,
  //     ),
  //   );
  // }
}






// import 'package:core/core.dart';
// import 'package:core/di/app_di.dart';
// import 'package:core_ui/core_ui.dart';
// import 'package:domain/usecases/export_usecases.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:home/src/bloc/bloc.dart';
// import 'package:navigation/navigation.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => HomeScreenState();
// }
//
// class HomeScreenState extends State<HomeScreen> {
//   final TextEditingController searchController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AlbumBloc>(
//       create: (BuildContext context) => AlbumBloc(
//         getAllAlbumsUseCase: appLocator.get<FetchAllAlbumsUseCase>(),
//         getSearchAlbumsUseCase: appLocator.get<FetchSearchAlbumsUseCase>(),
//       )..add(
//           InitEvent(),
//         ),
//       child: SafeArea(
//         child: Scaffold(
//           appBar: CustomAppBar(
//             title: 'albums'.tr(),
//           ),
//           backgroundColor: AppTheme.backgroundColor,
//           body: BlocBuilder<AlbumBloc, AlbumState>(
//             builder: (BuildContext contextWidget, AlbumState state) {
//               if (state is ErrorState) {
//                 return Center(
//                   child: Text(state.errorMessage),
//                 );
//               }
//               if (state is LoadingState) {
//                 return const AppLoaderCenterWidget();
//               }
//               if (state is EmptyState) {
//                 return Center(
//                   child: AppButtonWidget(
//                     label: 'load'.tr(),
//                     onTap: () {
//                       BlocProvider.of<AlbumBloc>(context).add(
//                         InitEvent(),
//                       );
//                     },
//                   ),
//                 );
//               }
//               if (state is LoadedState) {
//                 return ListView(
//                   shrinkWrap: true,
//                   padding: const EdgeInsets.all(10),
//                   children: <Widget>[
//                     AppSearchTextFieldWidget(
//                       controller: searchController,
//                       onSearch: (String text) => _searchAlbum(
//                         contextWidget: contextWidget,
//                         text: text,
//                       ),
//                       hint: 'searchAlbum'.tr(),
//                     ),
//                     if (searchController.text.isNotEmpty)
//                       AppButtonWidget(
//                         label: 'clear'.tr(),
//                         onTap: () => _clearSearch(
//                           contextWidget: contextWidget,
//                         ),
//                       ),
//                     ...List.generate(
//                       state.albums.length,
//                       (index) => AlbumElementWidget(
//                         onTap: () {
//                           context.pushRoute(
//                             AlbumViewRoute(albumId: state.albums[index].id),
//                           );
//                         },
//                         album: state.albums[index],
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               return Container();
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _searchAlbum({required BuildContext contextWidget, required String text}) {
//     BlocProvider.of<AlbumBloc>(contextWidget).add(
//       SearchEvent(text),
//     );
//   }
//
//   void _clearSearch({required BuildContext contextWidget}) {
//     searchController.clear();
//     BlocProvider.of<AlbumBloc>(contextWidget).add(
//       SearchEvent(''),
//     );
//   }
// }
