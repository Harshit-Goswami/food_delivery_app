import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/base/show_custom_snackbar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/utils/app_colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../base/custom_loader.dart';
import '../../modals/signup_body_modal.dart';
import '../../widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type your phone number", title: "Phone Number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type your email address", title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than six characters",
            title: "Password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            Get.snackbar("Success", "Registration Successful",
                backgroundColor: Colors.green, colorText: Colors.white);
          } else {
            showCustomSnackBar(status.message);
          }
        });
        // print(signUpBody.toString());
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.screenHeight * .05,
                      ),
                      SizedBox(
                        height: Dimensions.screenHeight * .25,
                        child: const Center(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage("assets/image/logo1.png"),
                          ),
                        ),
                      ),
                      //!Email
                      AppTextField(
                        textController: emailController,
                        icon: Icons.email,
                        hintText: "Email",
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //! Password
                      AppTextField(
                        textController: passwordController,
                        icon: Icons.password,
                        hintText: "Password",
                        isObscure: true,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //! Name
                      AppTextField(
                        textController: nameController,
                        icon: Icons.person,
                        hintText: "Name",
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      //! Phone
                      AppTextField(
                        textController: phoneController,
                        icon: Icons.phone,
                        hintText: "Phone",
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),

                      //! SignUp Button
                      GestureDetector(
                        onTap: () {
                          registration(authController);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                            ),
                            child: BigText(
                              text: "SignUp",
                              color: Colors.white,
                              size: Dimensions.font16 * 2,
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      //! Tag line
                      RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              text: "Have an account already?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20))),
                      SizedBox(
                        height: Dimensions.height30,
                      ),
                      //! sign Up options
                      RichText(
                          text: TextSpan(
                              text: "SignUp using one of the following methods",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font16))),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                        "assets/image/${signUpImages[index]}"),
                                    radius: Dimensions.radius30,
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
