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
class SetupScreen extends StatefulHookConsumerWidget {
  const SetupScreen({required this.onDone, super.key});

  final Function(bool) onDone;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
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
                  'Appwrite Workbench Setup',
                  style: ShadTheme.of(context).textTheme.h1.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFF02D65),
                      ),
                ),
                const Divider(),
                const Gap(16),
                const ShadDialog.alert(
                  title: Text('Important: Choose a Unique Password'),
                  description: Text(
                    'Your password acts as a unique key to your secret box. It is crucial to choose a password that is unique and memorable. Once set, if you forget this key, there is no way to recover the contents of your secret box. Please ensure your password is kept secure and unforgettable.',
                  ),
                ),
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
                  placeholder:
                      const Text('Enter your password (root is default)'),
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
                  text: const Text('Setup'),
                  onPressed: () async {
                    if (formKey.currentState!.saveAndValidate()) {
                      final data = formKey.currentState!.value;
                      await ref.read(authControllerProvider).setupNotify(
                          username: data['username'] as String,
                          password: (data['password'] as String?) ?? 'root',
                          onError: () {
                            widget.onDone.call(false);
                          },
                          onSuccessfull: () {
                            widget.onDone.call(true);
                          });
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
