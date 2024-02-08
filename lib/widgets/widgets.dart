import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hovering/hovering.dart';
import 'package:langgam_project/configs/configs.dart';
import 'package:langgam_project/controllers/controller.dart';
import 'package:langgam_project/models/bidang_layanan_model.dart';
import 'package:langgam_project/models/forms/sign_in_form_model.dart';
import 'package:langgam_project/models/layanan_model.dart' as layanan;
import 'package:langgam_project/models/layanan_model.dart';
import 'package:langgam_project/services/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

part 'buttons.dart';
part 'cards.dart';
part 'text.dart';
part 'banner_top.dart';
part 'navbar.dart';
part 'footer.dart';
part 'login_drawer.dart';
part 'forms.dart';
part 'hero.dart';
part 'cart_drawer.dart';
