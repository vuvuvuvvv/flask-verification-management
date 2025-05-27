import os
from sqlalchemy import Integer
from app.extensions import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from datetime import datetime, timedelta
from app.utils.url_encrypt import encode, decode
from flask_jwt_extended import create_access_token, decode_token

class Permission:
    USER = 1
    KIEM_DINH_VIEN = 2
    MANAGE = 3
    ADMIN = 4
    SUPERADMIN = 5

class Role(db.Model):
    __tablename__ = "roles"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(64), unique=True)
    default = db.Column(db.Boolean, default=False, index=True)
    permissions = db.Column(db.Integer)
    users = db.relationship("User", backref="role", lazy="dynamic")

    def __init__(self, **kwargs):
        super(Role, self).__init__(**kwargs)
        if self.permissions is None:
            self.permissions = Permission.USER


class User(UserMixin, db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True, nullable=False)
    fullname = db.Column(db.String(100), index=True, nullable=False, default="Unknown")
    email = db.Column(db.String(120), index=True, unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)
    role_id = db.Column(db.Integer, db.ForeignKey("roles.id"))
    confirmed = db.Column(db.Boolean, default=False)
    phong_ban_id = db.Column(db.Integer, db.ForeignKey("phongban.id"), index=True)

    def __init__(self, **kwargs):
        super(User, self).__init__(**kwargs)
        if self.role is None:
            self.role = Role.query.filter_by(default=True).first()
            # if self.email == os.environ.get['ADMIN_MAIL']:
            #     self.role = Role.query.filter_by(name='Administrator').first()
            # if self.role is None:
            #     self.role = Role.query.filter_by(default=True).first()

    def set_email(self, email):
        self.email = email

    def is_superadmin(self):
        return self.role.permissions == Permission.SUPERADMIN

    def is_admin(self):
        return self.role.permissions == Permission.ADMIN or self.is_superadmin()

    def set_fullname(self, fullname):
        self.fullname = fullname

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def generate_confirmation_token(self, exp_minutes=5):
        token = create_access_token(
            identity={"confirm_id": self.id},
            expires_delta=timedelta(minutes=exp_minutes),
        )
        return token

    def confirm(self, token):
        try:
            decoded_data = decode_token(token)
            confirm_id = decoded_data.get("sub", {}).get("confirm_id")
            if confirm_id != self.id:
                return False
            self.confirmed = True
            db.session.add(self)
            db.session.commit()
            return True
        except Exception as e:
            print(f"Token confirmation error: {e}")
            return False

    def to_dict(self):
        return {
            "id": encode(self.id),
            "username": self.username,
            "fullname": self.fullname,
            "email": self.email,
            "role": self.role.name if self.role.name else "Unknown",
            "confirmed": 1 if self.confirmed else 0,
            "permission" :  self.role.permissions if self.role.permissions else 0,
        }

class TokenBlacklist(db.Model):
    __tablename__ = "token_blacklist"
    id = db.Column(db.Integer, primary_key=True)
    jti = db.Column(db.String(36), nullable=False, unique=True)
    created_at = db.Column(db.DateTime, nullable=False, default=datetime.now)
    expires_at = db.Column(db.DateTime, nullable=False)

    def __init__(self, jti, expires_at):
        self.jti = jti
        self.expires_at = expires_at

class PDM(db.Model):
    __tablename__ = "pdm"

    id = db.Column(db.Integer, primary_key=True)
    ma_tim_dong_ho_pdm = db.Column(db.String(255), nullable=True, index=True)
    ten_dong_ho = db.Column(db.String(255), nullable=False, index=True)
    noi_san_xuat = db.Column(db.String(255), nullable=False)
    dn = db.Column(db.String(255), nullable=True)
    ccx = db.Column(db.String(255), nullable=True)
    kieu_sensor = db.Column(db.String(255), nullable=False)
    transmitter = db.Column(db.String(255), nullable=True)  # kieu chi thi
    qn = db.Column(db.String(255), nullable=True)
    q3 = db.Column(db.String(255), nullable=True)
    r = db.Column(db.String(255), nullable=True)
    don_vi_pdm = db.Column(db.String(255), nullable=False)
    dia_chi = db.Column(db.String(255), nullable=True)
    so_qd_pdm = db.Column(db.String(255), nullable=True, index=True)
    ngay_qd_pdm = db.Column(db.DateTime, nullable=True)
    ngay_het_han = db.Column(db.DateTime, nullable=True)
    anh_pdm = db.Column(db.String(255), nullable=True)

    def __init__(
        self,
        ma_tim_dong_ho_pdm,
        ten_dong_ho,
        noi_san_xuat,
        dn,
        ccx,
        kieu_sensor,
        transmitter,
        qn,
        q3,
        r,
        don_vi_pdm,
        dia_chi,
        so_qd_pdm,
        ngay_qd_pdm,
        ngay_het_han,
        anh_pdm,
    ):
        self.ma_tim_dong_ho_pdm = ma_tim_dong_ho_pdm
        self.ten_dong_ho = ten_dong_ho
        self.noi_san_xuat = noi_san_xuat
        self.dn = dn
        self.ccx = ccx
        self.kieu_sensor = kieu_sensor
        self.transmitter = transmitter
        self.qn = qn
        self.q3 = q3
        self.r = r
        self.don_vi_pdm = don_vi_pdm
        self.dia_chi = dia_chi
        self.so_qd_pdm = so_qd_pdm
        self.ngay_qd_pdm = ngay_qd_pdm
        self.ngay_het_han = ngay_het_han
        self.anh_pdm = anh_pdm

    def to_dict(self):
        return {
            "id": self.id,
            "ma_tim_dong_ho_pdm": self.ma_tim_dong_ho_pdm,
            "ten_dong_ho": self.ten_dong_ho,
            "noi_san_xuat": self.noi_san_xuat,
            "dn": self.dn,
            "ccx": self.ccx,
            "kieu_sensor": self.kieu_sensor,
            "transmitter": self.transmitter,
            "qn": self.qn,
            "q3": self.q3,
            "r": self.r,
            "don_vi_pdm": self.don_vi_pdm,
            "dia_chi": self.dia_chi,
            "so_qd_pdm": self.so_qd_pdm,
            "ngay_qd_pdm": self.ngay_qd_pdm,
            "ngay_het_han": self.ngay_het_han,
            "anh_pdm": self.anh_pdm,
        }

class DongHo(db.Model):
    __tablename__ = "dongho"
    id = db.Column(db.Integer, primary_key=True)
    ten_phuong_tien_do = db.Column(db.String(255), nullable=True)

    is_hieu_chuan = db.Column(db.Boolean, default=False)    # hiệu chuẩn
    index = db.Column(db.Integer, default=0)

    group_id = db.Column(db.String(255), nullable=True, index=True)

    sensor = db.Column(db.String(255), nullable=True, index=True)      # kiểu model 
    transitor = db.Column(db.String(255), nullable=True, index=True)     # kiểm model

    serial = db.Column(db.String(255), nullable=True, index=True)           # số

    co_so_san_xuat = db.Column(db.String(255), nullable=True)
    nam_san_xuat = db.Column(db.Date, nullable=True)

    dn = db.Column(db.String(255), nullable=True)
    d = db.Column(db.String(255), nullable=True)
    ccx = db.Column(db.String(255), nullable=True)
    q3 = db.Column(db.String(255), nullable=True)
    r = db.Column(db.String(255), nullable=True)
    qn = db.Column(db.String(255), nullable=True)
    k_factor = db.Column(db.String(255), nullable=True)
    so_qd_pdm = db.Column(db.String(255), nullable=True)

    so_tem = db.Column(db.String(255), nullable=True)
    so_giay_chung_nhan = db.Column(db.String(255), nullable=True, index=True)

    co_so_su_dung = db.Column(db.String(255), nullable=True)
    phuong_phap_thuc_hien = db.Column(db.String(255), nullable=True)
    chuan_thiet_bi_su_dung = db.Column(db.String(255), nullable=True)
    nguoi_thuc_hien = db.Column(db.String(255), nullable=True)
    ngay_thuc_hien = db.Column(db.Date, nullable=True)
    
    dia_diem_thuc_hien = db.Column(db.String(255), nullable=True)

    ket_qua_check_vo_ngoai = db.Column(db.Boolean, default=False)
    ket_qua_check_do_kin = db.Column(db.Boolean, default=False)
    ket_qua_check_do_on_dinh_chi_so = db.Column(db.Boolean, default=False)

    du_lieu_kiem_dinh = db.Column(db.Text, nullable=True)
    nguoi_soat_lai = db.Column(db.String(255), nullable=True)

    hieu_luc_bien_ban = db.Column(db.Date, nullable=True)
    last_updated = db.Column(db.Text, nullable=True)
    
    noi_su_dung = db.Column(db.String(255), nullable=True)
    ten_khach_hang = db.Column(db.String(255), nullable=True)
    # vi_tri = db.Column(db.String(255), nullable=True)  # dia diem noi su dung
    # nhiet_do = db.Column(db.String(255), nullable=True)
    # do_am = db.Column(db.String(255), nullable=True)
    # owner_id = db.Column(db.Integer, db.ForeignKey("user.id"), index=True)

    # Define the relationship to the User model
    # user = db.relationship("User", foreign_keys=[owner_id], backref="user_dongho")

    def __init__(
        self,
        ten_phuong_tien_do,
        is_hieu_chuan,
        index,
        group_id,
        
        sensor,
        transitor,
        serial,
        
        co_so_san_xuat,
        nam_san_xuat,

        dn,
        d,
        ccx,
        q3,
        r,
        qn,
        k_factor,
        so_qd_pdm,

        so_tem,
        so_giay_chung_nhan,

        co_so_su_dung,
        phuong_phap_thuc_hien,
        chuan_thiet_bi_su_dung,
        nguoi_thuc_hien,
        ngay_thuc_hien,

        dia_diem_thuc_hien,
        
        ket_qua_check_vo_ngoai,
        ket_qua_check_do_on_dinh_chi_so,
        ket_qua_check_do_kin,

        du_lieu_kiem_dinh,
        nguoi_soat_lai,

        hieu_luc_bien_ban,
        last_updated,

        noi_su_dung,
        ten_khach_hang,
        # vi_tri,
        # nhiet_do,
        # do_am,
    ):
        self.ten_phuong_tien_do = ten_phuong_tien_do
        self.is_hieu_chuan = is_hieu_chuan
        self.index = index
        self.group_id = group_id

        self.sensor = sensor
        self.transitor = transitor
        self.serial = serial

        self.co_so_san_xuat = co_so_san_xuat
        self.nam_san_xuat = nam_san_xuat
        self.dn = dn
        self.d = d
        self.ccx = ccx
        self.q3 = q3
        self.r = r
        self.qn = qn
        self.k_factor = k_factor
        self.so_qd_pdm = so_qd_pdm

        self.so_tem = so_tem
        self.so_giay_chung_nhan = so_giay_chung_nhan
        
        self.co_so_su_dung = co_so_su_dung
        self.phuong_phap_thuc_hien = phuong_phap_thuc_hien
        self.chuan_thiet_bi_su_dung = chuan_thiet_bi_su_dung
        self.nguoi_thuc_hien = nguoi_thuc_hien
        self.ngay_thuc_hien = ngay_thuc_hien

        self.dia_diem_thuc_hien = dia_diem_thuc_hien

        self.ket_qua_check_vo_ngoai = ket_qua_check_vo_ngoai
        self.ket_qua_check_do_kin = ket_qua_check_do_kin
        self.ket_qua_check_do_on_dinh_chi_so = ket_qua_check_do_on_dinh_chi_so

        self.du_lieu_kiem_dinh = du_lieu_kiem_dinh
        self.nguoi_soat_lai = nguoi_soat_lai

        self.hieu_luc_bien_ban = hieu_luc_bien_ban
        self.last_updated = last_updated

        self.noi_su_dung = noi_su_dung
        self.ten_khach_hang = ten_khach_hang

        # self.vi_tri = vi_tri
        # self.nhiet_do = nhiet_do
        # self.do_am = do_am

        

    def to_dict(self):
        return {
            "id": encode(self.id), 
            "ten_phuong_tien_do": self.ten_phuong_tien_do,
            "is_hieu_chuan": self.is_hieu_chuan,
            "index": self.index,
            "group_id": self.group_id,

            "transitor": self.transitor,
            "sensor": self.sensor,
            "serial": self.serial,

            "co_so_san_xuat": self.co_so_san_xuat,
            "nam_san_xuat": self.nam_san_xuat,

            "dn": self.dn,
            "d": self.d,
            "ccx": self.ccx,
            "q3": self.q3,
            "r": self.r,
            "qn": self.qn,
            "k_factor": self.k_factor,
            "so_qd_pdm": self.so_qd_pdm,
            
            "so_tem": self.so_tem,
            "so_giay_chung_nhan": self.so_giay_chung_nhan,
            
            "co_so_su_dung": self.co_so_su_dung,
            "phuong_phap_thuc_hien": self.phuong_phap_thuc_hien,
            "chuan_thiet_bi_su_dung": self.chuan_thiet_bi_su_dung,
            "nguoi_thuc_hien": self.nguoi_thuc_hien,
            "ngay_thuc_hien": self.ngay_thuc_hien,
            
            "dia_diem_thuc_hien": self.dia_diem_thuc_hien,

            "ket_qua_check_vo_ngoai": self.ket_qua_check_vo_ngoai,
            "ket_qua_check_do_on_dinh_chi_so": self.ket_qua_check_do_on_dinh_chi_so,
            "ket_qua_check_do_kin": self.ket_qua_check_do_kin,

            "du_lieu_kiem_dinh": self.du_lieu_kiem_dinh,
            "nguoi_soat_lai": self.nguoi_soat_lai,

            "hieu_luc_bien_ban": self.hieu_luc_bien_ban,
            "last_updated": self.last_updated,

            "noi_su_dung": self.noi_su_dung,
            "ten_khach_hang": self.ten_khach_hang,
            
            # "nhiet_do": self.nhiet_do,
            # "do_am": self.do_am,
            # "owner": None if not self.user else self.user.to_dict()
        }


# class NhomDongHoPayment(db.Model):
#     __tablename__ = "nhomdongho_payment"
#     id = db.Column(db.Integer, primary_key=True)
#     group_id = db.Column(db.String(50), nullable=False)
#     is_paid = db.Column(db.Boolean, default=False, nullable=False)
#     paid_date = db.Column(db.DateTime, nullable=True)
#     payment_collector = db.Column(db.String(50), nullable=True)
#     last_updated = db.Column(db.Text, nullable=True)

#     def __init__(
#         self,
#         group_id,
#         is_paid=False,
#         paid_date=None,
#         payment_collector=None,
#         last_updated=None,
#     ):
#         self.group_id = group_id
#         self.is_paid = is_paid
#         self.paid_date = paid_date
#         self.payment_collector = payment_collector
#         self.last_updated = last_updated

#     def to_dict(self):
#         return {
#             "id": encode(self.id),
#             "group_id": self.group_id,
#             "is_paid": self.is_paid,
#             "paid_date": self.paid_date,
#             "payment_collector": self.payment_collector,
#             "last_updated": self.last_updated,
#         }


# class DongHoPermissions(db.Model):
#     __tablename__ = "dongho_permissions"
#     id = db.Column(db.Integer, primary_key=True)
#     dongho_id = db.Column(db.Integer, db.ForeignKey("dongho.id"), index=True)
#     username = db.Column(db.String(64), db.ForeignKey("user.username"), index=True)
#     role_id = db.Column(db.Integer, db.ForeignKey("roles.id"))
#     manager = db.Column(db.String(64), db.ForeignKey("user.username"), index=True)

#     dongho = db.relationship("DongHo", foreign_keys=[dongho_id], backref="dongho_permissions")
#     user = db.relationship("User", foreign_keys=[username], backref="user_permissions")
#     mng = db.relationship("User", foreign_keys=[manager], backref="manager_permissions")
#     role = db.relationship("Role", foreign_keys=[role_id], backref="role_permissions")

#     def __init__(self, dongho_id, username,manager, role_id):
#         self.dongho_id = dongho_id
#         self.username = username
#         self.manager = manager
#         self.role_id = role_id

#     def to_dict(self):
#         return {
#             "id": encode(self.id),
#             "dongho":  None if not self.dongho else self.dongho.to_dict(),
#             "user":  None if not self.user else self.user.to_dict(),
#             "manager":  None if not self.mng else self.mng.to_dict(),
#             "role":  None if not self.role else self.role.name,
#         }


class PhongBan(db.Model):
    __tablename__ = "phongban"

    id = db.Column(db.Integer, primary_key=True)
    ten_phong = db.Column(db.String(100), nullable=False)

    truong_phong_username = db.Column(db.String(64), db.ForeignKey("user.username"), index=True)

    ngay_tao = db.Column(db.DateTime, default=datetime.utcnow)

    members = db.relationship("User", backref="phong_ban", primaryjoin="PhongBan.id==User.phong_ban_id")

    truong_phong = db.relationship("User", foreign_keys=[truong_phong_username], backref="phong_ban_quan_ly")

    def __init__(self, ten_phong, truong_phong_username=None):
        self.ten_phong = ten_phong
        self.truong_phong_username = truong_phong_username

    def is_manager(self, user):
        if user.username == self.truong_phong_username:
            return True

    def to_dict(self):
        return {
            "id": self.id,
            "ten_phong": self.ten_phong,
            "truong_phong_username": self.truong_phong_username,
            "truong_phong": self.truong_phong.to_dict() if self.truong_phong else None,
            "members": [user.to_dict() for user in self.members],
            "ngay_tao": self.ngay_tao.isoformat() if self.ngay_tao else None,
        }

# class OTP(db.Model):
#     __tablename__ = 'otp'
#     id = db.Column(db.Integer, primary_key=True)
#     user_id = db.Column(db.Integer, db.ForeignKey("user.id"))
#     otp_code = db.Column(db.String(6))
#     purpose = db.Column(db.String(64), nullable=False)  # forgot_password, reset_email, reset_password
#     created_at = db.Column(db.DateTime, nullable=False, default=datetime.now)
#     expired_at = db.Column(db.DateTime, nullable=False)

#     def __init__(self, *args, **kwargs):
#         super().__init__(*args, **kwargs)
#         if not self.expired_at:  # Nếu expired_at chưa có, đặt nó = created_at + 5 phút
#             self.expired_at = self.created_at + timedelta(minutes=5)