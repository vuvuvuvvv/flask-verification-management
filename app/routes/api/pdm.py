from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.models import PDM
from app import db

pdm_bp = Blueprint("pdm", __name__)


@pdm_bp.route("/pdm", methods=["GET"])
@jwt_required()
def get_pdms():
    query = PDM.query

    ma_tim_dong_ho_pdm = request.args.get("ma_tim_dong_ho_pdm")
    if ma_tim_dong_ho_pdm:
        query = query.filter(PDM.ma_tim_dong_ho_pdm.ilike(f"%{ma_tim_dong_ho_pdm}%"))

    so_qd_pdm = request.args.get("so_qd_pdm")
    if so_qd_pdm:
        query = query.filter(PDM.so_qd_pdm.ilike(f"%{so_qd_pdm}%"))

    ngay_qd_pdm_from = request.args.get("ngay_qd_pdm_from")
    if ngay_qd_pdm_from:
        query = query.filter(PDM.ngay_qd_pdm >= ngay_qd_pdm_from)

    ngay_qd_pdm_to = request.args.get("ngay_qd_pdm_to")  # 2024-08-13 00:00:00
    if ngay_qd_pdm_to:
        query = query.filter(PDM.ngay_qd_pdm <= ngay_qd_pdm_to)

    tinh_trang = request.args.get("tinh_trang") 
    if tinh_trang:
        if int(tinh_trang) == 1:
            query = query.filter(PDM.ngay_het_han >= db.func.current_date())
        else:
            query = query.filter(PDM.ngay_het_han < db.func.current_date())

    pdms = query.all()

    result = [pdm.to_dict() for pdm in pdms]
    return jsonify(result), 200


@pdm_bp.route("/pdm", methods=["POST"])
@jwt_required()
def create_pdm():
    data = request.get_json()

    new_pdm = PDM(
        ma_tim_dong_ho_pdm=data.get("ma_tim_dong_ho_pdm"),
        ten_dong_ho=data.get("ten_dong_ho"),
        noi_san_xuat=data.get("noi_san_xuat"),
        dn=data.get("dn"),
        ccx=data.get("ccx"),
        kieu_sensor=data.get("kieu_sensor"),
        transmitter=data.get("transmitter"),
        qn=data.get("qn"),
        q3=data.get("q3"),
        r=data.get("r"),
        don_vi_pdm=data.get("don_vi_pdm"),
        dia_chi=data.get("dia_chi"),
        so_qd_pdm=data.get("so_qd_pdm"),
        ngay_qd_pdm=data.get("ngay_qd_pdm"),
        ngay_het_han=data.get("ngay_het_han"),
        anh_pdm=data.get("anh_pdm"),
    )

    db.session.add(new_pdm)
    db.session.commit()

    return jsonify(new_pdm.to_dict()), 201


@pdm_bp.route("/pdms/<int:id>", methods=["GET"])
@jwt_required()
def get_pdm(id):
    pdm = PDM.query.get_or_404(id)
    return jsonify(pdm.to_dict()), 200


@pdm_bp.route("/pdm/<int:id>", methods=["DELETE"])
@jwt_required()
def delete_pdm(id):
    pdm = PDM.query.get_or_404(id)
    db.session.delete(pdm)
    db.session.commit()
    return jsonify({"msg": "PDM deleted successfully!"}), 200