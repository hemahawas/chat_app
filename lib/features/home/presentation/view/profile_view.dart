import 'package:chat_app/core/constants/app_sizes.dart';
import 'package:chat_app/core/shared_widgets/custom_circular_progress_indicator.dart';
import 'package:chat_app/core/shared_widgets/custom_snack_bar.dart';
import 'package:chat_app/core/themes/styles.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_appbar.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_image_and_modify.dart';
import 'package:chat_app/features/home/presentation/view/widgets/profile_name_field.dart';
import 'package:chat_app/features/home/presentation/view/widgets/separating_line.dart';
import 'package:chat_app/features/home/presentation/view_model/cubit.dart';
import 'package:chat_app/features/home/presentation/view_model/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    final homeAppBarContext =
        ModalRoute.of(context)!.settings.arguments as BuildContext;

    return BlocProvider.value(
      value: BlocProvider.of<HomeViewModel>(homeAppBarContext),
      child: BlocConsumer<HomeViewModel, HomeStates>(
        listener: (context, state) {
          if (state is DeleteAccountLoadingState) {
            showDialog(
                context: context,
                builder: (context) => CustomCircularProgressIndicator());
          }
          if (state is DeleteAccountSuccessState) {
            CustomSnackBar.show(
                message: 'Accounted is deleted Successfully',
                context: context,
                color: Colors.redAccent);
          }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<HomeViewModel>(context);
          nameController.text = cubit.currentUser.name;
          phoneController.text = cubit.currentUser.phone;

          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(AppSizes.toolBarHieght),
                child: const ProfileAppbar()),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: ProfileImageAndModify(
                        userProfileImage: cubit.currentUser.image,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const SeparatingLine(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Name',
                      style: Styles.textStyle24.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    AbsorbPointer(
                        child:
                            ProfileInputField(inputController: nameController)),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Phone',
                      style: Styles.textStyle24.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    AbsorbPointer(
                        child: ProfileInputField(
                            inputController: phoneController)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
