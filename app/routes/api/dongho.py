from datetime import datetime, timedelta
import math
import os
from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy import and_, or_, cast, Integer
from app.models import (
    DongHo,
    PDM,
    Role,
    User,
    PhongBan
)
from app import db
from werkzeug.exceptions import NotFound
import json
from app.utils.url_encrypt import decode, encode
from unidecode import unidecode

dongho_bp = Blueprint("dongho", __name__)

# @dongho_bp.route("/group", methods=["GET"])
# @jwt_required()
# def get_nhom_dongho():
#     try:
#         query = DongHo.query.filter(
#             DongHo.group_id.isnot(None),
#             DongHo.is_hieu_chuan == False
#         )

#         ten_phuong_tien_do = request.args.get("ten_phuong_tien_do")
#         if ten_phuong_tien_do:
#             query = query.filter(DongHo.ten_phuong_tien_do.ilike(f"%{ten_phuong_tien_do}%"))

#         nguoi_thuc_hien = request.args.get("nguoi_thuc_hien")
#         if nguoi_thuc_hien:
#             query = query.filter(DongHo.nguoi_thuc_hien.ilike(f"%{nguoi_thuc_hien}%"))

#         # Chuyển đổi ngày tháng từ chuỗi sang datetime
#         ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
#         if ngay_kiem_dinh_from:
#             try:
#                 # Loại bỏ phần không cần thiết
#                 ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[
#                     0
#                 ]  # Chỉ lấy phần trước "(Indochina Time)"
#                 ngay_kiem_dinh_from = datetime.strptime(
#                     ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z"
#                 )
#                 query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
#             except ValueError as e:
#                 return (
#                     jsonify(
#                         {
#                             "msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"
#                         }
#                     ),
#                     400,
#                 )

#         ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
#         if ngay_kiem_dinh_to:
#             try:
#                 # Loại bỏ phần không cần thiết
#                 ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[
#                     0
#                 ]  # Chỉ lấy phần trước "(Indochina Time)"
#                 ngay_kiem_dinh_to = datetime.strptime(
#                     ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z"
#                 )
#                 query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
#             except ValueError as e:
#                 return (
#                     jsonify(
#                         {
#                             "msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"
#                         }
#                     ),
#                     400,
#                 )
        
#         grouped_query = query.with_entities(
#             DongHo.group_id,
#             db.func.count(DongHo.id).label("so_luong"),
#             db.func.max(DongHo.ten_phuong_tien_do).label("ten_phuong_tien_do"),
#             db.func.max(DongHo.co_so_san_xuat).label("co_so_san_xuat"),
#             db.func.max(DongHo.co_so_su_dung).label("co_so_su_dung"),
#             db.func.max(DongHo.nguoi_thuc_hien).label("nguoi_thuc_hien"),
#             db.func.max(DongHo.ngay_thuc_hien).label("ngay_thuc_hien"),
#         ).group_by(DongHo.group_id)

#         total_records = grouped_query.count()

#         # Thực hiện nhóm và đếm trực tiếp trong truy vấn
#         limit = int(request.args.get("limit", 10))
#         page = int(request.args.get("page", 1))

#         result = (
#             grouped_query.offset(limit * (page-1)).limit(limit).all()
#         )

#         result_list = [
#             {
#                 "group_id": row.group_id,
#                 "so_luong": row.so_luong,
#                 "co_so_san_xuat": row.co_so_san_xuat,
#                 "co_so_su_dung": row.co_so_su_dung,
#                 "nguoi_thuc_hien": row.nguoi_thuc_hien,
#                 "ngay_thuc_hien": row.ngay_thuc_hien,
#                 "is_paid": True,
#             }
#             for row in result
#         ]

#         return jsonify({"total_page": math.ceil(total_records / limit),"total_records": total_records, "groups": result_list}), 200
#     except Exception as e:
#         print(e)
#         return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/group", methods=["GET"])
@jwt_required()
def get_nhom_dongho():
    try:
        identity = get_jwt_identity()
        current_username = None
        if isinstance(identity, dict):
            current_username = identity.get("username")  # lấy key đúng trong dict
        else:
            current_username = identity
        current_user = User.query.filter_by(username=current_username).first()
        if not current_user:
            return jsonify({"msg": "User not found"}), 404

        # Kiểm tra xem user có phải trưởng phòng không, lấy phòng ban nếu có
        phong_ban = PhongBan.query.filter_by(truong_phong_username=current_user.username).first()

        # Lấy danh sách user_id cần lấy đồng hồ
        if phong_ban:
            # Lấy tất cả thành viên phòng ban (bao gồm cả trưởng phòng)
            user_ids = [user.id for user in phong_ban.members]
            # Thêm trưởng phòng vì members không bao gồm trưởng phòng (theo định nghĩa quan hệ)
            user_ids.append(current_user.id)
        else:
            user_ids = [current_user.id]

        query = DongHo.query.filter(
            DongHo.group_id.isnot(None),
            DongHo.is_hieu_chuan == False,
            DongHo.created_by.in_(user_ids)
        )

        ten_phuong_tien_do = request.args.get("ten_phuong_tien_do")
        if ten_phuong_tien_do:
            query = query.filter(DongHo.ten_phuong_tien_do.ilike(f"%{ten_phuong_tien_do}%"))

        nguoi_thuc_hien = request.args.get("nguoi_thuc_hien")
        if nguoi_thuc_hien:
            query = query.filter(DongHo.nguoi_thuc_hien.ilike(f"%{nguoi_thuc_hien}%"))

        # Xử lý ngày kiểm định from
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[0]
                ngay_kiem_dinh_from = datetime.strptime(ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"}), 400

        # Xử lý ngày kiểm định to
        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[0]
                ngay_kiem_dinh_to = datetime.strptime(ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"}), 400

        grouped_query = query.with_entities(
            DongHo.group_id,
            db.func.count(DongHo.id).label("so_luong"),
            db.func.max(DongHo.ten_phuong_tien_do).label("ten_phuong_tien_do"),
            db.func.max(DongHo.co_so_san_xuat).label("co_so_san_xuat"),
            db.func.max(DongHo.co_so_su_dung).label("co_so_su_dung"),
            db.func.max(DongHo.nguoi_thuc_hien).label("nguoi_thuc_hien"),
            db.func.max(DongHo.ngay_thuc_hien).label("ngay_thuc_hien"),
        ).group_by(DongHo.group_id)

        total_records = grouped_query.count()

        limit = int(request.args.get("limit", 10))
        page = int(request.args.get("page", 1))

        result = grouped_query.offset(limit * (page - 1)).limit(limit).all()

        result_list = [
            {
                "group_id": row.group_id,
                "so_luong": row.so_luong,
                "co_so_san_xuat": row.co_so_san_xuat,
                "co_so_su_dung": row.co_so_su_dung,
                "nguoi_thuc_hien": row.nguoi_thuc_hien,
                "ngay_thuc_hien": row.ngay_thuc_hien,
                "is_paid": True,
            }
            for row in result
        ]

        return jsonify({
            "total_page": math.ceil(total_records / limit),
            "total_records": total_records,
            "groups": result_list
        }), 200

    except Exception as e:
        print(e)
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/permission/group/<string:username>", methods=["GET"])
@jwt_required()
def get_nhom_dongho_with_permission(username):
    try:
        queryDHP = DongHo.query

        # Apply filters if needed (similar to get_donghos_with_permission)
        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            queryDHP = queryDHP.filter(
                DongHo.so_giay_chung_nhan.ilike(f"%{so_giay_chung_nhan}%")
            )

        serial = request.args.get("serial")
        if serial:
            queryDHP = queryDHP.filter(DongHo.serial.ilike(f"%{serial}%"))

        # Date filters
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[0]
                ngay_kiem_dinh_from = datetime.strptime(
                    ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                queryDHP = queryDHP.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"
                        }
                    ),
                    400,
                )

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[0]
                ngay_kiem_dinh_to = datetime.strptime(
                    ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                queryDHP = queryDHP.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"
                        }
                    ),
                    400,
                )

        # Group by group_id and aggregate results
        queryDHP = queryDHP.with_entities(
                DongHo.group_id,
                db.func.count(DongHo.id).label("so_luong"),
                db.func.max(DongHo.co_so_san_xuat).label("co_so_san_xuat"),
                db.func.max(DongHo.co_so_su_dung).label("co_so_su_dung"),
                db.func.max(DongHo.nguoi_thuc_hien).label("nguoi_thuc_hien"),
                db.func.max(DongHo.ngay_thuc_hien).label("ngay_thuc_hien"),
            ).group_by(DongHo.group_id)

        total_records = queryDHP.count()

        # Thực hiện nhóm và đếm trực tiếp trong truy vấn
        limit = int(request.args.get("ngay_kiem_dinh_to", 10))
        page = int(request.args.get("ngay_kiem_dinh_to", 1))

        result = (
            queryDHP.offset(limit * (page-1)).limit(limit).all()
        )

        # Fetch payment status

        # Prepare the result list
        result_list = [
            {
                "group_id": row.group_id,
                "so_luong": row.so_luong,
                "co_so_san_xuat": row.co_so_san_xuat,
                "co_so_su_dung": row.co_so_su_dung,
                "nguoi_thuc_hien": row.nguoi_thuc_hien,
                "ngay_thuc_hien": row.ngay_thuc_hien,
                "is_paid": True,
            }
            for row in result
        ]
        return jsonify({"total_page": math.ceil(total_records / limit),"total_records": total_records, "groups": result_list}), 200
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("", methods=["GET"])
@jwt_required()
def get_donghos():
    try:
        identity = get_jwt_identity()
        current_username = identity if isinstance(identity, str) else identity.get("username")
        current_user = User.query.filter_by(username=current_username).first()
        if not current_user:
            return jsonify({"msg": "User không tồn tại"}), 404

        phong_ban = None
        if current_user.phong_ban_id:
            phong_ban = PhongBan.query.get(current_user.phong_ban_id)

        # Nếu user là trưởng phòng của phòng ban thì lấy dongho của tất cả thành viên phòng đó
        if phong_ban and phong_ban.is_manager(current_user):
            user_ids = [u.id for u in phong_ban.members]
        else:
            user_ids = [current_user.id]

        query = DongHo.query.filter(
            DongHo.is_hieu_chuan == False,
            DongHo.created_by.in_(user_ids)
        )

        # Các filter tìm kiếm
        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            query = query.filter(DongHo.so_giay_chung_nhan.ilike(f"%{so_giay_chung_nhan}%"))

        serial = request.args.get("serial")
        if serial:
            query = query.filter(DongHo.serial.ilike(f"%{serial}%"))

        nguoi_thuc_hien = request.args.get("nguoi_thuc_hien")
        if nguoi_thuc_hien:
            query = query.filter(DongHo.nguoi_thuc_hien.ilike(f"%{nguoi_thuc_hien}%"))

        # Lọc theo ngày thực hiện (ngày_kiem_dinh_from, ngày_kiem_dinh_to)
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[0]
                ngay_kiem_dinh_from = datetime.strptime(ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"}), 400

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[0]
                ngay_kiem_dinh_to = datetime.strptime(ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z")
                query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return jsonify({"msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"}), 400

        donghos = query.order_by(DongHo.id.asc()).all()

        result = []
        for dongho in donghos:
            dongho_dict = dongho.to_dict()
            if "du_lieu_kiem_dinh" in dongho_dict and dongho_dict["du_lieu_kiem_dinh"]:
                try:
                    dongho_dict["du_lieu_kiem_dinh"] = json.loads(dongho_dict["du_lieu_kiem_dinh"])
                except json.JSONDecodeError:
                    return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
            result.append(dongho_dict)

        return jsonify({"total_records": len(result), "donghos": result}), 200

    except Exception as e:
        print(e)
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


# Lấy ra toàn bộ dongHo hợp lệ với vai trò người dùng (<= Admin)
# SuperAdmin thì lấy ra toàn bộ: @dongho_bp.route("", methods=["GET"])
@dongho_bp.route("/permission/<string:username>", methods=["GET"])
@jwt_required()
def get_donghos_with_permission(username):
    try:

        queryDHP = DongHo.query

        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            queryDHP = queryDHP.filter(
                DongHo.so_giay_chung_nhan.ilike(
                    f"%{so_giay_chung_nhan}%"
                )
            )

        serial = request.args.get("serial")
        if serial:
            queryDHP = queryDHP.filter(
                DongHo.serial.ilike(f"%{serial}%")
            )

        # Chuyển đổi ngày tháng từ chuỗi sang datetime
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[
                    0
                ]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_from = datetime.strptime(
                    ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                queryDHP = queryDHP.filter(
                    DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from
                )
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"
                        }
                    ),
                    400,
                )

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[
                    0
                ]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_to = datetime.strptime(
                    ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                queryDHP = queryDHP.filter(
                    DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to
                )
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"
                        }
                    ),
                    400,
                )
            
        # Get total records
        total_count = queryDHP.count()

        # Keyset pagination
        limit = int(request.args.get("limit", 10))  
        last_seen_encoded = request.args.get("last_seen", "")
        last_seen = 0
        if last_seen_encoded:
            try:
                last_seen = int(decode(last_seen_encoded))
            except Exception as e:
                print(f"Decoding error: {e}")
        next_from_encoded = request.args.get("next_from", "")
        next_from_id = 0
        if next_from_encoded:
            try:
                next_from_id = int(decode(next_from_encoded))
            except Exception as e:
                print(f"Decoding error: {e}")
                
        prev_from_encoded = request.args.get("prev_from", "")
        prev_from_id = 0
        if prev_from_encoded:
            try:
                prev_from_id = int(decode(prev_from_encoded))
            except Exception as e:
                print(f"Decoding error: {e}")
        
        if last_seen:
            queryDHP = queryDHP.filter(DongHo.id >= last_seen).order_by(DongHo.id.asc()).limit(limit)
        else:
            if prev_from_id != 0 and next_from_id != 0:
                queryDHP = queryDHP.filter(DongHo.id > 0).order_by(DongHo.id.asc()).limit(limit)
            elif prev_from_id != 0:
                queryDHP = queryDHP.filter(DongHo.id < prev_from_id).order_by(DongHo.id.desc()).limit(limit)
            else:
                queryDHP = queryDHP.filter(DongHo.id > next_from_id).order_by(DongHo.id.asc()).limit(limit)

        donghosWithPer = queryDHP.all()
        if prev_from_id:
            donghosWithPer = list(reversed(donghosWithPer))
        
        result = []
        for dwp in donghosWithPer:
            dongho = dwp.dongho
            if dongho:
                dongho_dict = None if not dongho else dongho.to_dict()
                if "du_lieu_kiem_dinh" in dongho_dict:
                    try:
                        dongho_dict["du_lieu_kiem_dinh"] = json.loads(
                            dongho_dict["du_lieu_kiem_dinh"]
                        )
                    except json.JSONDecodeError as e:
                        return (
                            jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}),
                            500,
                        )
                dongho_dict["current_permission"] = dwp.role.name
                result.append(dongho_dict)
                
        return jsonify({"total_page": math.ceil(total_count / limit),"total_records": total_count, "donghos": result}), 200
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

def _get_last_day_of_month_in_future(years: int, date: datetime) -> datetime:
    return datetime(date.year + years, date.month + 1, 1) - timedelta(days=1)

# Create cả kiểm định + hiệu chuẩn
@dongho_bp.route("", methods=["POST"])
@jwt_required()
def create_dongho():
    try:
        data = request.get_json()
        current_user_identity = get_jwt_identity()
        data.pop("id", None)
        hieu_luc_bien_ban = None
        if data.get("so_giay_chung_nhan") and data.get("so_tem"):
            ngay_thuc_hien = data.get("ngay_thuc_hien")
            if ngay_thuc_hien:
                try:
                    if len(ngay_thuc_hien) < 20 or "T" not in ngay_thuc_hien or "Z" not in ngay_thuc_hien:
                        raise ValueError("Invalid datetime format.")
                    
                    ngay_thuc_hien_date = datetime.strptime(
                        ngay_thuc_hien, "%Y-%m-%dT%H:%M:%S.%fZ"
                    )
                    # print(f"Parsed date: {ngay_thuc_hien_date}")
                except ValueError as e:
                    # print(f"Date parsing error: {e}, Input: {ngay_thuc_hien}")
                    return jsonify({"msg": "Ngày thực hiện không hợp lệ!"}), 400

                if not (1 <= ngay_thuc_hien_date.month <= 12):
                    return jsonify({"msg": "Tháng không hợp lệ trong ngày thực hiện!"}), 400

                if data.get("is_hieu_chuan"):
                    print("create")
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        1, ngay_thuc_hien_date
                    )
                    print(hieu_luc_bien_ban)
                elif data.get("q3"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        3, ngay_thuc_hien_date
                    )
                elif data.get("qn"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        5, ngay_thuc_hien_date
                    )

                if hieu_luc_bien_ban:
                    hieu_luc_bien_ban = hieu_luc_bien_ban.date()
        # serial = data.get("serial")

        # existing_dongho = DongHo.query.filter(
        #     and_(
        #         DongHo.serial == serial,
        #         DongHo.serial != None,
        #         DongHo.serial != "",
        #     )
        # ).first()

        # if existing_dongho:
        #     return (
        #         jsonify({"msg": "Serial number hoặc Serial chỉ thị đã tồn tại!"}),
        #         400,
        #     )
        
        current_user_identity = get_jwt_identity()        
        try:
            decoded_id = decode(current_user_identity["id"])
        except Exception as e:
            return jsonify({"msg": "Invalid ID format!"}), 404
        history_entry = {
            "content": "Tạo mới đồng hồ.",
            "updated_by": f"{current_user_identity['fullname']} - {current_user_identity['email']} - {current_user_identity['role']}",
            "updated_at":  datetime.utcnow().isoformat(),
        }
        new_dongho = DongHo(
            ten_phuong_tien_do=data.get("ten_phuong_tien_do"),
            is_hieu_chuan=data.get("is_hieu_chuan"),
            index=data.get("index"),
            group_id=data.get("group_id"),

            transitor=data.get("transitor"),
            sensor=data.get("sensor"),
            serial=data.get("serial"),

            co_so_san_xuat=data.get("co_so_san_xuat"),
            nam_san_xuat=data.get("nam_san_xuat"),

            so_giay_chung_nhan=data.get("so_giay_chung_nhan"),
            so_tem=data.get("so_tem"),
            
            dn=data.get("dn"),
            d=data.get("d"),
            ccx=data.get("ccx"),
            q3=data.get("q3"),
            r=data.get("r"),
            qn=data.get("qn"),
            k_factor=data.get("k_factor"),
            so_qd_pdm=data.get("so_qd_pdm"),
            
            co_so_su_dung=data.get("co_so_su_dung"),
            phuong_phap_thuc_hien=data.get("phuong_phap_thuc_hien"),
            chuan_thiet_bi_su_dung=data.get("chuan_thiet_bi_su_dung"),
            nguoi_thuc_hien=data.get("nguoi_thuc_hien"),
            ngay_thuc_hien=data.get("ngay_thuc_hien"),

            dia_diem_thuc_hien=data.get("dia_diem_thuc_hien"),

            ket_qua_check_vo_ngoai=data.get("ket_qua_check_vo_ngoai"),
            ket_qua_check_do_kin=data.get("ket_qua_check_do_kin"),
            ket_qua_check_do_on_dinh_chi_so=data.get("ket_qua_check_do_on_dinh_chi_so"),

            ten_khach_hang=data.get("ten_khach_hang"),
            noi_su_dung=data.get("noi_su_dung"),
            # vi_tri=data.get("vi_tri"),
            # nhiet_do=data.get("nhiet_do"),
            # do_am=data.get("do_am"),

            du_lieu_kiem_dinh=data.get("du_lieu_kiem_dinh"),
            nguoi_soat_lai=data.get("nguoi_soat_lai"),

            hieu_luc_bien_ban=hieu_luc_bien_ban,
            last_updated = json.dumps(history_entry),
            created_by=decoded_id,
        )

        db.session.add(new_dongho)
        db.session.commit()

        return jsonify(new_dongho.to_dict()), 201
    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

# Update cả kiểm định + hiệu chuẩn
@dongho_bp.route("/<string:id>", methods=["PUT"])
@jwt_required()
def update_dongho(id):
    try:
        data = request.get_json()
        du_lieu_kiem_dinh = data.get("du_lieu_kiem_dinh")
        if isinstance(du_lieu_kiem_dinh, dict):
            du_lieu_kiem_dinh = json.dumps(du_lieu_kiem_dinh)

        try:
            decoded_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Invalid ID format!"}), 404

        dongho = DongHo.query.get_or_404(decoded_id)
        middleFileName = (
            ("_" + dongho.so_giay_chung_nhan if dongho.so_giay_chung_nhan else "")
            + ("_DN" + dongho.dn if dongho.dn else "")
            + (
                "_" + dongho.ngay_thuc_hien.strftime("%d-%m-%Y")
                if dongho.ngay_thuc_hien
                else ""
            )
            + ".xlsx"
        )

        bb_file_path = f"excels/export/BB/KĐ_BB{middleFileName}"
        gcn_file_path = f"excels/export/BB/KĐ_GCN{middleFileName}"

        hieu_luc_bien_ban = None
        if data.get("so_giay_chung_nhan") and data.get("so_tem"):
            ngay_thuc_hien = data.get("ngay_thuc_hien")
            if ngay_thuc_hien:
                try:
                    # Use the correct format string for parsing
                    ngay_thuc_hien_date = datetime.strptime(
                        ngay_thuc_hien, "%a, %d %b %Y %H:%M:%S %Z"
                    )
                except ValueError as e:
                    return jsonify({"msg": f"Invalid date format: {str(e)}"}), 400

                if data.get("is_hieu_chuan"):
                    print("sua")
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        1, ngay_thuc_hien_date
                    )
                    print(hieu_luc_bien_ban)
                elif data.get("q3"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        3, ngay_thuc_hien_date
                    )
                elif data.get("qn"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        5, ngay_thuc_hien_date
                    )

                if hieu_luc_bien_ban:
                    hieu_luc_bien_ban = hieu_luc_bien_ban.date()

        # serial = data.get("serial")

        # existing_dongho = DongHo.query.filter(
        #     DongHo.id != decoded_id,
        #     and_(
        #         DongHo.serial == serial,
        #         DongHo.serial != None,
        #         DongHo.serial != "",
        #     )
        # ).first()

        # if existing_dongho:
        #     return (
        #         jsonify({"msg": "Serial number hoặc Serial chỉ thị đã tồn tại!"}),
        #         400,
        #     )
        
        field_titles = {
            "ten_phuong_tien_do": "Tên phương tiện đo",

            "sensor": "Kiểu sensor",
            "transitor": "Kiểu chỉ thị",
            "serial": "Số",
            
            "co_so_san_xuat": "Cơ sở sản xuất",
            "nam_san_xuat": "Năm sản xuất",

            "dn": "Đường kính danh định (DN)",
            "d": "Độ chia nhỏ nhất (d)",
            "ccx": "Cấp chính xác",
            "q3": "Q3",
            "r": "Tỷ số Q3/Q1 (R)",
            "qn": "Qn",
            "k_factor": "Hệ số K",
            "so_qd_pdm": "Ký hiệu PDM/Số quyết định PDM",

            "so_giay_chung_nhan": "Số giấy chứng nhận",
            "so_tem": "Số Tem",

            "co_so_su_dung": "Đơn vị phê duyệt mẫu",
            "phuong_phap_thuc_hien": "Phương pháp thực hiện",
            "chuan_thiet_bi_su_dung": "Chuẩn thiết bị sử dụng",
            "nguoi_thuc_hien": "Người kiểm định",
            "ngay_thuc_hien": "Ngày thực hiện",

            "dia_diem_thuc_hien": "Địa điểm thực hiện",

            "noi_su_dung": "Nơi sử dụng",
            "ten_khach_hang": "Tên khách hàng",
            # "vi_tri": "Địa chỉ nơi sử dụng",
            # "nhiet_do": "Nhiệt độ",
            # "do_am": "Độ ẩm",

            "ket_qua_check_vo_ngoai": "Kết quả kiểm tra vỏ ngoài",
            "ket_qua_check_do_kin": "Kết quả kiểm tra độ ổn định chỉ số",
            "ket_qua_check_do_on_dinh_chi_so": "Kết quả kiểm tra độ kín",

            "du_lieu_kiem_dinh": "Dữ liệu kiểm định",
            "nguoi_soat_lai": "Người soát lại",

            "hieu_luc_bien_ban": "Hiệu lực biên bản",
        }

        # Update fields
        dongho.ten_phuong_tien_do = data.get("ten_phuong_tien_do")

        dongho.transitor = data.get("transitor")
        dongho.sensor = data.get("sensor")
        dongho.serial = data.get("serial")

        dongho.co_so_san_xuat = data.get("co_so_san_xuat")
        dongho.nam_san_xuat = data.get("nam_san_xuat")
        
        dongho.dn = data.get("dn")
        dongho.d = data.get("d")
        dongho.ccx = data.get("ccx")
        dongho.q3 = data.get("q3")
        dongho.r = data.get("r")
        dongho.qn = data.get("qn")
        dongho.k_factor = data.get("k_factor")
        dongho.so_qd_pdm = data.get("so_qd_pdm")

        dongho.so_giay_chung_nhan = data.get("so_giay_chung_nhan")
        dongho.so_tem = data.get("so_tem")

        dongho.co_so_su_dung = data.get("co_so_su_dung")
        dongho.phuong_phap_thuc_hien = data.get("phuong_phap_thuc_hien")
        dongho.chuan_thiet_bi_su_dung = data.get("chuan_thiet_bi_su_dung")
        dongho.nguoi_thuc_hien = data.get("nguoi_thuc_hien")
        dongho.ngay_thuc_hien = data.get("ngay_thuc_hien")

        dongho.dia_diem_thuc_hien = data.get("dia_diem_thuc_hien")

        dongho.ten_khach_hang = data.get("ten_khach_hang")
        dongho.noi_su_dung = data.get("noi_su_dung")
        # dongho.vi_tri = data.get("vi_tri")
        # dongho.nhiet_do = data.get("nhiet_do")
        # dongho.do_am = data.get("do_am")
        
        dongho.ket_qua_check_vo_ngoai = data.get("ket_qua_check_vo_ngoai")
        dongho.ket_qua_check_do_kin = data.get("ket_qua_check_do_kin")
        dongho.ket_qua_check_do_on_dinh_chi_so = data.get("ket_qua_check_do_on_dinh_chi_so")

        dongho.du_lieu_kiem_dinh = du_lieu_kiem_dinh
        dongho.nguoi_soat_lai = data.get("nguoi_soat_lai")

        dongho.hieu_luc_bien_ban = hieu_luc_bien_ban

        # Store original values and update fields
        changed_fields = []
        for key in field_titles.keys():
            original_value = getattr(dongho, key)
            if key == "hieu_luc_bien_ban":
                new_value = hieu_luc_bien_ban
            else:
                new_value = data.get(key)
            if key == "du_lieu_kiem_dinh" and isinstance(new_value, dict):
                new_value = json.dumps(new_value)
            if original_value != new_value:
                changed_fields.append(field_titles[key])
                setattr(dongho, key, new_value)

        current_user_identity = get_jwt_identity()

        content = "Thay đổi giá trị: " + ", ".join(changed_fields)

        history_entry = {
            "content": content,
            "updated_by": f"{current_user_identity['fullname']} - {current_user_identity['email']} - {current_user_identity['role']}",
            "updated_at": datetime.utcnow().isoformat(),
        }

        dongho.last_updated = json.dumps(history_entry)

        db.session.commit()
        
        if os.path.exists(bb_file_path):
            os.remove(bb_file_path)
        if os.path.exists(gcn_file_path):
            os.remove(gcn_file_path)

        return jsonify(dongho.to_dict()), 200
    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/dongho-info/<string:info>", methods=["GET"])
@jwt_required()
def get_dongho_by_info(info):
    try:
        if not info:
            return jsonify({"msg": "Thông tin là bắt buộc!"}), 400

        # Check if a DongHo exists with either so_tem, so_giay_chung_nhan
        existing_dongho = DongHo.query.filter(
            DongHo.is_hieu_chuan == False,
            or_(
                DongHo.so_tem == info,
                DongHo.so_giay_chung_nhan == info,
            )
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

@dongho_bp.route("/<string:id>", methods=["DELETE"])
@jwt_required()
def delete_dongho():
    try:
        data = request.get_json()
        try:
            id = decode(data.get("id"))
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404
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
        try:
            decoded_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404
        dongho = DongHo.query.filter(
            DongHo.id == decoded_id,
            DongHo.is_hieu_chuan == False
        ).first_or_404()
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
        return jsonify({"msg": "Id không hợp lệ!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/group_id/<string:group_id>", methods=["GET"])
@jwt_required()
def get_dongho_by_group_id(group_id):
    try:
        current_user_identity = get_jwt_identity()
        user = User.query.filter_by(
            username=current_user_identity["username"]
        ).first_or_404()
        donghos = DongHo.query.filter(
            DongHo.group_id==group_id,
            DongHo.is_hieu_chuan == False    
        ).all()

        result = []
        for dongho in donghos:
            if dongho:
                dongho_dict = None if not dongho else dongho.to_dict()
                if "du_lieu_kiem_dinh" in dongho_dict:
                    try:
                        dongho_dict["du_lieu_kiem_dinh"] = json.loads(
                            dongho_dict["du_lieu_kiem_dinh"]
                        )
                    except json.JSONDecodeError as e:
                        return (
                            jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}),
                            500,
                        )

                result.append(dongho_dict)

        return jsonify(result), 200

    except NotFound:
        return jsonify({"msg": "DongHo not found!"}), 404
    except Exception as e:
        print(e)
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

# Lấy ra toàn bộ phân quyền của dongho
@dongho_bp.route("/user-permissions/<string:id>", methods=["GET"])
@jwt_required()
def get_user_permissions(id):
    try:
        #TODO: 


        result = []
        return jsonify(result), 200
    except NotFound:
        return jsonify({"msg": "Id không hợp lệ!"}), 404
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

# Kiểm tra phân quyền của người dùng với đồng hồ
@dongho_bp.route("/user-info/<string:user_info>/id/<string:id>", methods=["GET"])
@jwt_required()
def check_user_info_and_dh_id_for_dongho_permissions(id, user_info):
    try:
        return (
            jsonify(
                {
                    "msg": "Người dùng hợp lệ để phân quyền",
                }
            ),
            200,
        )
    except Exception as e:
        print(e)
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

# Kiểm tra phân quyền của người dùng với nhóm đồng hồ
@dongho_bp.route("/user-info/<string:user_info>/group-id/<string:group_id>", methods=["GET"])
@jwt_required()
def check_user_info_and_group_id_permission_conflicts(group_id, user_info):

    return jsonify({"message": "Hợp lệ để phân quyền."}), 200

# Thêm phân quyền
@dongho_bp.route("/permission", methods=["POST"])
@jwt_required()
def upsert_dongho_permission():
    try:
        
        #TODO:
        return jsonify({"msg": "Quyền đã được tạo thành công!"}), 201

    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/permission/group", methods=["POST"])
@jwt_required()
def insert_group_dongho_permission():
    try:
        #TODO: 

        return jsonify({"msg": "Quyền đã được tạo thành công!"}), 201
    
    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/permission/<string:id>", methods=["DELETE"])
@jwt_required()
def delete_dongho_permission(id):
    try:
        # TODO:
        return jsonify({"msg": "Xóa thành công!"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

#-- Hiệu chuẩn
@dongho_bp.route("/hieu-chuan/group", methods=["GET"])
@jwt_required()
def get_hieu_chuan_nhom_dongho():
    try:
        query = DongHo.query.filter(
            DongHo.group_id.isnot(None),    
            DongHo.is_hieu_chuan == True    
        )

        nguoi_thuc_hien = request.args.get("nguoi_thuc_hien")
        if nguoi_thuc_hien:
            query = query.filter(DongHo.nguoi_thuc_hien.ilike(f"%{nguoi_thuc_hien}%"))

        # Chuyển đổi ngày tháng từ chuỗi sang datetime
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[
                    0
                ]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_from = datetime.strptime(
                    ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"
                        }
                    ),
                    400,
                )

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                # Loại bỏ phần không cần thiết
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[
                    0
                ]  # Chỉ lấy phần trước "(Indochina Time)"
                ngay_kiem_dinh_to = datetime.strptime(
                    ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"
                        }
                    ),
                    400,
                )
        grouped_query = query.with_entities(
            DongHo.group_id,
            db.func.count(DongHo.id).label("so_luong"),
            db.func.max(DongHo.co_so_san_xuat).label("co_so_san_xuat"),
            db.func.max(DongHo.co_so_su_dung).label("co_so_su_dung"),
            db.func.max(DongHo.nguoi_thuc_hien).label("nguoi_thuc_hien"),
            db.func.max(DongHo.ngay_thuc_hien).label("ngay_thuc_hien"),
        ).group_by(DongHo.group_id)

        total_records = grouped_query.count()

        # Thực hiện nhóm và đếm trực tiếp trong truy vấn
        limit = int(request.args.get("limit", 10))
        page = int(request.args.get("page", 1))

        result = (
            grouped_query.offset(limit * (page-1)).limit(limit).all()
        )

        result_list = [
            {
                "group_id": row.group_id,
                "so_luong": row.so_luong,
                "co_so_san_xuat": row.co_so_san_xuat,
                "co_so_su_dung": row.co_so_su_dung,
                "nguoi_thuc_hien": row.nguoi_thuc_hien,
                "ngay_thuc_hien": row.ngay_thuc_hien,
                "is_paid": True,
            }
            for row in result
        ]

        return jsonify({"total_page": math.ceil(total_records / limit),"total_records": total_records, "groups": result_list}), 200
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/hieu-chuan", methods=["GET"])
@jwt_required()
def get_hieu_chuan_donghos():
    try:
        query = DongHo.query.filter(
            DongHo.is_hieu_chuan == True  
        )

        # Apply filters based on request parameters
        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            query = query.filter(
                DongHo.so_giay_chung_nhan.ilike(f"%{so_giay_chung_nhan}%"),    
            )

        serial = request.args.get("serial")
        if serial:
            query = query.filter(DongHo.serial.ilike(f"%{serial}%"))

        nguoi_thuc_hien = request.args.get("nguoi_thuc_hien")
        if nguoi_thuc_hien:
            query = query.filter(DongHo.nguoi_thuc_hien.ilike(f"%{nguoi_thuc_hien}%"))

        # Date range filters
        ngay_kiem_dinh_from = request.args.get("ngay_kiem_dinh_from")
        if ngay_kiem_dinh_from:
            try:
                ngay_kiem_dinh_from = ngay_kiem_dinh_from.split(" (")[0]
                ngay_kiem_dinh_from = datetime.strptime(
                    ngay_kiem_dinh_from, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                query = query.filter(DongHo.ngay_thuc_hien >= ngay_kiem_dinh_from)
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_from': {str(e)}"
                        }
                    ),
                    400,
                )

        ngay_kiem_dinh_to = request.args.get("ngay_kiem_dinh_to")
        if ngay_kiem_dinh_to:
            try:
                ngay_kiem_dinh_to = ngay_kiem_dinh_to.split(" (")[0]
                ngay_kiem_dinh_to = datetime.strptime(
                    ngay_kiem_dinh_to, "%a %b %d %Y %H:%M:%S GMT%z"
                )
                query = query.filter(DongHo.ngay_thuc_hien <= ngay_kiem_dinh_to)
            except ValueError as e:
                return (
                    jsonify(
                        {
                            "msg": f"Invalid date format for 'ngay_kiem_dinh_to': {str(e)}"
                        }
                    ),
                    400,
                )

        # Get total count of records matching the filters
        total_count = query.count()

        # Keyset pagination
        limit = int(request.args.get("limit", 10))  
        last_seen_encoded = request.args.get("last_seen", "")
        last_seen = 0
        if last_seen_encoded:
            try:
                last_seen = int(decode(last_seen_encoded))
            except Exception as e:
                print(f"Decoding error: {e}")
        next_from_encoded = request.args.get("next_from", "")
        next_from_id = 0
        if next_from_encoded:
            try:
                next_from_id = int(decode(next_from_encoded))
            except Exception as e:
                print(f"Decoding error: {e}")
                
        prev_from_encoded = request.args.get("prev_from", "")
        prev_from_id = 0
        if prev_from_encoded:
            try:
                prev_from_id = int(decode(prev_from_encoded))
            except Exception as e:
                print(f"Decoding error: {e}")
        
        if last_seen:
            query = query.filter(DongHo.id >= last_seen).order_by(DongHo.id.asc()).limit(limit)
        else:
            if prev_from_id != 0 and next_from_id != 0:
                query = query.filter(DongHo.id > 0).order_by(DongHo.id.asc()).limit(limit)
            elif prev_from_id != 0:
                query = query.filter(DongHo.id < prev_from_id).order_by(DongHo.id.desc()).limit(limit)
            else:
                query = query.filter(DongHo.id > next_from_id).order_by(DongHo.id.asc()).limit(limit)

        donghos = query.all()

        if prev_from_id:
            donghos = list(reversed(donghos))

        result = []
        for dongho in donghos:
            if dongho:
                dongho_dict = None if not dongho else dongho.to_dict()
                if "du_lieu_kiem_dinh" in dongho_dict:
                    try:
                        dongho_dict["du_lieu_kiem_dinh"] = json.loads(
                            dongho_dict["du_lieu_kiem_dinh"]
                        )
                    except json.JSONDecodeError as e:
                        return (
                            jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}),
                            500,
                        )

                result.append(dongho_dict)

        return jsonify({"total_page": math.ceil(total_count / limit),"total_records": total_count, "donghos": result}), 200
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
  
@dongho_bp.route("/hieu-chuan/id/<string:id>", methods=["GET"])
@jwt_required()
def get_hieu_chuan_dongho_by_id(id):
    try:
        try:
            decoded_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404
        dongho = DongHo.query.filter(
            DongHo.id == decoded_id,
            DongHo.is_hieu_chuan == True
        ).first_or_404()
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
        return jsonify({"msg": "Id không hợp lệ!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@dongho_bp.route("/hieu-chuan/group_id/<string:group_id>", methods=["GET"])
@jwt_required()
def get_hieu_chuan_dongho_by_group_id(group_id):
    try:
        donghos = DongHo.query.filter(
            DongHo.group_id==group_id,
            DongHo.is_hieu_chuan == True    
        ).all()

        result = []

        for dongho in donghos:
            result.append(dongho.to_dict())

        return jsonify(result), 200

    except NotFound:
        return jsonify({"msg": "Không tìm thấy đồng hồ!"}), 404
    except Exception as e:
        print(e)
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
#-- Enđ hiệu chuẩn