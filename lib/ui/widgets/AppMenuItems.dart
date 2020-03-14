
import 'package:app_social/ui/pages/friends_page.dart';
import 'package:app_social/ui/pages/home_page.dart';
import 'package:app_social/ui/pages/notifications_page.dart';
import 'package:app_social/ui/pages/profile_page.dart';
import 'package:flutter/material.dart';

const String HOME = 'home';
const String FRIENDS = 'friends';
const String PROFILE = 'profile';
const String NOTIFICATIONS = 'notifications';



Map<String, Widget> menuPages(String userId) => {
  HOME: HomePage(),
  FRIENDS: FriendsPage(),
  PROFILE: ProfilePage(userId),
  NOTIFICATIONS: NotificationsPage()
};