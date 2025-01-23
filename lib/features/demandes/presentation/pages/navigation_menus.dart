import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/features/authentification/presentation/pages/signup_page.dart';

import 'package:demandes/features/budget/presentation/pages/budget_page.dart';
import 'package:demandes/features/budget/presentation/pages/validation_demande_budget_page.dart';
import 'package:demandes/features/demandes/presentation/pages/add_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_initiees.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_comptable.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_coordo.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_raf.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_service_page.dart';
import 'package:demandes/features/demandes/presentation/pages/list_demandes_page.dart';
import 'package:demandes/features/demandes/presentation/pages/user_demandes_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

const List<Widget> userPages = [UserDemandesPage(), AddDemandePage()];

const List<Widget> chefServicePages = [
  DemandeServicePage(),
  DemandesInitieesService(),
  AddDemandePage()
];
const List<Widget> coordonnateurPages = [
  DemandesCoordo(), //A valider
  ListDemandesPage(),
  ValidationDemandeBudgetPage(), // Toutes les demandes
];
const List<Widget> rafPages = [
  DemandesRaf(),
  ListDemandesPage(),
  //AddDemandePage(),
  DemandesInitieesService(),
  BudgetPage(),
];
const List<Widget> comptablePages = [
  AddDemandePage(),
  DemandesInitieesService(),
  UserDemandesPage(),
  DemandesComptable(), // A décaisser
];
const List<Widget> adminPages = [
  AddDemandePage(),
  UserDemandesPage(),
  ListDemandesPage(),
  //SignupPage()
];

const userNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: Icon(Icons.home, color: AppPalette.buttonBackgroundColor),
      selectedIcon: Icon(Icons.home, color: Colors.white),
      label: 'Mes demandes'),
  NavigationDestination(
      icon: Icon(Icons.add_circle, color: AppPalette.buttonBackgroundColor),
      selectedIcon: Icon(Icons.add_circle, color: Colors.white),
      label: 'Nouveau'),
];

const chefServiceDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.envelopeOpenText,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon:
          FaIcon(FontAwesomeIcons.envelopeOpenText, color: Colors.white),
      label: 'Mes demandes'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.clock,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
      label: 'En attente'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.file,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.file, color: Colors.white),
      label: 'Nouveau'),
];

const rafNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.clock,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
      label: 'En attente'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.file,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.file, color: Colors.white),
      label: 'Tous'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.rectangleList,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.rectangleList, color: Colors.white),
      label: 'Service RAF'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.coins,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.coins, color: Colors.white),
      label: 'Budget'),
];

const coordonnateurNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.clock,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
      label: 'En attente'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.rectangleList,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.rectangleList, color: Colors.white),
      label: 'Tous'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.coins,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.coins, color: Colors.white),
      label: 'Budget'),
];

const adminNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.file,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.file, color: Colors.white),
      label: 'Nouveau'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.envelopeOpenText,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon:
          FaIcon(FontAwesomeIcons.envelopeOpenText, color: Colors.white),
      label: 'Mes demandes'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.rectangleList,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.rectangleList, color: Colors.white),
      label: 'Tous'),
];

const comptableNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.file,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.file, color: Colors.white),
      label: 'Nouveau'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.clock,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
      label: 'A valider'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.envelopeOpenText,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon:
          FaIcon(FontAwesomeIcons.envelopeOpenText, color: Colors.white),
      label: 'Mes demandes'),
  NavigationDestination(
      icon: FaIcon(FontAwesomeIcons.clock,
          color: AppPalette.buttonBackgroundColor),
      selectedIcon: FaIcon(FontAwesomeIcons.clock, color: Colors.white),
      label: 'A decaisser'),
];
