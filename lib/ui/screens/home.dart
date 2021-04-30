import 'package:flutter/material.dart';
import 'package:iem_space_x/core/viewmodel/launch_viewmodel.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LaunchViewModel(),
      child: Consumer<LaunchViewModel>(
        builder: (context, LaunchViewModel model, child) => Scaffold(
          appBar: AppBar(
            title: Text("SpaceX"),
          ),
          body: model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, position) => Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: Text(model.launches[position].name),
                  ),
                  itemCount: model.launches.length,
                ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.notifications),
            onPressed: () {
              model.showTestNotification();
            },
          ),
        ),
      ),
    );
  }
}
