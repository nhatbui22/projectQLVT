USE QUANLYKHO

-- TẠO BẢNG NHÀ CUNG CẤP
CREATE TABLE NhaCungCap (
    MaNCC CHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(100) NOT NULL,
    DiaChi NVARCHAR(200) NOT NULL,
    SDT CHAR(12) NOT NULL
);

-- TẠO BẢNG NGƯỜI GIAO
CREATE TABLE NguoiGiao (
    MaNG CHAR(10) PRIMARY KEY,
    TenNG NVARCHAR(100) NOT NULL,
    SDT CHAR(12) NOT NULL,
    MaNCC CHAR(10),
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

-- TẠO BẢNG ĐƠN VỊ NHẬN
CREATE TABLE DonViNhan (
    MaDVN CHAR(10) PRIMARY KEY,
    TenDVN VARCHAR(100) NOT NULL,
    DiaChi VARCHAR(200)NOT NULL,
    SDT CHAR(15) NOT NULL
);

-- TẠO BẢNG NGƯỜI NHẬN
CREATE TABLE NguoiNhan (
    MaNN CHAR(10) PRIMARY KEY,
    TenNN VARCHAR(100) NOT NULL,
    SDT CHAR(15) NOT NULL,
    MaDVN CHAR(10),
    FOREIGN KEY (MaDVN) REFERENCES DonViNhan(MaDVN)
);


--TẠO BẢNG LƯƠNG
CREATE TABLE Luong (
    MaCV CHAR(10) PRIMARY KEY,
    TenCV VARCHAR(100)NOT NULL,
    LuongCB DECIMAL(18, 2) DEFAULT(5000000),
    HSL DECIMAL(18, 2),
);

-- TẠO BẢNG KHO
CREATE TABLE KHO (
    MaKho CHAR(10) PRIMARY KEY,
    TenKho VARCHAR(100),
    DiaDiem VARCHAR(200)
);

-- TẠO BẢNG LOẠI VẬT TƯ
CREATE TABLE LoaiVatTu (
    MaLoaiVT CHAR(10) PRIMARY KEY,
    LoaiVT VARCHAR(100),
    Mota VARCHAR(200)
);

-- TẠO BẢNG VẬT TƯ
CREATE TABLE VatTu (
    MaVT CHAR(10) PRIMARY KEY,
    TenVT VARCHAR(100),
    DonViTinh VARCHAR(50),
    SoLuong INT,
    MaLoaiVT CHAR(10),
    FOREIGN KEY (MaLoaiVT) REFERENCES LoaiVatTu(MaLoaiVT)
);

-- TẠO BẢNG TỒN KHO
CREATE TABLE TonKho (
    MaVT CHAR(10) NOT NULL,
    NamThang DATE,
    SoLuongTon INT,
    MaKho CHAR(10),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);


-- TẠO BẢNG NHÂN VIÊN VÀ SỐ ĐIỆN THOẠI
CREATE TABLE NhanVien_SDT (
    MaNV CHAR(10),
    SDT CHAR(15),
    PRIMARY KEY (MaNV, SDT),
	FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);


-- TẠO BẢNG NHÂN VIÊN
CREATE TABLE NhanVien (
    MaNV CHAR(10) PRIMARY KEY,
    TenNV VARCHAR(100),
    GioiTinh CHAR(3),
    DiaChi VARCHAR(200),
    Ngayvaolam DATE,
    MaCV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaCV) REFERENCES Luong(MaCV),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

--TẠO BẢNG PHIẾU NHẬP
CREATE TABLE PhieuNhap (
    SoPhieuN CHAR(10) PRIMARY KEY,
    NgayNhap DATE,
    MaNG CHAR(10),
    MaNV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaNG) REFERENCES NguoiGiao(MaNG),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

-- TẠO BẢNG CHI TIẾT PHIẾU NHẬP
CREATE TABLE ChiTietPhieuN (
    SoPhieuN CHAR(10) PRIMARY KEY,
    MaVT CHAR(10),
    SoLuongN INT CHECK(SoLuongN > 0),
    DonGiaN DECIMAL(18, 2) CHECK(DonGiaN > 0),
    FOREIGN KEY (SoPhieuN) REFERENCES PhieuNhap(SoPhieuN),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
);

-- TẠO BẢNG PHIẾU XUẤT
CREATE TABLE PhieuXuat (
    SoPhieuX CHAR(10) PRIMARY KEY,
    NgayXuat DATE,
    MaNN CHAR(10),
    MaNV CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaNN) REFERENCES NguoiNhan(MaNN),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaKho) REFERENCES KHO(MaKho)
);

-- TẠO BẢNG CHI TIẾT PHIẾU XUẤT
CREATE TABLE ChiTietPhieuX (
    SoPhieuX CHAR(10) PRIMARY KEY,
    MaVT CHAR(10),
    SoLuongX INT CHECK(SoLuongX > 0),
    DonGiaX DECIMAL(18, 2) CHECK(DonGiaX > 0),
    FOREIGN KEY (SoPhieuX) REFERENCES PhieuXuat(SoPhieuX),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
);

-- INSERT DATA INTO NhaCungCap
INSERT INTO NhaCungCap (MaNCC, TenNCC, DiaChi, SDT) VALUES
('NCC001', 'Công ty A', 'Hà Nội', '0123456789'),
('NCC002', 'Công ty B', 'TP HCM', '0123456790'),
('NCC003', 'Công ty C', 'Đà Nẵng', '0123456791'),
('NCC004', 'Công ty D', 'Hải Phòng', '0123456792'),
('NCC005', 'Công ty E', 'Cần Thơ', '0123456793'),
('NCC006', 'Công ty F', 'Bình Dương', '0123456794'),
('NCC007', 'Công ty G', 'Đồng Nai', '0123456795'),
('NCC008', 'Công ty H', 'Khánh Hòa', '0123456796'),
('NCC009', 'Công ty I', 'Bắc Ninh', '0123456797'),
('NCC010', 'Công ty J', 'Nghệ An', '0123456798');

-- INSERT DATA INTO NguoiGiao
INSERT INTO NguoiGiao (MaNG, TenNG, SDT, MaNCC) VALUES
('NG001', 'Nguyễn Văn A', '0123456799', 'NCC001'),
('NG002', 'Trần Văn B', '0123456800', 'NCC002'),
('NG003', 'Lê Thị C', '0123456801', 'NCC003'),
('NG004', 'Phạm Văn D', '0123456802', 'NCC004'),
('NG005', 'Ngô Thị E', '0123456803', 'NCC005'),
('NG006', 'Đặng Văn F', '0123456804', 'NCC006'),
('NG007', 'Bùi Thị G', '0123456805', 'NCC007'),
('NG008', 'Hồ Văn H', '0123456806', 'NCC008'),
('NG009', 'Vũ Thị I', '0123456807', 'NCC009'),
('NG010', 'Cao Văn J', '0123456808', 'NCC010');

-- INSERT DATA INTO DonViNhan
INSERT INTO DonViNhan (MaDVN, TenDVN, DiaChi, SDT) VALUES
('DVN001', 'Công ty K', 'Hà Nội', '0123456809'),
('DVN002', 'Công ty L', 'TP HCM', '0123456810'),
('DVN003', 'Công ty M', 'Đà Nẵng', '0123456811'),
('DVN004', 'Công ty N', 'Hải Phòng', '0123456812'),
('DVN005', 'Công ty O', 'Cần Thơ', '0123456813'),
('DVN006', 'Công ty P', 'Bình Dương', '0123456814'),
('DVN007', 'Công ty Q', 'Đồng Nai', '0123456815'),
('DVN008', 'Công ty R', 'Khánh Hòa', '0123456816'),
('DVN009', 'Công ty S', 'Bắc Ninh', '0123456817'),
('DVN010', 'Công ty T', 'Nghệ An', '0123456818');

-- INSERT DATA INTO NguoiNhan
INSERT INTO NguoiNhan (MaNN, TenNN, SDT, MaDVN) VALUES
('NN001', 'Phạm Văn K', '0123456819', 'DVN001'),
('NN002', 'Nguyễn Thị L', '0123456820', 'DVN002'),
('NN003', 'Trần Văn M', '0123456821', 'DVN003'),
('NN004', 'Lê Văn N', '0123456822', 'DVN004'),
('NN005', 'Đỗ Thị O', '0123456823', 'DVN005'),
('NN006', 'Ngô Văn P', '0123456824', 'DVN006'),
('NN007', 'Đặng Thị Q', '0123456825', 'DVN007'),
('NN008', 'Bùi Văn R', '0123456826', 'DVN008'),
('NN009', 'Hồ Thị S', '0123456827', 'DVN009'),
('NN010', 'Vũ Văn T', '0123456828', 'DVN010');

-- INSERT DATA INTO Luong
INSERT INTO Luong (MaCV, TenCV, LuongCB, HSL) VALUES
('CV001', 'Giám đốc', 15000000, 3.5),
('CV002', 'Phó giám đốc', 12000000, 3.0),
('CV003', 'Trưởng phòng', 10000000, 2.5),
('CV004', 'Phó phòng', 8000000, 2.0),
('CV005', 'Nhân viên', 6000000, 1.5),
('CV006', 'Thực tập sinh', 5000000, 1.0),
('CV007', 'Quản lý kho', 7000000, 1.7),
('CV008', 'Nhân viên kho', 5500000, 1.3),
('CV009', 'Kế toán', 9000000, 2.2),
('CV010', 'Thủ quỹ', 6500000, 1.6);

-- INSERT DATA INTO KHO
INSERT INTO KHO (MaKho, TenKho, DiaDiem) VALUES
('K001', 'Kho Hà Nội', 'Hà Nội'),
('K002', 'Kho TP HCM', 'TP HCM'),
('K003', 'Kho Đà Nẵng', 'Đà Nẵng'),
('K004', 'Kho Hải Phòng', 'Hải Phòng'),
('K005', 'Kho Cần Thơ', 'Cần Thơ'),
('K006', 'Kho Bình Dương', 'Bình Dương'),
('K007', 'Kho Đồng Nai', 'Đồng Nai'),
('K008', 'Kho Khánh Hòa', 'Khánh Hòa'),
('K009', 'Kho Bắc Ninh', 'Bắc Ninh'),
('K010', 'Kho Nghệ An', 'Nghệ An');

-- INSERT DATA INTO LoaiVatTu
INSERT INTO LoaiVatTu (MaLoaiVT, LoaiVT, Mota) VALUES
('LVT001', 'Loại A', 'Mô tả A'),
('LVT002', 'Loại B', 'Mô tả B'),
('LVT003', 'Loại C', 'Mô tả C'),
('LVT004', 'Loại D', 'Mô tả D'),
('LVT005', 'Loại E', 'Mô tả E'),
('LVT006', 'Loại F', 'Mô tả F'),
('LVT007', 'Loại G', 'Mô tả G'),
('LVT008', 'Loại H', 'Mô tả H'),
('LVT009', 'Loại I', 'Mô tả I'),
('LVT010', 'Loại J', 'Mô tả J');

-- INSERT DATA INTO VatTu
INSERT INTO VatTu (MaVT, TenVT, DonViTinh, SoLuong, MaLoaiVT) VALUES
('VT001', 'Vật tư A', 'Kg', 100, 'LVT001'),
('VT002', 'Vật tư B', 'L', 200, 'LVT002'),
('VT003', 'Vật tư C', 'M', 300, 'LVT003'),
('VT004', 'Vật tư D', 'Kg', 400, 'LVT004'),
('VT005', 'Vật tư E', 'L', 500, 'LVT005'),
('VT006', 'Vật tư F', 'M', 600, 'LVT006'),
('VT007', 'Vật tư G', 'Kg', 700, 'LVT007'),
('VT008', 'Vật tư H', 'L', 800, 'LVT008'),
('VT009', 'Vật tư I', 'M', 900, 'LVT009'),
('VT010', 'Vật tư J', 'Kg', 1000, 'LVT010');

-- INSERT DATA INTO TonKho
INSERT INTO TonKho (MaVT, NamThang, SoLuongTon, MaKho) VALUES
('VT001', '2023-01-01', 50, 'K001'),
('VT002', '2023-02-01', 150, 'K002'),
('VT003', '2023-03-01', 250, 'K003'),
('VT004', '2023-04-01', 350, 'K004'),
('VT005', '2023-05-01', 450, 'K005'),
('VT006', '2023-06-01', 550, 'K006'),
('VT007', '2023-07-01', 650, 'K007'),
('VT008', '2023-08-01', 750, 'K008'),
('VT009', '2023-09-01', 850, 'K009'),
('VT010', '2023-10-01', 950, 'K010');
-- INSERT DATA INTO NhanVien
INSERT INTO NhanVien (MaNV, TenNV, GioiTinh, DiaChi, Ngayvaolam, MaCV, MaKho) VALUES
('NV001', 'Nguyễn Văn A', 'Nam', 'Hà Nội', '2020-01-01', 'CV001', 'K001'),
('NV002', 'Trần Thị B', 'Nữ', 'TP HCM', '2020-02-01', 'CV002', 'K002'),
('NV003', 'Lê Văn C', 'Nam', 'Đà Nẵng', '2020-03-01', 'CV003', 'K003'),
('NV004', 'Phạm Thị D', 'Nữ', 'Hải Phòng', '2020-04-01', 'CV004', 'K004'),
('NV005', 'Ngô Văn E', 'Nam', 'Cần Thơ', '2020-05-01', 'CV005', 'K005'),
('NV006', 'Đặng Thị F', 'Nữ', 'Bình Dương', '2020-06-01', 'CV006', 'K006'),
('NV007', 'Bùi Văn G', 'Nam', 'Đồng Nai', '2020-07-01', 'CV007', 'K007'),
('NV008', 'Hồ Thị H', 'Nữ', 'Khánh Hòa', '2020-08-01', 'CV008', 'K008'),
('NV009', 'Vũ Văn I', 'Nam', 'Bắc Ninh', '2020-09-01', 'CV009', 'K009'),
('NV010', 'Cao Thị J', 'Nữ', 'Nghệ An', '2020-10-01', 'CV010', 'K010');

-- INSERT DATA INTO NhanVien_SDT
INSERT INTO NhanVien_SDT (MaNV, SDT) VALUES
('NV001', '0123456829'),
('NV001', '0123456830'),
('NV002', '0123456831'),
('NV002', '0123456832'),
('NV003', '0123456833'),
('NV003', '0123456834'),
('NV004', '0123456835'),
('NV004', '0123456836'),
('NV005', '0123456837'),
('NV005', '0123456838'),
('NV006', '0123456839'),
('NV006', '0123456840'),
('NV007', '0123456841'),
('NV007', '0123456842'),
('NV008', '0123456843'),
('NV008', '0123456844'),
('NV009', '0123456845'),
('NV009', '0123456846'),
('NV010', '0123456847'),
('NV010', '0123456848');

-- INSERT DATA INTO PhieuNhap
INSERT INTO PhieuNhap (SoPhieuN, NgayNhap, MaNG, MaNV, MaKho) VALUES
('PN001', '2023-01-01', 'NG001', 'NV001', 'K001'),
('PN002', '2023-02-01', 'NG002', 'NV002', 'K002'),
('PN003', '2023-03-01', 'NG003', 'NV003', 'K003'),
('PN004', '2023-04-01', 'NG004', 'NV004', 'K004'),
('PN005', '2023-05-01', 'NG005', 'NV005', 'K005'),
('PN006', '2023-06-01', 'NG006', 'NV006', 'K006'),
('PN007', '2023-07-01', 'NG007', 'NV007', 'K007'),
('PN008', '2023-08-01', 'NG008', 'NV008', 'K008'),
('PN009', '2023-09-01', 'NG009', 'NV009', 'K009'),
('PN010', '2023-10-01', 'NG010', 'NV010', 'K010');

-- INSERT DATA INTO ChiTietPhieuN
INSERT INTO ChiTietPhieuN (SoPhieuN, MaVT, SoLuongN, DonGiaN) VALUES
('PN001', 'VT001', 10, 50000),
('PN002', 'VT002', 20, 100000),
('PN003', 'VT003', 30, 150000),
('PN004', 'VT004', 40, 200000),
('PN005', 'VT005', 50, 250000),
('PN006', 'VT006', 60, 300000),
('PN007', 'VT007', 70, 350000),
('PN008', 'VT008', 80, 400000),
('PN009', 'VT009', 90, 450000),
('PN010', 'VT010', 100, 500000);

-- INSERT DATA INTO PhieuXuat
INSERT INTO PhieuXuat (SoPhieuX, NgayXuat, MaNN, MaNV, MaKho) VALUES
('PX001', '2023-01-01', 'NN001', 'NV001', 'K001'),
('PX002', '2023-02-01', 'NN002', 'NV002', 'K002'),
('PX003', '2023-03-01', 'NN003', 'NV003', 'K003'),
('PX004', '2023-04-01', 'NN004', 'NV004', 'K004'),
('PX005', '2023-05-01', 'NN005', 'NV005', 'K005'),
('PX006', '2023-06-01', 'NN006', 'NV006', 'K006'),
('PX007', '2023-07-01', 'NN007', 'NV007', 'K007'),
('PX008', '2023-08-01', 'NN008', 'NV008', 'K008'),
('PX009', '2023-09-01', 'NN009', 'NV009', 'K009'),
('PX010', '2023-10-01', 'NN010', 'NV010', 'K010');

-- INSERT DATA INTO ChiTietPhieuX
INSERT INTO ChiTietPhieuX (SoPhieuX, MaVT, SoLuongX, DonGiaX) VALUES
('PX001', 'VT001', 5, 55000),
('PX002', 'VT002', 10, 105000),
('PX003', 'VT003', 15, 155000),
('PX004', 'VT004', 20, 205000),
('PX005', 'VT005', 25, 255000),
('PX006', 'VT006', 30, 305000),
('PX007', 'VT007', 35, 355000),
('PX008', 'VT008', 40, 405000),
('PX009', 'VT009', 45, 455000),
('PX010', 'VT010', 50, 505000);

