import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF9872EB).withOpacity(0.3),
            offset: Offset(-4, -4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Color(0xFFE871C5).withOpacity(0.3),
            offset: Offset(4, 4),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[400],
        currentIndex: currentIndex,
        onTap: (index) {
          onTap(index);
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/chatlist');
              break;
            case 1:
              Navigator.pushNamed(context, '/fling');
              break;
            case 2:
              Navigator.pushNamed(context, '/vibe');
              break;
            case 3:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 9),
              child: _buildIcon('chat', 'chatc', currentIndex == 0),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 9),
              child: _buildIcon('fling', 'flingc', currentIndex == 1),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 9),
              child: _buildIcon('vibe', 'vibec', currentIndex == 2),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Transform.translate(
              offset: Offset(0, 9),
              child: _buildIcon('me', 'mec', currentIndex == 3),
            ),
            label: '',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String inactiveIcon, String activeIcon, bool isActive) {
    return Image.asset(
      isActive
          ? 'lib/assets/icons/$activeIcon.png' // সক্রিয় অবস্থায়
          : 'lib/assets/icons/$inactiveIcon.png', // নিষ্ক্রিয় অবস্থায়
      width: 24,
      height: 24,
    );
  }
}
