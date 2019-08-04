import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped_model/user_model.dart';

class UsersPage extends StatefulWidget {
  final UserModel model;

  UsersPage(this.model);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    super.initState();
    widget.model.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Users'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<UserModel>(
      builder: (BuildContext context, Widget child, UserModel model) {
        Widget content = Text('No users');
        if (model.isLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (!model.isLoading && model.users.length > 0) {
          content = _buildListView(model);
        }
        return content;
      },
    );
  }

  Widget _buildListView(UserModel model) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(model.users[index].login),
          subtitle: Text(model.users[index].nodeId),
        );
      },
      itemCount: model.users.length,
    );
  }
}
