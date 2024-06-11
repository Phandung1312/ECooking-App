import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/core/themes/colors.dart';
import 'package:uq_system_app/core/themes/styles.dart';
import 'package:uq_system_app/core/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final AppTheme darkTheme = AppTheme(
  name: 'dark',
  brightness: Brightness.dark,
  colors: const AppColors(
    primarySwatch: Colors.deepOrange,
    primary: Color(0xFF181818),
    secondary: Color(0xFFD5310E),
    tertiary: Color(0xF6FCD5D1),
    accent: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    secondaryBackground: Color(0xFFF6F1EC),
    backgroundDark: Color(0xFFF1F1F1),
    disabled: Color(0xFFE4E4E4),
    information: Color(0xFF2164FF),
    success: Color(0xFF19C18F),
    alert: Color(0xFFFBA707),
    warning: Color(0xFF9A8978),
    error: Color(0xFFFF0000),
    text: Color(0xFF282828),
    border: Color(0xFF454F60),
    hint: Color(0xFF989898),
    divider: Color(0xFFD9D9D9),
  ),
  typographies: AppTypography(
    title1: GoogleFonts.ptSans(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      height: 1.3,
      color: const Color(0xFF181818),
    ),
    title1SemiBold: GoogleFonts.notoSans(
      fontSize: 32,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: const Color(0xFF181818),
    ),
    title1Normal: GoogleFonts.notoSans(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF181818),
      height: 1.3,
    ),
    title2: GoogleFonts.notoSans(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: const Color(0xFF181818),
      height: 1.3,
    ),
    title2Bold: GoogleFonts.notoSans(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF181818),
      height: 1.3,
    ),
    title3: GoogleFonts.notoSans(
      fontSize: 18,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    title3Bold: GoogleFonts.notoSans(
      fontSize: 18,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w700,
      height: 1.3,
    ),
    body: GoogleFonts.notoSans(
      fontSize: 17,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w400,
      height: 1.3,
    ),
    bodyBold: GoogleFonts.notoSans(
      fontSize: 17,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    button: GoogleFonts.notoSans(
      fontSize: 15,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w400,
      height: 1.3,
    ),
    buttonBold: GoogleFonts.notoSans(
      fontSize: 15,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    caption1: GoogleFonts.notoSans(
      fontSize: 14,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w400,
      height: 1.3,
    ),
    caption1Bold: GoogleFonts.notoSans(
      fontSize: 14,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    caption2: GoogleFonts.notoSans(
      fontSize: 12,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w400,
      height: 1.3,
    ),
    caption2Bold: GoogleFonts.notoSans(
      fontSize: 12,
      color: const Color(0xFF181818),
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
  ),
  styles: AppStyles(
    buttonSmall: ButtonStyle(
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      ),
      shape: const MaterialStatePropertyAll(
        StadiumBorder(),
      ),
      textStyle: MaterialStatePropertyAll(
        GoogleFonts.rubik(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      minimumSize: const MaterialStatePropertyAll(Size.zero),
    ),
    buttonMedium: ButtonStyle(
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      shape: const MaterialStatePropertyAll(
        StadiumBorder(),
      ),
      textStyle: MaterialStatePropertyAll(
        GoogleFonts.rubik(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      minimumSize: const MaterialStatePropertyAll(Size.zero),
    ),
    buttonLarge: ButtonStyle(
      padding: const MaterialStatePropertyAll(
        EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      ),
      shape: const MaterialStatePropertyAll(
        StadiumBorder(),
      ),
      textStyle: MaterialStatePropertyAll(
        GoogleFonts.rubik(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
      minimumSize: const MaterialStatePropertyAll(Size.zero),
    ),
    buttonText: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      // splashFactory: NoSplash.splashFactory,
      textStyle: MaterialStatePropertyAll(
        GoogleFonts.rubik(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
      ),
    ),
    shadow: const [
      BoxShadow(
        color: Color(0xFFFFFFFF),
        offset: Offset(0, 4),
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  ),
);

class AppTheme extends ThemeExtension<AppTheme> {
  static final AppTheme dark = darkTheme;
  static final AppTheme defaultTheme = darkTheme;

  final String name;
  final Brightness brightness;
  final AppColors colors;
  final AppTypography typographies;
  final AppStyles styles;

  const AppTheme({
    required this.name,
    required this.brightness,
    required this.colors,
    required this.typographies,
    required this.styles,
  });

  ColorScheme get _baseColorScheme => brightness == Brightness.dark
      ? const ColorScheme.dark() //
      : const ColorScheme.light();

  ThemeData get themeData => ThemeData(
        platform: TargetPlatform.iOS,
        extensions: [this],
        primarySwatch: colors.primarySwatch,
        primaryColor: colors.primary,
        unselectedWidgetColor: colors.hint,
        disabledColor: colors.disabled,
        scaffoldBackgroundColor: colors.background,
        hintColor: colors.hint,
        dividerColor: colors.border,
        colorScheme: _baseColorScheme.copyWith(
          primary: colors.primary,
          onPrimary: colors.text,
          secondary: colors.secondary,
          onSecondary: colors.text,
          error: colors.error,
          shadow: colors.border,
          background: colors.background,
          onBackground: colors.text,
        ),
        textTheme: TextTheme(
          bodyMedium: typographies.body.withColor(colors.text),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: colors.background,
          surfaceTintColor: colors.background,
          titleTextStyle: typographies.title3,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.white;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return colors.secondary;
            }
            return colors.hint.withOpacity(0.5);
          }),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: typographies.body.withColor(colors.secondary),
          unselectedLabelStyle: typographies.body.withColor(colors.secondary),
          labelColor: colors.accent,
          unselectedLabelColor: colors.hint,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: styles.buttonLarge.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.disabled)
                  ? colors.disabled
                  : null; // Defer to the widget's default.
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.disabled)
                  ? colors.text
                  : null; // Defer to the widget's default.
            }),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: styles.buttonLarge.copyWith(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.disabled)
                  ? colors.disabled
                  : colors.background; // Defer to the widget's default.
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.disabled)
                  ? colors.text
                  : null; // Defer to the widget's default.
            }),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: styles.buttonLarge.copyWith(
            side: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(color: colors.disabled);
              }

              if (states.isEmpty ||
                  [
                    MaterialState.pressed,
                    MaterialState.hovered,
                    MaterialState.focused,
                  ].any(states.contains)) {
                return BorderSide(color: colors.primary);
              }

              return null;
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.disabled)
                  ? colors.disabled
                  : null; // Defer to the widget's default.
            }),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: styles.buttonLarge.copyWith(
            foregroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.disabled)
                  ? colors.disabled
                  : null; // Defer to the widget's default.
            }),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          errorMaxLines: 0,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
          hintStyle: typographies.body.withColor(colors.hint),
          labelStyle: typographies.body.withColor(colors.hint),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          border: InputBorder.none,
          filled: true,
          fillColor: const Color(0xFFF6F1EC),
          errorStyle: typographies.caption2,
        ),
        checkboxTheme: CheckboxThemeData(
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(color: colors.border),
        ),
        radioTheme: const RadioThemeData(
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        ),
        dialogBackgroundColor: colors.background,
        dialogTheme: DialogTheme(
          backgroundColor: colors.background,
          surfaceTintColor: colors.background,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colors.background,
          elevation: 1,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: colors.primary,
          unselectedItemColor: colors.border,
          selectedIconTheme: IconThemeData(size: 32, color: colors.primary),
          unselectedIconTheme: IconThemeData(size: 32, color: colors.border),
          selectedLabelStyle:
              typographies.caption2Bold.withColor(colors.secondary),
          unselectedLabelStyle:
              typographies.caption2Bold.withColor(colors.secondary),
          type: BottomNavigationBarType.fixed,
        ),
        dividerTheme: DividerThemeData(
          color: colors.border,
          thickness: 1,
          space: 1,
        ),
        tooltipTheme: TooltipThemeData(
          preferBelow: true,
          showDuration: const Duration(seconds: 2),
          textStyle: typographies.caption2.withColor(colors.hint),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: colors.backgroundDark,
                offset: Offset.zero,
                blurRadius: 20,
              )
            ],
          ),
        ),
      );

  @override
  AppTheme copyWith({
    String? name,
    AppColors? colors,
    AppTypography? typographies,
    AppStyles? styles,
  }) {
    return AppTheme(
      brightness: brightness,
      name: name ?? this.name,
      colors: colors ?? this.colors,
      typographies: typographies ?? this.typographies,
      styles: styles ?? this.styles,
    );
  }

  @override
  AppTheme lerp(covariant ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      brightness: brightness,
      name: name,
      colors: colors.lerp(other.colors, t),
      typographies: typographies.lerp(other.typographies, t),
      styles: styles,
    );
  }
}
