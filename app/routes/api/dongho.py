from datetime import datetime
from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from sqlalchemy import and_, or_, cast, Integer
from app.models import DongHo, PDM
from app import db
from werkzeug.exceptions import NotFound
import json
from helper.url_encrypt import decode, encode
from unidecode import unidecode

dongho_bp = Blueprint("dongho", __name__)

@dongho_bp.route("/group", methods=["GET"])
@jwt_required()
def get_nhom_dongho():
    try:
        query = DongHo.query.filter(
            # cast(DongHo.dn, Integer) < 15,
            DongHo.group_id.isnot(None) 
        )

        ten_dong_ho = request.args.get("ten_dong_ho")
        if ten_dong_ho:
            query = query.filter(DongHo.ten_dong_ho.ilike(f"%{ten_dong_ho}%"))

        ten_khach_hang = request.args.get("ten_khach_hang")
        if ten_khach_hang:
            for word in ten_khach_hang.split(" "):
                query = query.filter(DongHo.ten_khach_hang.ilike(f"%{unidecode(word)}%"))

        nguoi_kiem_dinh = request.args.get("nguoi_kiem_dinh")
        if nguoi_kiem_dinh:
            query = query.filter(DongHo.nguoi_kiem_dinh.ilike(f"%{nguoi_kiem_dinh}%"))


        # Chuyển đổi ngày tháng từ chuỗi sang datetime
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[0]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_from = datetime.strptime(ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"}), 400

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[0]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_to = datetime.strptime(ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"}), 400

        # Thực hiện nhóm và đếm trực tiếp trong truy vấn
        result = (
            query
            .with_entities(
                DongHo.group_id,
                db.func.count(DongHo.id).label('so_luong'),
                db.func.max(DongHo.ten_dong_ho).label('ten_dong_ho'),
                db.func.max(DongHo.co_so_san_xuat).label('co_so_san_xuat'),
                db.func.max(DongHo.ten_khach_hang).label('ten_khach_hang'),
                db.func.max(DongHo.co_so_su_dung).label('co_so_su_dung'),
                db.func.max(DongHo.nguoi_kiem_dinh).label('nguoi_kiem_dinh'),
                db.func.max(DongHo.ngay_thuc_hien).label('ngay_thuc_hien'),
            )
            .group_by(DongHo.group_id)
            .all()
        )

        # Chuyển đổi kết quả thành list
        result_list = [
            {
                "group_id": encode(row.group_id),
                "so_luong": row.so_luong,
                "ten_dong_ho": row.ten_dong_ho,
                "co_so_san_xuat": row.co_so_san_xuat,
                "ten_khach_hang": row.ten_khach_hang,
                "co_so_su_dung": row.co_so_su_dung,
                "nguoi_kiem_dinh": row.nguoi_kiem_dinh,
                "ngay_thuc_hien": row.ngay_thuc_hien,
            }
            for row in result
        ]

        return jsonify(result_list), 200
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("", methods=["GET"])
@jwt_required()
def get_donghos():
    try:
        query = DongHo.query
        
        # is_bigger_than_15 = request.args.get("is_bigger_than_15")
        # if is_bigger_than_15 == '1': 
        #     query = query.filter(cast(DongHo.dn, Integer) > 15)
        # else:
        #     query = query.filter(cast(DongHo.dn, Integer) <= 15)

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


        # Chuyển đổi ngày tháng từ chuỗi sang datetime
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[0]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_from = datetime.strptime(ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"}), 400

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[0]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_to = datetime.strptime(ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"}), 400

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
                    return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
            result.append(dongho_dict)
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/get-all-names-exist", methods=["GET"])
# @jwt_required()
def get_all_dongho_names_exist():
    try:
        ten_dong_ho_distinct = PDM.query.with_entities(PDM.ten_dong_ho).distinct().order_by(PDM.ten_dong_ho).all() 
        result = [item[0] for item in ten_dong_ho_distinct]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


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
            nơi_su_dung = data.get("nơi_su_dung"),
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
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/dong-ho-info/<string:info>", methods=["GET"])
@jwt_required()
def get_dongho_by_info(info):
    try:
        if not info:
            return jsonify({"msg": "Thông tin là bắt buộc!"}), 400

        # Check if a DongHo exists with either seri_sensor or seri_chi_thi
        existing_dongho = DongHo.query.filter(
            or_(DongHo.seri_sensor == info, DongHo.seri_chi_thi == info, DongHo.so_tem == info, DongHo.so_giay_chung_nhan == info)
        ).first()

        if existing_dongho:
            return jsonify(existing_dongho.to_dict()), 200
        else:
            return (
                jsonify({"exists": False, "msg": "Thôn tin không tồn tại."}),
                404,
            )

    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500



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
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


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
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


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
                return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
        return jsonify(dongho_dict), 200
    except NotFound:
        return jsonify({"msg": "DongHo not found!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/group_id/<string:group_id>", methods=["GET"])
@jwt_required()
def get_dongho_by_group_id(group_id):
    try:
        decoded_group_id = decode(group_id) 
        donghos = DongHo.query.filter_by(group_id=decoded_group_id).all()
        result = []
        for dongho in donghos:
            dongho_dict = dongho.to_dict()
            if "du_lieu_kiem_dinh" in dongho_dict:
                try:
                    dongho_dict["du_lieu_kiem_dinh"] = json.loads(
                        dongho_dict["du_lieu_kiem_dinh"]
                    )
                except json.JSONDecodeError as e:
                    return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
            result.append(dongho_dict)
        return jsonify(result), 200
    except NotFound:
        return jsonify({"msg": "DongHo not found!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/ten-khach-hang/<string:ten_khach_hang>", methods=["GET"])
@jwt_required()
def get_dongho_by_ten_khach_hang(ten_khach_hang):
    try:
        donghos = DongHo.query.filter_by(ten_khach_hang=ten_khach_hang).all()
        result = [dongho.to_dict() for dongho in donghos]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
