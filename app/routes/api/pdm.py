from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.models import PDM
from app import db

pdm_bp = Blueprint("pdm", __name__)

@pdm_bp.route("/pdm", methods=["GET"])
@jwt_required()
def get_pdms():
    query = PDM.query

    ma_tim_dong_ho_pdm = request.args.get('ma_tim_dong_ho_pdm')
    if ma_tim_dong_ho_pdm:
        query = query.filter(PDM.ma_tim_dong_ho_pdm == ma_tim_dong_ho_pdm)

    so_qd_pdm = request.args.get('so_qd_pdm')
    if so_qd_pdm:
        query = query.filter(PDM.so_qd_pdm == so_qd_pdm)

    ngay_qd_pdm_from = request.args.get('ngay_qd_pdm_from')
    if ngay_qd_pdm_from:
        query = query.filter(PDM.ngay_qd_pdm >= ngay_qd_pdm_from)

    ngay_qd_pdm_to = request.args.get('ngay_qd_pdm_to')
    if ngay_qd_pdm_to:
        query = query.filter(PDM.ngay_qd_pdm <= ngay_qd_pdm_to)

    pdms = query.all()


    result = [
        {
            "ma_tim_dong_ho_pdm": pdm.ma_tim_dong_ho_pdm,
            "ten_dong_ho": pdm.ten_dong_ho,
            "noi_san_xuat": pdm.noi_san_xuat,
            "dn": pdm.dn,
            "ccx": pdm.ccx,
            "kieu_sensor": pdm.kieu_sensor,
            "transmitter": pdm.transmitter,
            "qn": pdm.qn,
            "q3": pdm.q3,
            "r": pdm.r,
            "don_vi_pdm": pdm.don_vi_pdm,
            "dia_chi": pdm.dia_chi,
            "so_qd_pdm": pdm.so_qd_pdm,
            "ngay_qd_pdm": pdm.ngay_qd_pdm,
            "ngay_het_han": pdm.ngay_het_han,
            "anh_pdm": pdm.anh_pdm
        }
        for pdm in pdms
    ]
    return jsonify(result), 200


@jwt_required()
@pdm_bp.route("/pdms/<int:id>", methods=["GET"])
@jwt_required()
def get_pdm(id):
    pdm = PDM.query.get_or_404(id)
    result = {
            "ma_tim_dong_ho_pdm": pdm.ma_tim_dong_ho_pdm,
            "ten_dong_ho": pdm.ten_dong_ho,
            "noi_san_xuat": pdm.noi_san_xuat,
            "dn": pdm.dn,
            "ccx": pdm.ccx,
            "kieu_sensor": pdm.kieu_sensor,
            "transmitter": pdm.transmitter,
            "qn": pdm.qn,
            "q3": pdm.q3,
            "r": pdm.r,
            "don_vi_pdm": pdm.don_vi_pdm,
            "dia_chi": pdm.dia_chi,
            "so_qd_pdm": pdm.so_qd_pdm,
            "ngay_qd_pdm": pdm.ngay_qd_pdm,
            "ngay_het_han": pdm.ngay_het_han,
            "anh_pdm": pdm.anh_pdm,
        }
    return jsonify(result), 200


@jwt_required()
@pdm_bp.route("/pdms/<int:id>", methods=["DELETE"])
@jwt_required()
def delete_pdm(id):
    pdm = PDM.query.get_or_404(id)
    db.session.delete(pdm)
    db.session.commit()
    return jsonify({"msg": "pdm deleted"}), 200
