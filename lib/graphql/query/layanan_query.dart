part of 'queries.dart';

class LayananQuery {
  static String queryLayanans() => """
  query Layanans {
      layanans {
          data {
              id
              attributes {
                  judul
                  slug
                  intro
                  konten
                  harga
                  satuan
                  createdAt
                  updatedAt
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

  static String queryLayanan(String id) => """
query Layanan {
    layanan(id: $id) {
        data {
            id
            attributes {
                judul
                slug
                intro
                konten
                harga
                satuan
                createdAt
                updatedAt
                gambar {
                    data {
                        attributes {
                            url
                        }
                    }
                }
                bidang_layanan {
                    data {
                        attributes {
                            judul
                        }
                        id
                    }
                }
            }
        }
    }
}


""";
}
