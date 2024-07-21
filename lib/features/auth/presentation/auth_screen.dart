import 'package:appwrite_workbench/core/auth_controller.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:toastification/toastification.dart';

@RoutePage()
class AuthScreen extends StatefulHookConsumerWidget {
  const AuthScreen({required this.onDone, super.key});

  final Function(bool) onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final formKey = GlobalKey<ShadFormState>();
  @override
  Widget build(BuildContext context) {
    final isObscure = useState(true);
    return Scaffold(
      body: Center(
        child: MaxWidthBox(
          maxWidth: 400,
          child: ShadForm(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Appwrite Builder Login',
                  style: ShadTheme.of(context).textTheme.h1.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFF02D65),
                      ),
                ),
                const Divider(),
                const Gap(16),
                ShadInputFormField(
                  id: 'username',
                  label: const Text('Username'),
                  initialValue: 'root',
                  placeholder: const Text('Enter your username'),
                  validator: (v) {
                    if (v.length < 2) {
                      return 'Username must be at least 2 characters.';
                    }
                    return null;
                  },
                ),
                const Gap(16),
                ShadInputFormField(
                  id: 'password',
                  obscureText: isObscure.value,
                  label: const Text('Password'),
                  placeholder: const Text('Enter your password'),
                  validator: (v) {
                    if (v.length < 2) {
                      return 'Password must be at least 2 characters.';
                    }
                    return null;
                  },
                  suffix: ShadButton(
                    width: 24,
                    height: 24,
                    padding: EdgeInsets.zero,
                    decoration: const ShadDecoration(
                      secondaryBorder: ShadBorder.none,
                      secondaryFocusedBorder: ShadBorder.none,
                    ),
                    icon: ShadImage.square(
                      size: 16,
                      isObscure.value ? LucideIcons.eyeOff : LucideIcons.eye,
                    ),
                    onPressed: () {
                      isObscure.value = !isObscure.value;
                    },
                  ),
                ),
                const Gap(16),
                ShadButton(
                  width: double.infinity,
                  text: const Text('Login'),
                  onPressed: () async {
                    if (formKey.currentState!.saveAndValidate()) {
                      final data = formKey.currentState!.value;
                      await ref.read(authControllerProvider).loginNotify(
                            username: data['username'] as String,
                            password: data['password'] as String,
                            onSuccess: () {
                              widget.onDone.call(true);
                              toastification.show(
                                title: const Text('Login successful'),
                                description: const Text(
                                    'You have successfully logged in.'),
                                type: ToastificationType.success,
                              );
                            },
                            onError: () {
                              widget.onDone.call(false);
                              toastification.show(
                                title: const Text('Login failed'),
                                description: const Text(
                                    'Please check your credentials and try again.'),
                                type: ToastificationType.error,
                              );
                            },
                          );
                    } else {
                      toastification.show(
                        title: const Text('Please fill all fields'),
                        description: const Text(
                            'Please fill all fields before submitting.'),
                        type: ToastificationType.error,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
