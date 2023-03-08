import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'strings.dart' as strings;
import 'member.dart';

class GHFlutter extends StatefulWidget {
  const GHFlutter({super.key});

  @override
  State<GHFlutter> createState() => _GHFlutterState();
}

class _GHFlutterState extends State<GHFlutter> {
  final _members = <Member>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.appTitle),
      ),
      body: ListView.separated(
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int position) {
            return _buildRow(position);
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Widget _buildRow(int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text('${_members[i].firstName} ${_members[i].lastName}', style: _biggerFont),
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(_members[i].avatarURL),
        ),
      ),
    );
  }

  Future<void> _loadData() async {
    const dataUrl = 'https://random-data-api.com/api/v2/users?size=10';
    final response = await http.get(Uri.parse(dataUrl));
    setState(() {
    final dataList = json.decode(response.body) as List;
    for (final item in dataList) {
      final firstName = item['first_name'] as String? ?? '';
      final lastName = item['last_name'] as String? ?? '';
      final avatarURL = item['avatar'] as String? ?? '';
      final member = Member(firstName, lastName, avatarURL);
        _members.add(member);
      }
    });
  }
}