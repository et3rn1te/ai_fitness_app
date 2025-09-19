import 'package:flutter/material.dart';
import '../../widgets/common/flowstate_app_bar.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/flowstate_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;
  final ThemeMode currentTheme;

  const ProfileScreen({
    super.key,
    required this.onThemeChanged,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlowstateAppBar(title: 'My Profile'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User info section
          Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              // User details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Intermediate Level',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Theme toggle section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Appearance'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      currentTheme == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      currentTheme == ThemeMode.dark
                          ? 'Dark Mode'
                          : 'Light Mode',
                    ),
                    trailing: Switch(
                      value: currentTheme == ThemeMode.dark,
                      onChanged: (bool value) {
                        onThemeChanged(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      bottomNavigationBar: FlowstateBottomNavBar(
        currentIndex: 2, // Profile tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/training');
              break;
            case 2:
              Navigator.pushNamed(context, '/pose');
              break;
          }
        },
      ),
    );
  }
}
