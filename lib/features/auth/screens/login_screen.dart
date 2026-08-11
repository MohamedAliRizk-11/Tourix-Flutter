import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_card.dart';
import '../../../core/widgets/section_divider.dart';
import '../../../core/widgets/social_login_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthCubit(), child: const _LoginView());
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.mainShell,
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('TOURIX', style: AppTextStyles.displayLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Welcome Back, Explorer', style: AppTextStyles.heading),
                  const SizedBox(height: AppSpacing.xl),

                  AuthCard(
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Credentials of Passage',
                          hint: 'email@voyage.com',
                          prefixIcon: Icons.alternate_email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Secret Key', style: AppTextStyles.bodyMedium),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteNames.forgotPassword,
                              ),
                              child: Text(
                                'Lost Key?',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.accentTeal,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AppTextField(
                          label: '',
                          hint: '••••••',
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.textMuted,
                              size: 20,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PrimaryButton(
                          label: 'UNLOCK PORTAL',
                          icon: Icons.arrow_forward,
                          isLoading: isLoading,
                          onPressed: () {
                            context.read<AuthCubit>().login(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const SectionDivider(label: 'SHARED LINEAGE'),
                        const SizedBox(height: AppSpacing.lg),
                        SocialLoginButton(
                          icon: Text(
                            'G',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: const Color(0xFFDB4437),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          label: 'Continue with Google',
                          onPressed: () {},
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SocialLoginButton(
                          icon: const Icon(
                            Icons.apple,
                            color: AppColors.textPrimary,
                            size: 20,
                          ),
                          label: 'Continue with Apple',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, RouteNames.signup),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium,
                        children: [
                          const TextSpan(text: 'New to the dynasty? '),
                          TextSpan(
                            text: 'Initiate Membership',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primaryGold,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
