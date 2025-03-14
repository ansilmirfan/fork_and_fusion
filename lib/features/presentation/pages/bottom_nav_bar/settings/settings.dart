// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fork_and_fusion/core/services/services.dart';
import 'package:fork_and_fusion/core/shared/constants.dart';
import 'package:fork_and_fusion/features/domain/usecase/Auth%20usecase/signout_usecase.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/settings_data.dart';
import 'package:fork_and_fusion/features/presentation/pages/bottom_nav_bar/settings/widgets/settings_listtile.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custom_alert_dialog.dart';
import 'package:fork_and_fusion/features/presentation/widgets/custom_circle_avathar.dart';
import 'package:fork_and_fusion/features/presentation/widgets/overlay_loading.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    hideLoadingOverlay();
    var email = Constants.user?.email;
    var image = Constants.user?.image;
    var gap = const SizedBox(height: 10);

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildUserProfile(image, email, context, gap),
              _buildSettingsList(gap),
              gap,
              _buildLogOutListTile(context),
            ],
          ),
        ),
      ),
    );
  }

  SettingsListTile _buildLogOutListTile(BuildContext context) {
    return SettingsListTile(
      icon: Icons.logout,
      text: 'Logout',
      onTap: () => _showLogOutConfiremationDialog(context),
    );
  }

  void _showLogOutConfiremationDialog(BuildContext context) {
    return showCustomAlertDialog(
      context: context,
      title: 'Confirm Logout',
      description:
          'Are you sure you want to log out? Any unsaved changes will be lost, and you\'ll need to sign in again to access your account.',
      onPressed: () async {
        SignoutUsecase usecase = SignoutUsecase(Services.firebaseRepo());
        await usecase.call();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/signin',
          (route) => false,
        );
      },
    );
  }

  ListView _buildSettingsList(SizedBox gap) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SettingsListTile(
        icon: SettingsData.iconData[index],
        text: SettingsData.title[index],
        onTap: () =>
            Navigator.of(context).pushNamed(SettingsData.navigate[index]),
      ),
      separatorBuilder: (context, index) => gap,
      itemCount: SettingsData.iconData.length,
    );
  }

  Column _buildUserProfile(
      String? image, String? email, BuildContext context, SizedBox gap) {
    return Column(children: [
      image != null
          ? CustomCircleAvathar(url: image, radius: 60)
          : CircleAvatar(
              radius: 60,
              child: Text(
                email?[0].toUpperCase() ?? '',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
      Text(email ?? ''),
      gap,
    ]);
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
