import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/presentation/screens/screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: false,
        title: Text(
          'Search',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: CupertinoSearchTextField(
              keyboardType: TextInputType.name,
              controller: _searchController,
              itemColor: Theme.of(context).colorScheme.primary,
              onChanged: (value) {
                setState(() {
                  _searchController.text = value;
                });
              },
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('username', isGreaterThanOrEqualTo: _searchController.text)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!.docs as dynamic;
          return ListView.builder(
            itemCount: users.length,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        uid: user['uid'],
                      ),
                    ),
                  );
                },
                leading: Hero(
                  tag: user['uid'],
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(user['imageUrl']),
                  ),
                ),
                title: Text(
                  user['username'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
