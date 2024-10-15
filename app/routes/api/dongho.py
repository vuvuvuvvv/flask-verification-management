from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from sqlalchemy import and_, or_
from app.models import DongHo
from app import db
from werkzeug.exceptions import NotFound
import json
from helper.url_encrypt import decode

dongho_bp = Blueprint("dongho", __name__)


@dongho_bp.route("", methods=["GET"])
@jwt_required()
def get_donghos():
    try:
        query = DongHo.query

        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            query = query.filter(
                DongHo.so_giay_chung_nhan.ilike(f"%{so_giay_chung_nhan}%")
            )

        ten_khach_hang = request.args.get("ten_khach_hang")
        if ten_khach_hang:
            query = query.filter(DongHo.ten_khach_hang.ilike(f"%{ten_khach_hang}%"))

        nguoi_kiem_dinh = request.args.get("nguoi_kiem_dinh")
        if nguoi_kiem_dinh:
            query = query.filter(DongHo.nguoi_kiem_dinh.ilike(f"%{nguoi_kiem_dinh}%"))

        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            query = query.filter(DongHo.ngay_qd_pdm >= ngay_kiem_dinh_from)

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            query = query.filter(DongHo.ngay_qd_pdm <= ngay_kiem_dinh_to)

        donghos = query.all()

        result = []
        for dongho in donghos:
            dongho_dict = dongho.to_dict()
            if "du_lieu_kiem_dinh" in dongho_dict:
                try:
                    dongho_dict["du_lieu_kiem_dinh"] = json.loads(
                        dongho_dict["du_lieu_kiem_dinh"]
                    )
                except json.JSONDecodeError as e:
                    return jsonify({"msg": f"JSON decode error: {str(e)}"}), 500
            result.append(dongho_dict)
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("", methods=["POST"])
@jwt_required()
def create_dongho():
    try:
        data = request.get_json()
        data.pop('id', None)

        seri_sensor = data.get("seri_sensor")
        seri_chi_thi = data.get("seri_chi_thi")

        existing_dongho = DongHo.query.filter(    
            or_(
                and_(DongHo.seri_sensor == seri_sensor, DongHo.seri_sensor != None, DongHo.seri_sensor != ""),
                and_(DongHo.seri_chi_thi == seri_chi_thi, DongHo.seri_chi_thi != None, DongHo.seri_chi_thi != "")
            )
        ).first()

        if existing_dongho:
            return (
                jsonify(
                    {
                        "msg": "Serial number hoặc Serial chỉ thị đã tồn tại!"
                    }
                ),
                400,
            )
        new_dongho = DongHo(
            group_id = data.get("group_id"),
            ten_dong_ho = data.get("ten_dong_ho"),
            phuong_tien_do = data.get("phuong_tien_do"),
            seri_chi_thi = data.get("seri_chi_thi"),
            seri_sensor = data.get("seri_sensor"),
            kieu_chi_thi = data.get("kieu_chi_thi"),
            kieu_sensor = data.get("kieu_sensor"),
            kieu_thiet_bi = data.get("kieu_thiet_bi"),
            co_so_san_xuat = data.get("co_so_san_xuat"),
            so_tem = data.get("so_tem"),
            nam_san_xuat = data.get("nam_san_xuat"),
            dn = data.get("dn"),
            d = data.get("d"),
            ccx = data.get("ccx"),
            q3 = data.get("q3"),
            r = data.get("r"),
            qn = data.get("qn"),
            k_factor = data.get("k_factor"),
            so_qd_pdm = data.get("so_qd_pdm"),
            ten_khach_hang = data.get("ten_khach_hang"),
            co_so_su_dung = data.get("co_so_su_dung"),
            phuong_phap_thuc_hien = data.get("phuong_phap_thuc_hien"),
            chuan_thiet_bi_su_dung = data.get("chuan_thiet_bi_su_dung"),
            nguoi_kiem_dinh = data.get("nguoi_kiem_dinh"),
            ngay_thuc_hien = data.get("ngay_thuc_hien"),
            vi_tri = data.get("vi_tri"),
            nhiet_do = data.get("nhiet_do"),
            do_am = data.get("do_am"),
            du_lieu_kiem_dinh = data.get("du_lieu_kiem_dinh"),
            hieu_luc_bien_ban = data.get("hieu_luc_bien_ban"),
            so_giay_chung_nhan = data.get("so_giay_chung_nhan"),
        )

        db.session.add(new_dongho)
        db.session.commit()
        return jsonify(new_dongho.to_dict()), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("/check-serial/<string:seri>", methods=["GET"])
@jwt_required()
def check_serial():
    try:
        data = request.get_json()
        seri = data.get("seri")
        if not seri:
            return jsonify({"msg": "Serial number is required!"}), 400

        # Check if a DongHo exists with either seri_sensor or seri_chi_thi
        existing_dongho = DongHo.query.filter(
            or_(DongHo.seri_sensor == seri, DongHo.seri_chi_thi == seri)
        ).first()

        if existing_dongho:
            return (
                jsonify({"exists": True, "msg": "A DongHo with this serial exists."}),
                200,
            )
        else:
            return (
                jsonify({"exists": False, "msg": "No DongHo with this serial found."}),
                404,
            )

    except Exception as e:
        return jsonify({"msg": f"An error occurred: {str(e)}"}), 500


@dongho_bp.route("/<string:id>", methods=["PUT"])
@jwt_required()
def update_dongho():
    try:
        data = request.get_json()
        dongho = DongHo.query.get_or_404(decode(data.get("id")))
        for key, value in data.items():
            setattr(dongho, key, value)
        db.session.commit()
        return jsonify(dongho.to_dict()), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("/<string:id>", methods=["DELETE"])
@jwt_required()
def delete_dongho():
    try:
        data = request.get_json()
        id = decode(data.get("id"))
        dongho = DongHo.query.get_or_404(id)
        db.session.delete(dongho)
        db.session.commit()
        return jsonify({"msg": "Xóa thành công!"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("/id/<string:id>", methods=["GET"])
@jwt_required()
def get_dongho_by_id(id):
    try:
        decoded_id = decode(id) 
        dongho = DongHo.query.filter_by(id=decoded_id).first_or_404()
        dongho_dict = dongho.to_dict()
        if "du_lieu_kiem_dinh" in dongho_dict:
            try:
                dongho_dict["du_lieu_kiem_dinh"] = json.loads(
                    dongho_dict["du_lieu_kiem_dinh"]
                )
            except json.JSONDecodeError as e:
                return jsonify({"msg": f"JSON decode error: {str(e)}"}), 500
        return jsonify(dongho_dict), 200
    except NotFound:
        return jsonify({"msg": "DongHo not found!"}), 404
    except Exception as e:
        return jsonify({"msg": f"An error occurred: {str(e)}"}), 500


@dongho_bp.route("/ten-khach-hang/<string:ten_khach_hang>", methods=["GET"])
@jwt_required()
def get_dongho_by_ten_khach_hang(ten_khach_hang):
    try:
        donghos = DongHo.query.filter_by(ten_khach_hang=ten_khach_hang).all()
        result = [dongho.to_dict() for dongho in donghos]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500
