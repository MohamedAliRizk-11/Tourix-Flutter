import 'package:flutter/material.dart';
//import '../../../core/constants/app_spacing.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_balance,
                  color: AppColors.primaryGold,
                  size: 78,
                ),

                const SizedBox(height: 18),

                Text(
                  'TOURIX',
                  style: AppTextStyles.displayLarge.copyWith(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryGold,
                    letterSpacing: 2,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Explore the Secrets of the Pharaohs',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading.copyWith(
                    fontSize: 24,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 90),

                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: PrimaryButton(
                    label: 'BEGIN JOURNEY',
                    icon: Icons.arrow_forward,
                    onPressed: () {
                      Navigator.pushNamed(context, RouteNames.signup);
                    },
                  ),
                ),

                const SizedBox(height: 28),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.login);
                  },
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                      children: [
                        const TextSpan(text: 'Already a Noble Voyager? '),
                        TextSpan(
                          text: 'Sign In',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
