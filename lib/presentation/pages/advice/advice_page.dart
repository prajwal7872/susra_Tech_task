import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:susra_task/presentation/core/services/theme_service.dart';
import 'package:susra_task/presentation/pages/advice/cubit/advicer_cubit.dart';
import 'package:susra_task/presentation/pages/advice/cubit/advicer_state.dart';
import 'package:susra_task/presentation/pages/advice/widgets/custom_button.dart';
import 'package:susra_task/presentation/pages/advice/widgets/error_message.dart';
import 'package:susra_task/injection.dart';
import 'widgets/advice_field.dart';

class AdvicerPageWrapperProvider extends StatelessWidget {
  const AdvicerPageWrapperProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AdvicerCubit>(),
      child: const AdvicerPage(),
    );
  }
}

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;

    // Use relative padding and height based on screen size
    final paddingHorizontal = screenWidth * 0.1; // 10% of screen width
    final buttonHeight = screenHeight * 0.25; // 25% of screen height

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [
          Switch(
              value: Provider.of<ThemeService>(context).isDarkModeOn,
              onChanged: (_) {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: BlocBuilder<AdvicerCubit, AdvicerCubitState>(
                  builder: (context, state) {
                    if (state is AdvicerInitial) {
                      return Text(
                        'Your Advice is waiting for you!',
                        style: themeData.textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      );
                    } else if (state is AdvicerStateLoading) {
                      return CircularProgressIndicator(
                        color: themeData.colorScheme.secondary,
                      );
                    } else if (state is AdvicerStateLoaded) {
                      return AdviceField(
                        advice: state.advice,
                      );
                    } else if (state is AdvicerStateError) {
                      return ErrorMessage(message: state.message);
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            SizedBox(
              height: buttonHeight, // Dynamic height for the button area
              child: Center(
                child: CustomButton(
                  onTap: () =>
                      BlocProvider.of<AdvicerCubit>(context).adviceRequested,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
