import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../routing/routing.dart';
import '../../../../shared/shared.dart';
import '../../application/notifiers.dart';
import 'login.dart';

class SignUpPage extends ConsumerWidget {
  static const route = '/auth';

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(signupViewModelProvider.select((vm) => vm.uiState),
        (previous, next) {
      if (next.isSuccess) {
        TextInput.finishAutofillContext();
        context.pushNamed(LoginPage.route);
        return;
      }
    });
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
                autovalidateMode: AutovalidateMode.onUnfocus,
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
                          'Sign up to your account',
                          style: Theme.of(context).textTheme.titleMedium?.semi,
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
                          child: Text('Log in'),
                        ),
                      ),
                      const Spacer(),
                      FilledButton(
                        onPressed:
                            ref.read(signupViewModelProvider.notifier).signup,
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
                                Constants.smallHorizontalGutter.horizontalSpace,
                                child!,
                              ],
                            );
                          }
                          return child!;
                        }),
                        child: Text('Continue'),
                      ),
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
