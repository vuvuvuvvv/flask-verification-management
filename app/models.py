from app.extensions import db
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from datetime import datetime

class User(UserMixin, db.Model):
    __tablename__ = 'user'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), index=True, unique=True, nullable=False)
    fullname = db.Column(db.String(100), index=True, nullable=False, default="404 Notfound")
    email = db.Column(db.String(120), index=True, unique=True, nullable=False)
    password_hash = db.Column(db.String(256), nullable=False)
    role = db.Column(db.String(10), default="USER")

    def set_email(self, email):
        self.email = email

    def set_fullname(self, fullname):
        self.fullname = fullname

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def to_dict(self):
        return {
            'id': self.id,
            'username': self.username,
            'fullname': self.fullname,
            'email': self.email,
            'role': self.role
        }

class TokenBlacklist(db.Model):
    __tablename__ = 'token_blacklist'
    id = db.Column(db.Integer, primary_key=True)
    jti = db.Column(db.String(36), nullable=False, unique=True)
    created_at = db.Column(db.DateTime, nullable=False, default=datetime.now)
    expires_at = db.Column(db.DateTime, nullable=False)

    def __init__(self, jti, expires_at):
        self.jti = jti
        self.expires_at = expires_at


class PDM(db.Model):
    __tablename__ = 'pdm'
    
    id = db.Column(db.Integer, primary_key=True)
    ma_tim_dong_ho_pdm = db.Column(db.String(255), nullable=True)
    ten_dong_ho = db.Column(db.String(255), nullable=False)
    noi_san_xuat = db.Column(db.String(255), nullable=False)
    dn = db.Column(db.String(255), nullable=True)
    ccx = db.Column(db.String(255), nullable=True)
    kieu_sensor = db.Column(db.String(255), nullable=False)
    transmitter = db.Column(db.String(255), nullable=True)
    qn = db.Column(db.String(255), nullable=True)
    q3 = db.Column(db.String(255), nullable=True)
    r = db.Column(db.String(255), nullable=True)
    don_vi_pdm = db.Column(db.String(255), nullable=False)
    dia_chi = db.Column(db.String(255), nullable=True)
    so_qd_pdm = db.Column(db.String(255), nullable=True)
    ngay_qd_pdm = db.Column(db.DateTime, nullable=True)
    ngay_het_han = db.Column(db.DateTime, nullable=True)
    anh_pdm = db.Column(db.String(255), nullable=True)

    def __init__(self, ma_tim_dong_ho_pdm, ten_dong_ho, noi_san_xuat, dn, ccx, kieu_sensor, transmitter, qn, q3, r, don_vi_pdm, dia_chi, so_qd_pdm, ngay_qd_pdm, ngay_het_han, anh_pdm):
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
            'id': self.id,
            'ma_tim_dong_ho_pdm': self.ma_tim_dong_ho_pdm,
            'ten_dong_ho': self.ten_dong_ho,
            'noi_san_xuat': self.noi_san_xuat,
            'dn': self.dn,
            'ccx': self.ccx,
            'kieu_sensor': self.kieu_sensor,
            'transmitter': self.transmitter,
            'qn': self.qn,
            'q3': self.q3,
            'r': self.r,
            'don_vi_pdm': self.don_vi_pdm,
            'dia_chi': self.dia_chi,
            'so_qd_pdm': self.so_qd_pdm,
            'ngay_qd_pdm': self.ngay_qd_pdm,
            'ngay_het_han': self.ngay_het_han,
            'anh_pdm': self.anh_pdm
        }