part of 'queries.dart';

class BeritaQuery {
  static String queryBeritas() => """
query Posts {
    posts {
        data {
            id
            attributes {
                judul
                slug
                gambar {
                    data {
                        attributes {
                            url
                        }
                    }
                }
                intro
            }
        }
    }
}
""";

  static String queryBeritas2() => """
query Posts {
    posts {
        data {
            id
            attributes {
                judul
                slug
                gambar {
                    data {
                        attributes {
                            url
                        }
                    }
                }
                intro
            }
        }
    }
}
""";

  static String queryBerita(String id) => """
query Post {
    post(id: $id) {
        data {
            id
            attributes {
                judul
                slug
                intro
                konten
                gambar {
                    data {
                        attributes {
                            url
                        }
                    }
                }
            }
        }
    }
}
""";
}
