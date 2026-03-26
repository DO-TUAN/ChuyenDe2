import 'dart:io'; // Thư viện bắt buộc để dùng stdin

class SinhVien {
  String hoTen;
  String maSV;
  double diemCC, diemKT, diemGK, diemThi;

  SinhVien(this.hoTen, this.maSV, this.diemCC, this.diemKT, this.diemGK, this.diemThi);

  // Tính điểm theo công thức (CC 10%, KT 20%, GK 20%, Thi 50%)
  double tinhTongKet() => (diemCC * 0.1) + (diemKT * 0.2) + (diemGK * 0.2) + (diemThi * 0.5);

  void hienThi() {
    print("\n--- KẾT QUẢ ---");
    print("SV: $hoTen ($maSV)");
    print("Điểm tổng kết: ${tinhTongKet().toStringAsFixed(2)}");
    print("Trạng thái: ${tinhTongKet() >= 4.0 ? 'ĐẠT' : 'HỌC LẠI'}");
  }
}

void main() {
  print("--- NHẬP THÔNG TIN SINH VIÊN ---");

  stdout.write("Nhập họ tên: ");
  String hoTen = stdin.readLineSync() ?? "";

  stdout.write("Nhập mã SV: ");
  String maSV = stdin.readLineSync() ?? "";

  // Hàm helper để ép kiểu dữ liệu nhập vào thành số double
  double nhapDiem(String thongBao) {
    stdout.write(thongBao);
    return double.tryParse(stdin.readLineSync() ?? "0") ?? 0.0;
  }

  double dcc = nhapDiem("Điểm chuyên cần: ");
  double dkt = nhapDiem("Điểm kiểm tra: ");
  double dgk = nhapDiem("Điểm giữa kỳ: ");
  double dt  = nhapDiem("Điểm thi: ");

  // Tạo đối tượng từ dữ liệu đã nhập
  var sv = SinhVien(hoTen, maSV, dcc, dkt, dgk, dt);
  
  // In kết quả
  sv.hienThi();
}