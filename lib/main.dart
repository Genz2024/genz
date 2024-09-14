import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';
import 'login_verification_page.dart';
import 'signup_verification_page.dart';
import 'chat_page.dart';
import 'chatlist_page.dart';
import 'widgets/chat/profile_view.dart';
import 'widgets/chat/block_user.dart';
import 'widgets/chat/report_user.dart';
import 'widgets/chat/money_page.dart';
import 'fling_page.dart';
import 'vibe_page.dart';
import 'widgets/vibes/moments.dart';
import 'widgets/vibes/threads/thread_list_page.dart';
import 'widgets/vibes/threads/comment_page.dart';
import 'widgets/vibes/threads/create_thread.dart';
import 'widgets/vibes/vibe_video_page.dart';
import 'widgets/vibes/search_page.dart';
import 'widgets/vibes/scanner_page.dart';
import 'widgets/vibes/create_event_page.dart';
import 'widgets/vibes/event_discovery_page.dart';
import 'me_page.dart';
import 'widgets/me/edit_profile_page.dart';
import 'widgets/me/about_me_page.dart';
import 'widgets/me/pay_services_page.dart';
import 'widgets/me/my_moments_page.dart';
import 'widgets/me/settings_page.dart';
import 'greeting_page.dart';
import 'user_profile_page.dart';
import 'widgets/chatlist/add_contact_page.dart';

void main() {
  runApp(GenZApp());
}

class GenZApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenZ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/login_verification': (context) => (ModalRoute.of(context)?.settings.arguments != null)
            ? LoginVerificationPage(
                countryCode: (ModalRoute.of(context)?.settings.arguments as Map)['countryCode'],
                countryName: (ModalRoute.of(context)?.settings.arguments as Map)['countryName'],
                phoneNumber: (ModalRoute.of(context)?.settings.arguments as Map)['phoneNumber'],
              )
            : LoginVerificationPage(
                countryCode: '+880',
                countryName: 'Bangladesh',
                phoneNumber: '017XXXXXXXX',
              ),
        '/signup': (context) => SignUpPage(),
        '/signup_verification': (context) => (ModalRoute.of(context)?.settings.arguments != null)
            ? SignUpVerificationPage(
                countryCode: (ModalRoute.of(context)?.settings.arguments as Map)['countryCode'],
                countryName: (ModalRoute.of(context)?.settings.arguments as Map)['countryName'],
                phoneNumber: (ModalRoute.of(context)?.settings.arguments as Map)['phoneNumber'],
              )
            : SignUpVerificationPage(
                countryCode: '+880',
                countryName: 'Bangladesh',
                phoneNumber: '017XXXXXXXX',
              ),
        '/chatlist': (context) => ChatListPage(),
        '/money': (context) => MoneyPage(),
        '/chat': (context) => ChatPage(
              userName: 'Default User',
              profileImage: 'lib/assets/images/default.jpg',
              lastActive: DateTime.now(),
            ),
        '/profile_view': (context) => ProfileView(
              userName: 'Default User',
              profileImage: 'lib/assets/images/default.jpg',
            ),
        '/block_user': (context) => BlockUser(
              userName: 'Default User',
            ),
        '/report_user': (context) => ReportUser(
              userName: 'Default User',
            ),
        '/fling': (context) => FlingPage(),
        '/vibe': (context) => VibePage(),
        '/moments': (context) => MomentsPage(),
        '/thread': (context) => ThreadListPage(),
        '/vibes': (context) => VibeVideoPage(),
        '/scan': (context) => ScannerPage(),
        '/search': (context) => SearchPage(),
        '/create_event': (context) => CreateEventPage(),
        '/event_discovery': (context) => EventDiscoveryPage(),
        '/profile': (context) => MePage(),
        '/edit_profile': (context) => EditProfilePage(
              userName: 'Default User',
              userId: 'Default_ID',
            ),
        '/about_me': (context) => AboutMePage(),
        '/pay_services': (context) => PayServicesPage(),
        '/my_moments': (context) => MyMomentsPage(),
        '/settings': (context) => SettingsPage(),
        '/greeting': (context) => GreetingPage(
              userName: 'Default User',
              userImage: 'lib/assets/images/default.jpg',
            ),
        '/user_profile': (context) => UserProfilePage(
              name: 'Default User',
              bio: 'Default Bio',
              study: 'Default Study',
              dob: 'Default DOB',
              status: 'Default Status',
              relationshipStatus: 'Single',
              workAt: 'Default Company',
              workPosition: 'Default Position',
              religion: 'Default Religion',
              language: 'Default Language',
              gender: 'Default Gender',
              image: 'lib/assets/images/default.jpg',
              cover: 'lib/assets/images/default_cover.jpg',
            ),
        '/add_contact': (context) => AddContactPage(userId: 'Default UserID'),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text('Page Not Found')),
          body: Center(child: Text('404 - Page not found!')),
        ),
      ),
    );
  }
}
