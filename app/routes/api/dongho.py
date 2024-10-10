from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.models import DongHo
from app import db
from werkzeug.exceptions import NotFound
import json

dongho_bp = Blueprint("dongho", __name__)


@dongho_bp.route("", methods=["GET"])
@jwt_required()
def get_donghos():
    try:
        query = DongHo.query

        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            query = query.filter(DongHo.so_giay_chung_nhan.ilike(f"%{so_giay_chung_nhan}%"))

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
        serial_number = data.get("serial_number")
        # Check if serial_number already exists
        existing_dongho = DongHo.query.filter_by(serial_number=serial_number).first()
        if existing_dongho:
            return jsonify({"msg": "Serial number đã tồn tại!"}), 400
        new_dongho = DongHo(**data)
        db.session.add(new_dongho)
        db.session.commit()
        return jsonify(new_dongho.to_dict()), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("/<int:id>", methods=["PUT"])
@jwt_required()
def update_dongho(id):
    try:
        data = request.get_json()
        dongho = DongHo.query.get_or_404(id)
        for key, value in data.items():
            setattr(dongho, key, value)
        db.session.commit()
        return jsonify(dongho.to_dict()), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("/<string:serial_number>", methods=["DELETE"])
@jwt_required()
def delete_dongho(serial_number):
    try:
        dongho = DongHo.query.get_or_404(serial_number)
        db.session.delete(dongho)
        db.session.commit()
        return jsonify({"msg": "Xóa thành công!"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500


@dongho_bp.route("/serial-number/<string:serial_number>", methods=["GET"])
@jwt_required()
def get_dongho_by_serial_number(serial_number):
    try:
        dongho = DongHo.query.filter_by(serial_number=serial_number).first_or_404()
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
        return jsonify({"msg": "Serial number not found!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500

@dongho_bp.route("/ten-khach-hang/<string:ten_khach_hang>", methods=["GET"])
@jwt_required()
def get_dongho_by_ten_khach_hang(ten_khach_hang):
    try:
        donghos = DongHo.query.filter_by(ten_khach_hang=ten_khach_hang).all()
        result = [dongho.to_dict() for dongho in donghos]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã xảy ra lỗi: {str(e)}"}), 500
