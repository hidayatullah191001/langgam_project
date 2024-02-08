import 'dart:convert';
import 'dart:js_interop';

import 'package:cool_alert/cool_alert.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:langgam_project/configs/configs.dart';
import 'package:langgam_project/models/bidang_layanan_model.dart';
import 'package:langgam_project/models/bidang_layanan_model.dart'
    as bidang_layanan_model;
import 'package:langgam_project/models/forms/permintaan_form_model.dart';
import 'package:langgam_project/models/forms/sign_in_form_model.dart';
import 'package:langgam_project/models/kecamatan_model.dart';
import 'package:langgam_project/models/kota_model.dart';
import 'package:langgam_project/models/layanan_model.dart';
import 'package:langgam_project/models/list_permintaan_model.dart'
    as listPermintaanModel;
import 'package:langgam_project/models/permintaan_model.dart'
    as permintaanModel;
import 'package:langgam_project/models/provinsi_model.dart';
import 'package:langgam_project/services/services.dart';
import 'package:provider/provider.dart';

import '../models/bidang_layanan_model.dart';

part 'my_account_controller.dart';
part 'navbar_controller.dart';
part 'admin_controller.dart';
part 'cart_controller.dart';
part 'auth_controller.dart';
part 'wilayah_controller.dart';
part 'layanan_controller.dart';
part 'checkout_controller.dart';
part 'permintaan_controller.dart';
