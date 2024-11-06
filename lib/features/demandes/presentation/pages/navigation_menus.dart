import 'package:demandes/features/authentification/presentation/pages/signup_page.dart';
import 'package:demandes/features/demandes/presentation/pages/add_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_chef.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_comptable.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_coordo.dart';
import 'package:demandes/features/demandes/presentation/pages/demandes_raf.dart';
import 'package:demandes/features/demandes/presentation/pages/list_demandes_page.dart';
import 'package:demandes/features/demandes/presentation/pages/user_demandes_page.dart';

import 'package:flutter/material.dart';

const List<Widget> userPages = [UserDemandesPage(), AddDemandePage()];
const List<Widget> chefServicePages = [
  UserDemandesPage(),
  DemandesChefService(),
  AddDemandePage()
];
const List<Widget> coordonnateurPages = [
  DemandesCoordo(), //A valider
  ListDemandesPage(), // Toutes les demandes
];
const List<Widget> rafPages = [DemandesRaf(), AddDemandePage(), SignupPage()];
const List<Widget> comptablePages = [
  UserDemandesPage(),
  DemandesComptable(),
  AddDemandePage(),
];
const List<Widget> adminPages = [
  UserDemandesPage(),
  ListDemandesPage(),
  AddDemandePage(),
  SignupPage()
];

const userNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: Icon(Icons.home, color: Colors.blue),
      selectedIcon: Icon(Icons.home, color: Colors.white),
      label: 'Mes demandes'),
  NavigationDestination(
      icon: Icon(Icons.add_circle, color: Colors.blue),
      selectedIcon: Icon(Icons.add_circle, color: Colors.white),
      label: 'Nlle demande'),
];

const rafNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: Icon(Icons.summarize, color: Colors.blue),
      selectedIcon: Icon(Icons.summarize, color: Colors.white),
      label: 'Demandes à traiter'),
  NavigationDestination(
      icon: Icon(Icons.add_circle, color: Colors.blue),
      selectedIcon: Icon(Icons.add_circle, color: Colors.white),
      label: 'Nlle demande'),
  NavigationDestination(
      icon: Icon(Icons.person, color: Colors.blue),
      selectedIcon: Icon(Icons.person, color: Colors.white),
      label: 'Compte+'),
];

const coordonnateurNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: Icon(Icons.summarize, color: Colors.blue),
      selectedIcon: Icon(Icons.summarize, color: Colors.white),
      label: 'Demandes à traiter'),
  NavigationDestination(
      icon: Icon(Icons.history, color: Colors.blue),
      selectedIcon: Icon(Icons.history, color: Colors.white),
      label: 'Toutes les demandes'),
];

const adminNavigationDestinations = <NavigationDestination>[
  NavigationDestination(
      icon: Icon(Icons.home, color: Colors.blue),
      selectedIcon: Icon(Icons.home, color: Colors.white),
      label: 'Mes demandes'),
  NavigationDestination(
      icon: Icon(Icons.summarize, color: Colors.blue),
      selectedIcon: Icon(Icons.summarize, color: Colors.white),
      label: 'Demandes à traiter'),
  NavigationDestination(
      icon: Icon(Icons.add_circle, color: Colors.blue),
      selectedIcon: Icon(Icons.add_circle, color: Colors.white),
      label: 'Nlle demande'),
];
