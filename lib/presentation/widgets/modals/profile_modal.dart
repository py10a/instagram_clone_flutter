import 'package:flutter/material.dart';

class ProfileModal extends StatefulWidget {
  const ProfileModal({
    super.key,
    required this.scrollController,
    required this.onLogOut,
  });

  final ScrollController scrollController;
  final VoidCallback onLogOut;

  @override
  State<ProfileModal> createState() => _ProfileModalState();
}

class _ProfileModalState extends State<ProfileModal> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        Text(
          'Settings',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Divider(
          color: Colors.grey[400],
          height: 0,
          thickness: 0.5,
        ),
        ListTile(
          title: const Text('Log Out', style: TextStyle(color: Colors.red)),
          onTap: widget.onLogOut,
        ),
      ],
    );
  }
}
