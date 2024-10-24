import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routing/routing.dart';
import '../../../../shared/shared.dart';
import 'package:flutter/material.dart';

import '../../../dashboard/dashboard.dart';
import '../../application/notifiers.dart' hide signupViewModelProvider;

class LoginPage extends ConsumerStatefulWidget {
  static const route = '/auth/login';

  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> with MHelpers {
  final emailAddress = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    super.initState();

    ref.listenManual(loginViewModelProvider.select((vm) => vm.uiState),
        (previous, next) {
      if (next.isSuccess) {
        TextInput.finishAutofillContext();
        context.pushNamedAndPopAll(DashboardPage.route);
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
    return Scaffold(
      appBar: AppBar(leading: const BushaBackButton()),
      body: AbsorbPointer(
        absorbing: ref
            .watch(loginViewModelProvider.select((vm) => vm.uiState.isLoading)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.scaffoldMargin,
            ),
            child: Form(
              autovalidateMode: ref.watch(
                      loginViewModelProvider.select((vm) => vm.showFormErrors))
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUnfocus,
              child: AutofillGroup(
                child: FocusTraversalGroup(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: Constants.verticalGutter,
                          bottom: Constants.smallVerticalGutter,
                        ),
                        child: Text(
                          'Log in to your account',
                          style: Theme.of(context).textTheme.titleMedium?.semi,
                        ),
                      ),
                      Text(
                        'Welcome back! Please enter your registered email address to continue',
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
                          AutofillHints.username,
                          AutofillHints.email
                        ],
                        textInputAction: TextInputAction.next,
                        onChanged: ref
                            .read(loginViewModelProvider.notifier)
                            .emailAddressOnChanged,
                        validator: (_) => ref
                            .read(loginViewModelProvider)
                            .loginForm
                            .emailAddress
                            .failureOrNone
                            .fold(() => null, (failure) => failure.message),
                      ),
                      Constants.verticalGutter.verticalSpace,
                      PasswordTextFormField(
                        controller: password,
                        autofillHints: const [AutofillHints.password],
                        onChanged: ref
                            .read(loginViewModelProvider.notifier)
                            .passwordOnChanged,
                        validator: (_) => ref
                            .read(loginViewModelProvider)
                            .loginForm
                            .password
                            .failureOrNone
                            .fold(() => null, (failure) => failure.message),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed: () {
                          unfocus();
                          ref.read(loginViewModelProvider.notifier).login();
                        },
                        style: FilledButton.styleFrom(
                            foregroundBuilder: (context, states, child) {
                          if (ref.watch(loginViewModelProvider
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
                                Constants.smallHorizontalGutter.horizontalSpace,
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
    );
  }
}
