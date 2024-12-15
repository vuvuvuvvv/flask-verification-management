from datetime import datetime, timedelta
import os
from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from sqlalchemy import and_, or_, cast, Integer
from app.models import (
    DongHo,
    PDM,
    NhomDongHoPayment,
    DongHoPermissions,
    Role,
    User,
    Permission,
)
from app import db
from werkzeug.exceptions import NotFound
import json
from app.utils.url_encrypt import decode, encode
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
                query = query.filter(
                    DongHo.ten_khach_hang.ilike(f"%{unidecode(word)}%")
                )

        nguoi_kiem_dinh = request.args.get("nguoi_kiem_dinh")
        if nguoi_kiem_dinh:
            query = query.filter(DongHo.nguoi_kiem_dinh.ilike(f"%{nguoi_kiem_dinh}%"))

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

        # Thực hiện nhóm và đếm trực tiếp trong truy vấn
        result = (
            query.with_entities(
                DongHo.group_id,
                db.func.count(DongHo.id).label("so_luong"),
                db.func.max(DongHo.ten_dong_ho).label("ten_dong_ho"),
                db.func.max(DongHo.co_so_san_xuat).label("co_so_san_xuat"),
                db.func.max(DongHo.ten_khach_hang).label("ten_khach_hang"),
                db.func.max(DongHo.co_so_su_dung).label("co_so_su_dung"),
                db.func.max(DongHo.nguoi_kiem_dinh).label("nguoi_kiem_dinh"),
                db.func.max(DongHo.ngay_thuc_hien).label("ngay_thuc_hien"),
            )
            .group_by(DongHo.group_id)
            .all()
        )

        NDH_payment = {
            payment.group_id: payment.is_paid
            for payment in NhomDongHoPayment.query.all()
        }

        result_list = [
            {
                "group_id": row.group_id,
                "so_luong": row.so_luong,
                "ten_dong_ho": row.ten_dong_ho,
                "co_so_san_xuat": row.co_so_san_xuat,
                "ten_khach_hang": row.ten_khach_hang,
                "co_so_su_dung": row.co_so_su_dung,
                "nguoi_kiem_dinh": row.nguoi_kiem_dinh,
                "ngay_thuc_hien": row.ngay_thuc_hien,
                "is_paid": NDH_payment.get(row.group_id, False),
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

        seri_sensor = request.args.get("seri_sensor")
        if seri_sensor:
            query = query.filter(DongHo.seri_sensor.ilike(f"%{seri_sensor}%"))

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

        donghos = query.all()

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
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/get-all-names-exist", methods=["GET"])
# @jwt_required()
def get_all_dongho_names_exist():
    try:
        ten_dong_ho_distinct = (
            PDM.query.with_entities(PDM.ten_dong_ho)
            .distinct()
            .order_by(PDM.ten_dong_ho)
            .all()
        )
        result = [item[0] for item in ten_dong_ho_distinct]
        return jsonify(result), 200
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


def _get_last_day_of_month_in_future(years: int, date: datetime) -> datetime:
    return datetime(date.year + years, date.month + 1, 1) - timedelta(days=1)


@dongho_bp.route("", methods=["POST"])
@jwt_required()
def create_dongho():
    try:
        data = request.get_json()
        data.pop("id", None)

        hieu_luc_bien_ban = None
        if data.get("so_giay_chung_nhan") and data.get("so_tem"):
            ngay_thuc_hien = data.get("ngay_thuc_hien")
            if ngay_thuc_hien:
                try:
                    ngay_thuc_hien_date = datetime.strptime(
                        ngay_thuc_hien, "%Y-%m-%dT%H:%M:%S.%fZ"
                    )
                except ValueError:
                    ngay_thuc_hien_date = datetime.strptime(ngay_thuc_hien, "%Y-%m-%d")

                if data.get("q3"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        3, ngay_thuc_hien_date
                    )
                elif data.get("qn"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        5, ngay_thuc_hien_date
                    )

                if hieu_luc_bien_ban:
                    hieu_luc_bien_ban = hieu_luc_bien_ban.date()

        seri_sensor = data.get("seri_sensor")
        seri_chi_thi = data.get("seri_chi_thi")

        existing_dongho = DongHo.query.filter(
            or_(
                and_(
                    DongHo.seri_sensor == seri_sensor,
                    DongHo.seri_sensor != None,
                    DongHo.seri_sensor != "",
                ),
                and_(
                    DongHo.seri_chi_thi == seri_chi_thi,
                    DongHo.seri_chi_thi != None,
                    DongHo.seri_chi_thi != "",
                ),
            )
        ).first()

        if existing_dongho:
            return (
                jsonify({"msg": "Serial number hoặc Serial chỉ thị đã tồn tại!"}),
                400,
            )
        new_dongho = DongHo(
            group_id=data.get("group_id"),
            ten_dong_ho=data.get("ten_dong_ho"),
            phuong_tien_do=data.get("phuong_tien_do"),
            seri_chi_thi=data.get("seri_chi_thi"),
            seri_sensor=data.get("seri_sensor"),
            kieu_chi_thi=data.get("kieu_chi_thi"),
            kieu_sensor=data.get("kieu_sensor"),
            kieu_thiet_bi=data.get("kieu_thiet_bi"),
            co_so_san_xuat=data.get("co_so_san_xuat"),
            so_tem=data.get("so_tem"),
            nam_san_xuat=data.get("nam_san_xuat"),
            dn=data.get("dn"),
            d=data.get("d"),
            ccx=data.get("ccx"),
            q3=data.get("q3"),
            r=data.get("r"),
            qn=data.get("qn"),
            k_factor=data.get("k_factor"),
            so_qd_pdm=data.get("so_qd_pdm"),
            ten_khach_hang=data.get("ten_khach_hang"),
            co_so_su_dung=data.get("co_so_su_dung"),
            phuong_phap_thuc_hien=data.get("phuong_phap_thuc_hien"),
            chuan_thiet_bi_su_dung=data.get("chuan_thiet_bi_su_dung"),
            nguoi_kiem_dinh=data.get("nguoi_kiem_dinh"),
            nguoi_soat_lai=data.get("nguoi_soat_lai"),
            ngay_thuc_hien=data.get("ngay_thuc_hien"),
            noi_su_dung=data.get("noi_su_dung"),
            noi_thuc_hien=data.get("noi_thuc_hien"),
            vi_tri=data.get("vi_tri"),
            nhiet_do=data.get("nhiet_do"),
            do_am=data.get("do_am"),
            du_lieu_kiem_dinh=data.get("du_lieu_kiem_dinh"),
            hieu_luc_bien_ban=hieu_luc_bien_ban,
            so_giay_chung_nhan=data.get("so_giay_chung_nhan"),
        )

        current_user_identity = get_jwt_identity()

        history_entry = {
            "content": "Tạo mới đồng hồ.",
            "updated_by": f"{current_user_identity['fullname']} - {current_user_identity['email']} - {current_user_identity['role']}",
            "updated_at": datetime.utcnow().isoformat(),
        }

        new_dongho.last_updated = json.dumps(history_entry)

        db.session.add(new_dongho)
        db.session.commit()
        return jsonify(new_dongho.to_dict()), 201
    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/<string:id>", methods=["PUT"])
@jwt_required()
def update_dongho(id):
    try:
        data = request.get_json()

        try:
            decoded_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Invalid ID format!"}), 404

        dongho = DongHo.query.get_or_404(decoded_id)
        middleFileName = (
            ("_" + dongho.so_giay_chung_nhan if dongho.so_giay_chung_nhan else "")
            + ("_" + dongho.ten_khach_hang if dongho.ten_khach_hang else "")
            + ("_" + dongho.ten_dong_ho if dongho.ten_dong_ho else "")
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

                if data.get("q3"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        3, ngay_thuc_hien_date
                    )
                elif data.get("qn"):
                    hieu_luc_bien_ban = _get_last_day_of_month_in_future(
                        5, ngay_thuc_hien_date
                    )

                if hieu_luc_bien_ban:
                    hieu_luc_bien_ban = hieu_luc_bien_ban.date()

        seri_sensor = data.get("seri_sensor")
        seri_chi_thi = data.get("seri_chi_thi")

        existing_dongho = DongHo.query.filter(
            DongHo.id != decoded_id,
            or_(
                and_(
                    DongHo.seri_sensor == seri_sensor,
                    DongHo.seri_sensor != None,
                    DongHo.seri_sensor != "",
                ),
                and_(
                    DongHo.seri_chi_thi == seri_chi_thi,
                    DongHo.seri_chi_thi != None,
                    DongHo.seri_chi_thi != "",
                ),
            ),
        ).first()

        if existing_dongho:
            return (
                jsonify({"msg": "Serial number hoặc Serial chỉ thị đã tồn tại!"}),
                400,
            )
        field_titles = {
            "ten_dong_ho": "Tên đồng hồ",
            "phuong_tien_do": "Tên phương tiện đo",
            "kieu_thiet_bi": "Kiểu thiết bị",
            "seri_chi_thi": "Serial chỉ thị",
            "seri_sensor": "Serial sensor",
            "kieu_chi_thi": "Kiểu chỉ thị",
            "kieu_sensor": "Kiểu sensor",
            "so_tem": "Số Tem",
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
            "ten_khach_hang": "Tên khách hàng",
            "co_so_su_dung": "Đơn vị phê duyệt mẫu",
            "phuong_phap_thuc_hien": "Phương pháp thực hiện",
            "noi_su_dung": "Nơi sử dụng",
            "vi_tri": "Địa chỉ nơi sử dụng",
            "nhiet_do": "Nhiệt độ",
            "do_am": "Độ ẩm",
            "du_lieu_kiem_dinh": "Dữ liệu kiểm định",
            "hieu_luc_bien_ban": "Hiệu lực biên bản",
            "so_giay_chung_nhan": "Số giấy chứng nhận",
            "noi_thuc_hien": "Nơi thực hiện",
            "ngay_thuc_hien": "Ngày thực hiện",
            "nguoi_kiem_dinh": "Người kiểm định",
            "nguoi_soat_lai": "Người soát lại",
            "chuan_thiet_bi_su_dung": "Chuẩn thiết bị sử dụng",
        }

        # Update fields
        dongho.ten_dong_ho = data.get("ten_dong_ho")
        dongho.phuong_tien_do = data.get("phuong_tien_do")
        dongho.seri_chi_thi = data.get("seri_chi_thi")
        dongho.seri_sensor = data.get("seri_sensor")
        dongho.kieu_chi_thi = data.get("kieu_chi_thi")
        dongho.kieu_sensor = data.get("kieu_sensor")
        dongho.kieu_thiet_bi = data.get("kieu_thiet_bi")
        dongho.co_so_san_xuat = data.get("co_so_san_xuat")
        dongho.so_tem = data.get("so_tem")
        dongho.nam_san_xuat = data.get("nam_san_xuat")
        dongho.dn = data.get("dn")
        dongho.d = data.get("d")
        dongho.ccx = data.get("ccx")
        dongho.q3 = data.get("q3")
        dongho.r = data.get("r")
        dongho.qn = data.get("qn")
        dongho.k_factor = data.get("k_factor")
        dongho.so_qd_pdm = data.get("so_qd_pdm")
        dongho.ten_khach_hang = data.get("ten_khach_hang")
        dongho.co_so_su_dung = data.get("co_so_su_dung")
        dongho.phuong_phap_thuc_hien = data.get("phuong_phap_thuc_hien")
        dongho.chuan_thiet_bi_su_dung = data.get("chuan_thiet_bi_su_dung")
        dongho.nguoi_kiem_dinh = data.get("nguoi_kiem_dinh")
        dongho.nguoi_soat_lai = data.get("nguoi_soat_lai")
        dongho.ngay_thuc_hien = data.get("ngay_thuc_hien")
        dongho.noi_su_dung = data.get("noi_su_dung")
        dongho.noi_thuc_hien = data.get("noi_thuc_hien")
        dongho.vi_tri = data.get("vi_tri")
        dongho.nhiet_do = data.get("nhiet_do")
        dongho.do_am = data.get("do_am")
        dongho.du_lieu_kiem_dinh = data.get("du_lieu_kiem_dinh")
        dongho.hieu_luc_bien_ban = data.get("hieu_luc_bien_ban")
        dongho.so_giay_chung_nhan = data.get("so_giay_chung_nhan")

        # Store original values and update fields
        changed_fields = []
        for key in field_titles.keys():
            original_value = getattr(dongho, key)
            new_value = data.get(key)
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


@dongho_bp.route("/dong-ho-info/<string:info>", methods=["GET"])
@jwt_required()
def get_dongho_by_info(info):
    try:
        if not info:
            return jsonify({"msg": "Thông tin là bắt buộc!"}), 400

        # Check if a DongHo exists with either seri_sensor or seri_chi_thi
        existing_dongho = DongHo.query.filter(
            or_(
                DongHo.seri_sensor == info,
                DongHo.seri_chi_thi == info,
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
        return jsonify({"msg": "Id không hợp lệ!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/group_id/<string:group_id>", methods=["GET"])
@jwt_required()
def get_dongho_by_group_id(group_id):
    try:
        try:
            decoded_group_id = group_id
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404
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


@dongho_bp.route("/payment-status", methods=["PUT"])
@jwt_required()
def update_payment_status():
    try:
        data = request.get_json()
        group_id = data.get("group_id")
        username = data.get("username") if data.get("username") else ""
        new_payment_status = data.get("new_payment_status")

        if not group_id or new_payment_status is None:
            return (
                jsonify({"msg": "Group ID và trạng thái thanh toán mới là bắt buộc!"}),
                400,
            )

        try:
            decoded_group_id = group_id
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404

        nhom_dongho_payment = NhomDongHoPayment.query.filter_by(
            group_id=decoded_group_id
        ).first()

        if nhom_dongho_payment:
            nhom_dongho_payment.is_paid = new_payment_status
        else:
            nhom_dongho_payment = NhomDongHoPayment(
                group_id=decoded_group_id,
                is_paid=new_payment_status,
                payment_collector=username,
            )
            db.session.add(nhom_dongho_payment)

        current_user_identity = get_jwt_identity()

        history_entry = {
            "content": (
                "Chuyển trạng thái " + "đã"
                if new_payment_status
                else "chưa" + " thanh toán."
            ),
            "updated_by": f"{current_user_identity['fullname']} - {current_user_identity['email']} - {current_user_identity['role']}",
            "updated_at": datetime.utcnow().isoformat(),
        }

        nhom_dongho_payment.last_updated = json.dumps(history_entry)

        db.session.commit()

        return jsonify({"msg": "Cập nhật trạng thái thanh toán thành công!"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/user-permissions/<string:id>", methods=["GET"])
@jwt_required()
def get_user_permissions(id):
    try:
        current_user_identity = get_jwt_identity()

        try:
            decoded_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404
        user_permissions = DongHoPermissions.query.filter(
            and_(
                DongHoPermissions.dongho_id == decoded_id,
                DongHoPermissions.manager == current_user_identity["username"],
                DongHoPermissions.username != current_user_identity["username"],
            )
        ).all()

        result = []
        for up in user_permissions:
            result.append(
                {"id": encode(up.id), "user": up.user.to_dict(), "role": up.role.name}
            )
        return jsonify(result), 200
    except NotFound:
        return jsonify({"msg": "Id không hợp lệ!"}), 404
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/user-info/<string:id>/<string:user_info>", methods=["GET"])
@jwt_required()
def check_user_info_for_dongho_permissions(id, user_info):
    try:

        if not user_info or not id:
            return jsonify({"msg": "Thông tin là bắt buộc!"}), 400

        try:
            decoded_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404

        dongho = DongHo.query.filter_by(id=decoded_id).first()
        if not dongho:
            return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

        existing_user = User.query.filter(
            or_(
                User.username == user_info,
                User.email == user_info,
            )
        ).first()
        if not existing_user:
            return jsonify({"msg": "Người dùng không tồn tại!"}), 404

        existing_permission = DongHoPermissions.query.filter(
            and_(
                DongHoPermissions.username == existing_user.username,
                DongHoPermissions.dongho_id == decoded_id,
            )
        ).first()

        if existing_permission:
            return (
                jsonify(
                    {
                        "msg": "Người dùng đã được phân quyền cho đồng hồ này!",
                    }
                ),
                409,
            )  # Conflict status code

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


@dongho_bp.route("/permissions/<string:username>", methods=["GET"])
@jwt_required()
def get_donghos_with_permission(username):
    try:
        current_user_identity = get_jwt_identity()
        print(current_user_identity["permission"])

        queryDHP = DongHoPermissions.query.filter(
            DongHoPermissions.username == username
        )

        so_giay_chung_nhan = request.args.get("so_giay_chung_nhan")
        if so_giay_chung_nhan:
            queryDHP = queryDHP.filter(
                DongHoPermissions.dongho.so_giay_chung_nhan.ilike(
                    f"%{so_giay_chung_nhan}%"
                )
            )

        seri_sensor = request.args.get("seri_sensor")
        if seri_sensor:
            queryDHP = queryDHP.join(DongHo).filter(
                DongHo.seri_sensor.ilike(f"%{seri_sensor}%")
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
                    DongHoPermissions.dongho.ngay_thuc_hien >= ngay_kiem_dinh_from
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
                    DongHoPermissions.dongho.ngay_thuc_hien <= ngay_kiem_dinh_to
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

        donghosWithPer = queryDHP.all()

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
                # dongho_dict['current_permission'] = dwp.role.permissions
                dongho_dict["current_permission"] = dwp.role.name
                result.append(dongho_dict)
        return jsonify(result), 200
    except Exception as e:
        print(e)
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/permission", methods=["POST"])
@jwt_required()
def upsert_dongho_permission():
    try:
        data = request.get_json()
        id = data.get("id")

        try:
            decoded_id = decode(id)
            dongho = DongHo.query.filter_by(id=decoded_id).first_or_404()
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404

        user_info = data.get("user_info", "")
        permission = int(data.get("permission", 0))

        user = User.query.filter(
            or_(User.username == user_info, User.email == user_info)
        ).first()

        if user:
            role = Role.query.filter_by(permissions=permission).first()
            if not role:
                role = Role.query.filter_by(default=True).first()
                if not role:
                    return jsonify({"msg": "Không tìm thấy vai trò phù hợp!"}), 404

            manager_username = data.get("manager", user.username)
            manager = User.query.filter_by(username=manager_username).first()
            if not manager:
                manager = user
            existing_dh_permission = DongHoPermissions.query.filter(
                and_(
                    DongHoPermissions.dongho_id == dongho.id,
                    DongHoPermissions.username == user.username,
                    DongHoPermissions.manager == manager.username,
                )
            ).first()
            if existing_dh_permission:
                existing_dh_permission.role_id = role.id
                db.session.add(existing_dh_permission)
            else:
                new_dh_permission = DongHoPermissions(
                    dongho_id=dongho.id,
                    username=user.username,
                    manager=manager.username,
                    role_id=role.id,
                )
                db.session.add(new_dh_permission)
            db.session.commit()
            return jsonify({"msg": "Quyền đã được tạo thành công!"}), 201
        else:
            return jsonify({"msg": "Người dùng hoặc quản lý không tồn tại!"}), 404
    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500


@dongho_bp.route("/permission/<string:id>", methods=["DELETE"])
@jwt_required()
def delete_dongho_permission(id):
    try:
        try:
            decode_id = decode(id)
        except Exception as e:
            return jsonify({"msg": "Id không hợp lệ!"}), 404
        per = DongHoPermissions.query.get_or_404(decode_id)
        db.session.delete(per)
        db.session.commit()
        return jsonify({"msg": "Xóa thành công!"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"msg": f"Đã có lỗi xảy ra! Hãy thử lại sau."}), 500
