import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routing/routing.dart';
import '../../../../shared/shared.dart';
import '../../application/notifiers.dart';
import 'login.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static const route = '/auth';

  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> with MHelpers {
  final emailAddress = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();
    ref.listenManual(signupViewModelProvider.select((vm) => vm.uiState),
        (previous, next) {
      if (next.isSuccess) {
        TextInput.finishAutofillContext();
        context.pushNamed(LoginPage.route);
        return;
      }
    });
  }

  @override
  void dispose() {
    emailAddress.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false),
        body: AbsorbPointer(
          absorbing: ref.watch(
              signupViewModelProvider.select((vm) => vm.uiState.isLoading)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.scaffoldMargin,
              ),
              child: Form(
                autovalidateMode: ref.watch(signupViewModelProvider
                        .select((vm) => vm.showFormErrors))
                    ? AutovalidateMode.always
                    : AutovalidateMode.onUnfocus,
                child: FocusTraversalGroup(
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Constants.verticalGutter,
                            bottom: Constants.smallVerticalGutter,
                          ),
                          child: Text(
                            'Sign up to your account',
                            style:
                                Theme.of(context).textTheme.titleMedium?.semi,
                          ),
                        ),
                        Text(
                          'Sign up with your email and password',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.regular
                              .copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.6),
                              ),
                        ),
                        Constants.largeVerticalGutter.verticalSpace,
                        EmailTextFormField(
                          controller: emailAddress,
                          autofillHints: const [
                            AutofillHints.newUsername,
                            AutofillHints.email
                          ],
                          textInputAction: TextInputAction.next,
                          onChanged: ref
                              .read(signupViewModelProvider.notifier)
                              .emailAddressOnChanged,
                          validator: (_) => ref
                              .read(signupViewModelProvider)
                              .signUpForm
                              .emailAddress
                              .failureOrNone
                              .fold(() => null, (failure) => failure.message),
                        ),
                        Constants.verticalGutter.verticalSpace,
                        PasswordTextFormField(
                          controller: password,
                          autofillHints: const [AutofillHints.newPassword],
                          onChanged: ref
                              .read(signupViewModelProvider.notifier)
                              .passwordOnChanged,
                          validator: (_) => ref
                              .read(signupViewModelProvider)
                              .signUpForm
                              .password
                              .failureOrNone
                              .fold(() => null, (failure) => failure.message),
                        ),
                        Constants.smallVerticalGutter.verticalSpace,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              context.pushNamed(LoginPage.route);
                            },
                            child: const Text('Log in'),
                          ),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            unfocus();
                            ref.read(signupViewModelProvider.notifier).signup();
                          },
                          style: FilledButton.styleFrom(
                              foregroundBuilder: (context, states, child) {
                            if (ref.watch(signupViewModelProvider
                                .select((vm) => vm.uiState.isLoading))) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator.adaptive(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    valueColor: AlwaysStoppedAnimation(
                                        Theme.of(context).colorScheme.primary),
                                  ),
                                  Constants
                                      .smallHorizontalGutter.horizontalSpace,
                                  child!,
                                ],
                              );
                            }
                            return child!;
                          }),
                          child: const Text('Continue'),
                        ),
                        Constants.smallVerticalGutter.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
