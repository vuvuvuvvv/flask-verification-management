from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.models import PhongBan
from app import db
from app.utils.url_encrypt import decode, encode
import math

phongban_bp = Blueprint("phongban", __name__)

# Lấy danh sách tất cả phòng ban
@phongban_bp.route("/", methods=["GET"])
@jwt_required()
def get_all_phongban():
    try:
        # Lấy các tham số query string
        ten_phong = request.args.get("ten_phong")
        truong_phong = request.args.get("truong_phong")
        ngay_tao_from = request.args.get("ngay_tao_from")
        ngay_tao_to = request.args.get("ngay_tao_to")

        query = PhongBan.query

        # Lọc theo tên phòng (không phân biệt hoa thường)
        if ten_phong:
            query = query.filter(PhongBan.ten_phong.ilike(f"%{ten_phong}%"))

        # Lọc theo username trưởng phòng
        if truong_phong:
            query = query.filter(PhongBan.truong_phong_username == truong_phong)

        # Lọc theo khoảng ngày tạo
        if ngay_tao_from:
            try:
                from_date = datetime.fromisoformat(ngay_tao_from)
                query = query.filter(PhongBan.ngay_tao >= from_date)
            except ValueError:
                return jsonify({"msg": "Định dạng ngày tạo 'from' không hợp lệ"}), 400

        if ngay_tao_to:
            try:
                to_date = datetime.fromisoformat(ngay_tao_to)
                query = query.filter(PhongBan.ngay_tao <= to_date)
            except ValueError:
                return jsonify({"msg": "Định dạng ngày tạo 'to' không hợp lệ"}), 400

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
        
        # if last_seen:
        #     query = query.filter(PhongBan.id >= last_seen).order_by(PhongBan.id.asc()).limit(limit)
        # else:
        #     if prev_from_id != 0 and next_from_id != 0:
        #         query = query.filter(PhongBan.id > 0).order_by(PhongBan.id.asc()).limit(limit)
        #     elif prev_from_id != 0:
        #         query = query.filter(PhongBan.id < prev_from_id).order_by(PhongBan.id.desc()).limit(limit)
        #     else:
        #         query = query.filter(PhongBan.id > next_from_id).order_by(PhongBan.id.asc()).limit(limit)

        if prev_from_id:
            # Đi lùi: ID nhỏ hơn prev_from_id
            query = query.filter(PhongBan.id < prev_from_id).order_by(PhongBan.id.desc()).limit(limit)
        elif next_from_id:
            # Đi tới: ID lớn hơn next_from_id
            query = query.filter(PhongBan.id > next_from_id).order_by(PhongBan.id.asc()).limit(limit)
        else:
            # Trang đầu
            query = query.order_by(PhongBan.id.asc()).limit(limit)

        phongbans = query.all()

        if prev_from_id:
            phongbans = list(reversed(phongbans))

        return jsonify({
            "total_page":( math.ceil(total_count / limit) if limit else 1), 
            "total_records": total_count, 
            "data": [pb.to_dict() for pb in phongbans]
        }), 200

    except SQLAlchemyError as e:
        return jsonify({"msg": "Lỗi truy vấn cơ sở dữ liệu", "error": str(e)}), 500

# Lấy phòng ban theo ID
@phongban_bp.route("/<int:phongban_id>", methods=["GET"])
@jwt_required()
def get_phongban_by_id(phongban_id):
    try:
        phongban = PhongBan.query.get(phongban_id)
        if phongban:
            return jsonify(phongban.to_dict()), 200
        else:
            return jsonify({"error": "Phòng ban không tồn tại"}), 404
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

# Lấy danh sách phòng ban theo username của trưởng phòng
@phongban_bp.route("/truongphong/<string:username>", methods=["GET"])
@jwt_required()
def get_phongban_by_truongphong(username):
    try:
        phongban = PhongBan.query.filter_by(truong_phong_username=username).first()
        if phongban:
            return jsonify(phongban.to_dict()), 200
        else:
            return jsonify({"message": "Không tìm thấy phòng ban với trưởng phòng này"}), 404
    except Exception as e:
        return jsonify({"error": str(e)}), 500


# Lấy members cuar phòng ban theo ID
@phongban_bp.route("/members/<int:phongban_id>", methods=["GET"])
@jwt_required()
def get_members_by_phongban_id(phongban_id):
    try:
        phongban = PhongBan.query.get(phongban_id)
        if phongban:
            return jsonify(u.to_dict() for u in phongban.members), 200
        else:
            return jsonify({"error": "Phòng ban không tồn tại"}), 404
    except SQLAlchemyError as e:
        return jsonify({"error": str(e)}), 500

# Lấy danh sách users gia nhập/chưa gia nhập phòng ban
@phongban_bp.route('/users/by-phongban', methods=['GET'])
@jwt_required()
def get_users_by_phongban_status():
    try:
        users_no_phongban = User.query.filter(User.phong_ban_id.is_(None)).all()
        users_with_phongban = User.query.filter(User.phong_ban_id.isnot(None)).all()

        result = {
            "chua_gia_nhap": [
                {
                    "user": u.to_dict(),
                    "is_manager": None,
                    "phong_ban_id": None,
                    "phong_ban": None
                }
                for u in users_no_phongban
            ],
            "da_gia_nhap": [
                {
                    "user": u.to_dict(),
                    "is_manager": u.phong_ban.is_manager if u.phong_ban else None,
                    "phong_ban_id": u.phong_ban_id,
                    "phong_ban": u.phong_ban.ten_phong if u.phong_ban else None
                }
                for u in users_with_phongban
            ]
        }

        return jsonify(result), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
