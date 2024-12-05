import os
from sqlalchemy import Integer
from app.extensions import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from datetime import datetime, timedelta
from app.utils.url_encrypt import encode, decode
from flask_jwt_extended import create_access_token, decode_token


class Permission:
    VIEW = 1
    MANAGE = 2
    DIRECTOR = 4
    ADMIN = 8
    SUPERADMIN = 16


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
            self.permissions = 0

    @staticmethod
    def insert_roles():
        roles = {
            "User": (Permission.VIEW, None),
            "Manager": (Permission.VIEW, Permission.MANAGE),
            "Director": (Permission.VIEW, Permission.MANAGE, Permission.DIRECTOR),
            "Administrator": (
                Permission.VIEW,
                Permission.MANAGE,
                Permission.DIRECTOR,
                Permission.ADMIN,
            ),
            "SuperAdministrator": (
                Permission.VIEW,
                Permission.MANAGE,
                Permission.DIRECTOR,
                Permission.ADMIN,
                Permission.SUPERADMIN,
            ),
        }
        default_role = "User"
        for r in roles:
            role = Role.query.filter_by(name=r).first()
            if role is None:
                role = Role(name=r)
            role.reset_permissions()
            for perm in roles[r]:
                if perm:
                    role.add_permission(perm)
            role.default = role.name == default_role
            db.session.add(role)
        db.session.commit()

    def add_permission(self, perm):
        if not self.has_permission(perm):
            self.permissions += perm

    def remove_permission(self, perm):
        if self.has_permission(perm):
            self.permissions -= perm

    def reset_permissions(self):
        self.permissions = 0

    def has_permission(self, perm):
        return self.permissions & perm == perm

    def __repr__(self):
        return "<Role %r>" % self.name


class User(UserMixin, db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True, nullable=False)
    fullname = db.Column(db.String(100), index=True, nullable=False, default="Unknown")
    email = db.Column(db.String(120), index=True, unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)
    role_id = db.Column(db.Integer, db.ForeignKey("roles.id"))
    confirmed = db.Column(db.Boolean, default=False)

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

    def set_fullname(self, fullname):
        self.fullname = fullname

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def can(self, perm):
        return self.role is not None and self.role.has_permission(perm)

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

    def is_administrator(self):
        return self.can(Permission.ADMIN)

    def to_dict(self):
        return {
            "id": self.id,
            "username": self.username,
            "fullname": self.fullname,
            "email": self.email,
            "role": self.role.name if self.role.name else "Unknown",
            "confirmed": self.confirmed,
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
    ma_tim_dong_ho_pdm = db.Column(db.String(255), nullable=True)
    ten_dong_ho = db.Column(db.String(255), nullable=False)
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
    so_qd_pdm = db.Column(db.String(255), nullable=True)
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

    # Nhóm đồng hồ: TENDONGHO+DN+CCX+Q3+R+QN+NGAYTHUCHIEN   (DDMMYYHHmmss)
    group_id = db.Column(db.String(255), nullable=True)

    ten_dong_ho = db.Column(db.String(255), nullable=False)

    phuong_tien_do = db.Column(db.String(255), nullable=True)
    seri_chi_thi = db.Column(db.String(255), nullable=True)
    seri_sensor = db.Column(db.String(255), nullable=True)
    kieu_chi_thi = db.Column(db.String(255), nullable=True)
    kieu_sensor = db.Column(db.String(255), nullable=True)
    kieu_thiet_bi = db.Column(db.String(255), nullable=True)
    co_so_san_xuat = db.Column(db.String(255), nullable=True)
    so_tem = db.Column(db.String(255), nullable=True)
    nam_san_xuat = db.Column(db.Date, nullable=True)
    dn = db.Column(db.String(255), nullable=True)
    d = db.Column(db.String(255), nullable=True)
    ccx = db.Column(db.String(255), nullable=True)
    q3 = db.Column(db.String(255), nullable=True)
    r = db.Column(db.String(255), nullable=True)
    qn = db.Column(db.String(255), nullable=True)
    k_factor = db.Column(db.String(255), nullable=True)
    so_qd_pdm = db.Column(db.String(255), nullable=True)
    ten_khach_hang = db.Column(db.String(255), nullable=True)
    co_so_su_dung = db.Column(db.String(255), nullable=True)
    noi_su_dung = db.Column(db.String(255), nullable=True)
    vi_tri = db.Column(db.String(255), nullable=True)  # dia diem noi su dung
    noi_thuc_hien = db.Column(db.String(255), nullable=True)
    phuong_phap_thuc_hien = db.Column(db.String(255), nullable=True)
    chuan_thiet_bi_su_dung = db.Column(db.String(255), nullable=True)
    nguoi_kiem_dinh = db.Column(db.String(255), nullable=True)
    nguoi_soat_lai = db.Column(db.String(255), nullable=True)
    ngay_thuc_hien = db.Column(db.Date, nullable=True)
    hieu_luc_bien_ban = db.Column(db.Date, nullable=True)
    nhiet_do = db.Column(db.String(255), nullable=True)
    do_am = db.Column(db.String(255), nullable=True)
    du_lieu_kiem_dinh = db.Column(db.Text, nullable=True)
    so_giay_chung_nhan = db.Column(db.String(255), nullable=True)
    update_history = db.Column(db.Text, nullable=True)

    def __init__(
        self,
        group_id,
        ten_dong_ho,
        phuong_tien_do,
        seri_chi_thi,
        seri_sensor,
        kieu_chi_thi,
        kieu_sensor,
        kieu_thiet_bi,
        co_so_san_xuat,
        so_tem,
        nam_san_xuat,
        dn,
        d,
        ccx,
        q3,
        r,
        qn,
        k_factor,
        so_qd_pdm,
        ten_khach_hang,
        co_so_su_dung,
        phuong_phap_thuc_hien,
        chuan_thiet_bi_su_dung,
        nguoi_kiem_dinh,
        nguoi_soat_lai,
        ngay_thuc_hien,
        noi_su_dung,
        vi_tri,
        nhiet_do,
        do_am,
        noi_thuc_hien,
        du_lieu_kiem_dinh,
        hieu_luc_bien_ban,
        so_giay_chung_nhan,
        update_history,
    ):
        self.group_id = group_id
        self.ten_dong_ho = ten_dong_ho
        self.phuong_tien_do = phuong_tien_do
        self.seri_chi_thi = seri_chi_thi
        self.seri_sensor = seri_sensor
        self.kieu_chi_thi = kieu_chi_thi
        self.kieu_sensor = kieu_sensor
        self.kieu_thiet_bi = kieu_thiet_bi
        self.co_so_san_xuat = co_so_san_xuat
        self.so_tem = so_tem
        self.nam_san_xuat = nam_san_xuat
        self.dn = dn
        self.d = d
        self.ccx = ccx
        self.q3 = q3
        self.r = r
        self.qn = qn
        self.k_factor = k_factor
        self.so_qd_pdm = so_qd_pdm
        self.ten_khach_hang = ten_khach_hang
        self.co_so_su_dung = co_so_su_dung
        self.phuong_phap_thuc_hien = phuong_phap_thuc_hien
        self.chuan_thiet_bi_su_dung = chuan_thiet_bi_su_dung
        self.nguoi_kiem_dinh = nguoi_kiem_dinh
        self.nguoi_soat_lai = nguoi_soat_lai
        self.ngay_thuc_hien = ngay_thuc_hien
        self.noi_su_dung = noi_su_dung
        self.vi_tri = vi_tri
        self.nhiet_do = nhiet_do
        self.noi_thuc_hien = noi_thuc_hien
        self.do_am = do_am
        self.du_lieu_kiem_dinh = du_lieu_kiem_dinh
        self.hieu_luc_bien_ban = hieu_luc_bien_ban
        self.so_giay_chung_nhan = so_giay_chung_nhan
        self.update_history = update_history

    def to_dict(self):
        return {
            "id": encode(self.id),
            "group_id": encode(self.group_id),
            "ten_dong_ho": self.ten_dong_ho,
            "phuong_tien_do": self.phuong_tien_do,
            "seri_chi_thi": self.seri_chi_thi,
            "seri_sensor": self.seri_sensor,
            "kieu_chi_thi": self.kieu_chi_thi,
            "kieu_sensor": self.kieu_sensor,
            "kieu_thiet_bi": self.kieu_thiet_bi,
            "co_so_san_xuat": self.co_so_san_xuat,
            "so_tem": self.so_tem,
            "nam_san_xuat": self.nam_san_xuat,
            "dn": self.dn,
            "d": self.d,
            "ccx": self.ccx,
            "q3": self.q3,
            "r": self.r,
            "qn": self.qn,
            "k_factor": self.k_factor,
            "so_qd_pdm": self.so_qd_pdm,
            "ten_khach_hang": self.ten_khach_hang,
            "co_so_su_dung": self.co_so_su_dung,
            "phuong_phap_thuc_hien": self.phuong_phap_thuc_hien,
            "chuan_thiet_bi_su_dung": self.chuan_thiet_bi_su_dung,
            "nguoi_kiem_dinh": self.nguoi_kiem_dinh,
            "nguoi_soat_lai": self.nguoi_soat_lai,
            "ngay_thuc_hien": self.ngay_thuc_hien,
            "noi_su_dung": self.noi_su_dung,
            "vi_tri": self.vi_tri,
            "noi_thuc_hien": self.noi_thuc_hien,
            "nhiet_do": self.nhiet_do,
            "do_am": self.do_am,
            "du_lieu_kiem_dinh": self.du_lieu_kiem_dinh,
            "hieu_luc_bien_ban": self.hieu_luc_bien_ban,
            "so_giay_chung_nhan": self.so_giay_chung_nhan,
            "update_history": self.update_history,
        }


class NhomDongHoPayment(db.Model):
    __tablename__ = "nhomdongho_payment"
    id = db.Column(db.Integer, primary_key=True)
    group_id = db.Column(db.String(50), nullable=False)
    is_paid = db.Column(db.Boolean, default=False, nullable=False)
    paid_date = db.Column(db.DateTime, nullable=True)
    payment_collector = db.Column(db.String(50), nullable=True)
    update_history = db.Column(db.Text, nullable=True)

    def __init__(self, group_id, is_paid=False, paid_date=None, payment_collector=None, update_history = None):
        self.group_id = group_id
        self.is_paid = is_paid
        self.paid_date = paid_date
        self.payment_collector = payment_collector
        self.update_history = update_history

    def to_dict(self):
        return {
            "id": encode(self.id),
            "group_id": encode(self.group_id),
            "is_paid": self.is_paid,
            "paid_date": self.paid_date,
            "payment_collector": self.payment_collector,
            "update_history": self.update_history,
        }
