import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routing/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/explorer_id_generator.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_card.dart';
import '../../../core/widgets/section_divider.dart';
import '../../../core/widgets/social_login_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => AuthCubit(), child: const _SignupView());
  }
}

class _SignupView extends StatefulWidget {
  const _SignupView();

  @override
  State<_SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<_SignupView> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final TextEditingController _explorerIdController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _explorerIdController = TextEditingController(
      text: ExplorerIdGenerator.generate(),
    );
  }

  void _regenerateExplorerId() {
    setState(() {
      _explorerIdController.text = ExplorerIdGenerator.generate();
    });
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _explorerIdController.dispose();
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
                children: [
                  Text('TOURIX', style: AppTextStyles.displayLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Create Your Legacy', style: AppTextStyles.heading),
                  const SizedBox(height: AppSpacing.xl),

                  AuthCard(
                    child: Column(
                      children: [
                        AppTextField(
                          label: 'Full Name',
                          hint: 'Amon-Ra Vance',
                          prefixIcon: Icons.person_outline,
                          controller: _fullNameController,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: 'Email Address',
                          hint: 'voyager@nile.com',
                          prefixIcon: Icons.alternate_email,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: 'Password',
                          hint: '••••••••',
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
                        const SizedBox(height: AppSpacing.md),
                        AppTextField(
                          label: 'Explorer ID',
                          hint: 'TX-992-DELTA',
                          prefixIcon: Icons.fingerprint,
                          controller: _explorerIdController,
                          readOnly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.auto_awesome,
                              color: AppColors.accentTeal,
                              size: 18,
                            ),
                            onPressed: _regenerateExplorerId,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Unique identifier for Oracle-assisted itineraries.',
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        PrimaryButton(
                          label: 'Start Your Odyssey',
                          icon: Icons.arrow_forward,
                          isLoading: isLoading,
                          onPressed: () {
                            context.read<AuthCubit>().signup(
                              fullName: _fullNameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const SectionDivider(label: 'OR'),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            Expanded(
                              child: SocialLoginButton(
                                icon: Text(
                                  'G',
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    color: const Color(0xFFDB4437),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                label: 'Google',
                                onPressed: () {},
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: SocialLoginButton(
                                icon: const Icon(
                                  Icons.account_balance,
                                  color: AppColors.textPrimary,
                                  size: 18,
                                ),
                                label: 'Privilege',
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RouteNames.login),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodyMedium,
                        children: [
                          const TextSpan(text: 'Already an explorer? '),
                          TextSpan(
                            text: 'Sign In',
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
