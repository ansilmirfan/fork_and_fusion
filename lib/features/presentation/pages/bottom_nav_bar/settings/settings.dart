import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/settings_data.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/widgets/settings_listtile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var gap = const SizedBox(height: 10);

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(Constants.image),
              ),
              const Text('useremail@gmail.com'),
              gap,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => SettingsListTile(
                  icon: SettingsData.iconData[index],
                  text: SettingsData.title[index],
                  onTap: SettingsData.onTap[index],
                ),
                separatorBuilder: (context, index) => gap,
                itemCount: SettingsData.iconData.length,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Settings'),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
