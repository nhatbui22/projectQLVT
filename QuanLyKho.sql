-- Tạo cơ sở dữ liệu và sử dụng cơ sở dữ liệu
CREATE DATABASE QuanLyKho;
USE QuanLyKho;

-- Tạo bảng LoaiVT
CREATE TABLE LoaiVT (
    MaLoaiVT CHAR(10) PRIMARY KEY,
    TenLoaiVT NVARCHAR(50) NOT NULL,
    MoTa NVARCHAR(50)
);

-- Tạo bảng VatTu
CREATE TABLE VatTu (
    MaVT CHAR(10) PRIMARY KEY,
    TenVT NVARCHAR(50) NOT NULL,
    DonViTinh NVARCHAR(12),
    MaLoaiVT CHAR(10),
    FOREIGN KEY (MaLoaiVT) REFERENCES LoaiVT(MaLoaiVT)
);

-- Tạo bảng Luong
CREATE TABLE Luong (
    MaCV CHAR(10) PRIMARY KEY,
    TenCV NVARCHAR(50) NOT NULL,
    HSL FLOAT,
    LuongCB FLOAT DEFAULT 5000000
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    MaNV CHAR(10) PRIMARY KEY,
    TenNV NVARCHAR(50) NOT NULL,
    SDT CHAR(12) NOT NULL UNIQUE,
    DiaChi NVARCHAR(70) NOT NULL,
    NgayVaoLam DATE,
    MaCV CHAR(10),
    FOREIGN KEY (MaCV) REFERENCES Luong(MaCV)
);

-- Tạo bảng NhaCungCap
CREATE TABLE NhaCungCap (
    MaNCC CHAR(10) PRIMARY KEY,
    TenNCC NVARCHAR(50) NOT NULL,
    SDT CHAR(12) NOT NULL,
    DiaChi NVARCHAR(70) NOT NULL
);

-- Tạo bảng NguoiGiao
CREATE TABLE NguoiGiao (
    MaNG CHAR(10) PRIMARY KEY,
    TenNG NVARCHAR(50) NOT NULL,
    SDT VARCHAR(12) NOT NULL,
    MaNCC CHAR(10),
    FOREIGN KEY (MaNCC) REFERENCES NhaCungCap(MaNCC)
);

-- Tạo bảng DonViNhan
CREATE TABLE DonViNhan (
    MaDVN CHAR(10) PRIMARY KEY,
    TenDVN NVARCHAR(50) NOT NULL,
    DiaChi NVARCHAR(70) NOT NULL,
    SDT CHAR(12) NOT NULL
);

-- Tạo bảng NguoiNhan
CREATE TABLE NguoiNhan (
    MaNN CHAR(10) PRIMARY KEY,
    TenNN NVARCHAR(50) NOT NULL,
    SDT CHAR(12) NOT NULL,
    MaDVN CHAR(10),
    FOREIGN KEY (MaDVN) REFERENCES DonViNhan(MaDVN)
);

-- Tạo bảng Kho
CREATE TABLE Kho (
    MaKho CHAR(10) PRIMARY KEY,
    TenKho NVARCHAR(50),
    MaVT CHAR(10),
    MaNV CHAR(10),
    MaLoaiVT CHAR(10),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
    FOREIGN KEY (MaLoaiVT) REFERENCES LoaiVT(MaLoaiVT)
);

-- Tạo bảng TonKho
CREATE TABLE TonKho (
    MaVT CHAR(10) PRIMARY KEY,
    ThangNam DATE,
    SoLuongTon INT,
    DonGiaTon FLOAT,
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
);

-- Tạo bảng DiaDiem
CREATE TABLE DiaDiem (
    MaKho CHAR(10) NOT NULL,
    MaDD CHAR(10) NOT NULL,
    TenDD NVARCHAR(50) NOT NULL,
    PRIMARY KEY (MaKho, MaDD),
    FOREIGN KEY (MaKho) REFERENCES Kho(MaKho)
);

-- Tạo bảng PhieuNhap
CREATE TABLE PhieuNhap (
    SoPhieuN CHAR(10) PRIMARY KEY,
    NgayNhap DATE NOT NULL,
    MaNG CHAR(10),
    MaKho CHAR(10),
    FOREIGN KEY (MaNG) REFERENCES NguoiGiao(MaNG),
    FOREIGN KEY (MaKho) REFERENCES Kho(MaKho)
);

-- Tạo bảng ChiTietN
CREATE TABLE ChiTietN (
    SoPhieuN CHAR(10) NOT NULL,
    MaVT CHAR(10) NOT NULL,
    SoLuongN INT NOT NULL,
    DonGiaN FLOAT NOT NULL,
    PRIMARY KEY (SoPhieuN, MaVT),
    FOREIGN KEY (SoPhieuN) REFERENCES PhieuNhap(SoPhieuN),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
);

-- Tạo bảng PhieuXuat
CREATE TABLE PhieuXuat (
    SoPhieuX CHAR(10) PRIMARY KEY,
    NgayXuat DATE,
    MaKho CHAR(10),
    MaNN CHAR(10),
    FOREIGN KEY (MaKho) REFERENCES Kho(MaKho),
    FOREIGN KEY (MaNN) REFERENCES NguoiNhan(MaNN)
);

-- Tạo bảng ChiTietX
CREATE TABLE ChiTietX (
    SoPhieuX CHAR(10) NOT NULL,
    MaVT CHAR(10) NOT NULL,
    SoLuongX INT NOT NULL,
    DonGiaX FLOAT NOT NULL,
    PRIMARY KEY (SoPhieuX, MaVT),
    FOREIGN KEY (SoPhieuX) REFERENCES PhieuXuat(SoPhieuX),
    FOREIGN KEY (MaVT) REFERENCES VatTu(MaVT)
);

INSERT INTO LoaiVT (MaLoaiVT, TenLoaiVT, MoTa) VALUES 
('LVT001', 'Điện tử', 'Thiết bị điện tử gia dụng'),
('LVT002', 'Thực phẩm', 'Các loại thực phẩm'),
('LVT003', 'Văn phòng phẩm', 'Dụng cụ văn phòng');

INSERT INTO VatTu (MaVT, TenVT, DonViTinh, MaLoaiVT) VALUES 
('VT001', 'Tivi', 'Chiếc', 'LVT001'),
('VT002', 'Bánh mì', 'Cái', 'LVT002'),
('VT003', 'Bút bi', 'Cây', 'LVT003');

INSERT INTO Luong (MaCV, TenCV, HSL, LuongCB) VALUES 
('CV001', 'Nhân viên bán hàng', 1.2, 6000000),
('CV002', 'Kế toán', 1.5, 7000000),
('CV003', 'Quản lý kho', 2.0, 8000000);

INSERT INTO NhanVien (MaNV, TenNV, SDT, DiaChi, NgayVaoLam, MaCV) VALUES 
('NV001', 'Nguyễn Văn A', '0123456789', 'Số 1, Đường ABC, Thành phố XYZ', '2023-01-15', 'CV001'),
('NV002', 'Trần Thị B', '0987654321', 'Số 2, Đường XYZ, Thành phố ABC', '2023-03-20', 'CV002'),
('NV003', 'Lê Văn C', '0369852147', 'Số 3, Đường MNO, Thành phố DEF', '2022-12-10', 'CV003');

INSERT INTO NhaCungCap (MaNCC, TenNCC, SDT, DiaChi) VALUES 
('NCC001', 'Công ty TNHH A', '0123456789', 'Số 10, Đường PQR, Thành phố XYZ'),
('NCC002', 'Công ty TNHH B', '0987654321', 'Số 20, Đường XYZ, Thành phố PQR');

INSERT INTO NguoiGiao (MaNG, TenNG, SDT, MaNCC) VALUES 
('NG001', 'Người giao 1', '0123456789', 'NCC001'),
('NG002', 'Người giao 2', '0987654321', 'NCC002');

INSERT INTO DonViNhan (MaDVN, TenDVN, DiaChi, SDT) VALUES 
('DVN001', 'Đơn vị nhận 1', 'Số 30, Đường STU, Thành phố MNO', '0369852147'),
('DVN002', 'Đơn vị nhận 2', 'Số 40, Đường UVW, Thành phố RST', '0123456789');

INSERT INTO NguoiNhan (MaNN, TenNN, SDT, MaDVN) VALUES 
('NN001', 'Người nhận 1', '0369852147', 'DVN001'),
('NN002', 'Người nhận 2', '0123456789', 'DVN002');

INSERT INTO Kho (MaKho, TenKho, MaVT, MaNV, MaLoaiVT) VALUES 
('K001', 'Kho 1', 'VT001', 'NV001', 'LVT001'),
('K002', 'Kho 2', 'VT002', 'NV002', 'LVT002');

INSERT INTO TonKho (MaVT, ThangNam, SoLuongTon, DonGiaTon) VALUES 
('VT001', '2024-06-01', 100, 50000),
('VT002', '2024-06-01', 200, 10000);

INSERT INTO DiaDiem (MaKho, MaDD, TenDD) VALUES 
('K001', 'DD001', 'Kệ số 1'),
('K001', 'DD002', 'Kệ số 2');

INSERT INTO PhieuNhap (SoPhieuN, NgayNhap, MaNG, MaKho) VALUES 
('PN001', '2024-06-01', 'NG001', 'K001'),
('PN002', '2024-06-02', 'NG002', 'K002');

INSERT INTO PhieuNhap (SoPhieuN, NgayNhap, MaNG, MaKho) VALUES 
('PN001', '2024-06-01', 'NG001', 'K001'),
('PN002', '2024-06-02', 'NG002', 'K002');


INSERT INTO ChiTietN (SoPhieuN, MaVT, SoLuongN, DonGiaN) VALUES 
('PN001', 'VT001', 50, 45000),
('PN001', 'VT002', 100, 8000);


INSERT INTO ChiTietN (SoPhieuN, MaVT, SoLuongN, DonGiaN) VALUES 
('PN002', 'VT001', 70, 47000),
('PN002', 'VT002', 120, 8200);


select * from PhieuNhap
select * from ChiTietN

---ten cac vat tu trong phieu PN001---

SELECT PhieuNhap.SoPhieuN, VatTu.TenVT, ChiTietN.SoLuongN, ChiTietN.DonGiaN
FROM PhieuNhap
JOIN ChiTietN ON PhieuNhap.SoPhieuN = ChiTietN.SoPhieuN
JOIN VatTu ON ChiTietN.MaVT = VatTu.MaVT
where PhieuNhap.SoPhieuN = 'PN001'
