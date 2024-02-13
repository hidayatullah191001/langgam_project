// import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;

import 'package:d_method/d_method.dart';
import 'package:langgam_project/configs/configs.dart';
import 'package:langgam_project/models/berita_model.dart';
import 'package:langgam_project/models/bidang_layanan_model.dart';
import 'package:langgam_project/models/forms/permintaan_form_model.dart';
import 'package:langgam_project/models/forms/sign_in_form_model.dart';
import 'package:langgam_project/models/forms/sign_up_form_model.dart';
import 'package:langgam_project/models/kecamatan_model.dart';
import 'package:langgam_project/models/kota_model.dart';
import 'package:langgam_project/models/layanan_model.dart';
import 'package:langgam_project/models/list_permintaan_model.dart';
import 'package:langgam_project/models/list_permintaan_model_admin.dart';
import 'package:langgam_project/models/permintaan_all_model.dart';
import 'package:langgam_project/models/permintaan_model.dart';
import 'package:langgam_project/models/provinsi_model.dart';
import 'package:http/http.dart' as http;

import 'package:langgam_project/models/bantuan_model.dart';

part 'auth_services.dart';
part 'layanan_services.dart';
part 'wilayah_services.dart';
part 'checkout_services.dart';
part 'permintaan_services.dart';
part 'berita_services.dart';
part 'bantuan_services.dart';
