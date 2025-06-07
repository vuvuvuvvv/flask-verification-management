from flask import Blueprint, jsonify, request
from flask_jwt_extended import (jwt_required, get_jwt_identity)
from app.models import PhongBan, User
from app import db
from app.utils.url_encrypt import decode, encode
import math

phongban_bp = Blueprint("phongban", __name__)

# Lấy danh sách tất cả phòng ban
@phongban_bp.route("", methods=["GET"], strict_slashes=False)
@phongban_bp.route("/", methods=["GET"], strict_slashes=False)
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

        return jsonify(
            {
                "status": 200,
                "data": {
                    "total_page":( math.ceil(total_count / limit) if limit else 1), 
                    "total_records": total_count, 
                    "data": [pb.to_dict() for pb in phongbans]
                }
            }
        ), 200

    except Exception as e:
        print(str(e))
        return jsonify({"status": 500,"msg": "Lỗi truy vấn cơ sở dữ liệu", "error": str(e)}), 500

# Lấy phòng ban theo ID
@phongban_bp.route("/<int:phongban_id>", methods=["GET"])
@jwt_required()
def get_phongban_by_id(phongban_id):
    try:
        phongban = PhongBan.query.get(phongban_id)
        if phongban:
            return jsonify({"status": 200, "data":phongban.to_dict()}), 200
        else:
            return jsonify({"status": 404, "error": "Phòng ban không tồn tại"}), 404
    except SQLAlchemyError as e:
        return jsonify({"status": 500, "error": str(e)}), 500

# Lấy danh sách phòng ban theo username của trưởng phòng
@phongban_bp.route("/truongphong/<string:username>", methods=["GET"])
@jwt_required()
def get_phongban_by_truongphong(username):
    try:
        phongban = PhongBan.query.filter_by(truong_phong_username=username).first()
        if phongban:
            return jsonify({"status": 200, "data":phongban.to_dict()}), 200
        else:
            return jsonify({"status": 404, "message": "Không tìm thấy phòng ban với trưởng phòng này"}), 404
    except Exception as e:
        return jsonify({"status": 500, "error": str(e)}), 500


# Lấy members cuar phòng ban theo ID
@phongban_bp.route("/members/<int:phongban_id>", methods=["GET"])
@jwt_required()
def get_members_by_phongban_id(phongban_id):
    try:
        phongban = PhongBan.query.get(phongban_id)
        if phongban:
            return jsonify({"status": 200, "data":[u.to_dict() for u in phongban.members]}), 200
        else:
            return jsonify({"status": 404, "error": "Phòng ban không tồn tại"}), 404
    except SQLAlchemyError as e:
        return jsonify({"status": 500, "error": str(e)}), 500

# Lấy danh sách users gia nhập/chưa gia nhập phòng ban
@phongban_bp.route('/users/by-phongban', methods=['GET'])
@jwt_required()
def get_users_by_phongban_status():
    try:
        users_no_phongban = User.query.filter(User.phong_ban_id.is_(None)).all()
        users_with_phongban = User.query.filter(User.phong_ban_id.isnot(None)).all()

        result = {
            "status": 200,
            "data": {            
                "chua_tham_gia": [
                    {
                        "user": u.to_dict(),
                        "is_manager": None,
                        "phong_ban_id": None,
                        "phong_ban": None
                    }
                    for u in users_no_phongban
                ],
                "da_tham_gia": [
                    {
                        "user": u.to_dict(),
                        "is_manager": u.phong_ban.is_manager(u),
                        "phong_ban_id": u.phong_ban_id,
                        "phong_ban": u.phong_ban.ten_phong if u.phong_ban else None
                    }
                    for u in users_with_phongban
                ]
            }
        }

        return jsonify(result), 200
    except Exception as e:
        print(str(e))
        return jsonify({"status": 500, "error": str(e)}), 500

# Lấy danh sách users gia nhập/chưa gia nhập phòng ban
@phongban_bp.route('/users/by-phongban/except/<int:phongban_id>', methods=['GET'])
@jwt_required()
def get_users_by_phongban_status_except_phong_ban_id(phongban_id):
    try:
        users_no_phongban = User.query.filter(User.phong_ban_id.is_(None)).all()
        users_with_phongban = User.query.filter(
            User.phong_ban_id.isnot(None),
            User.phong_ban_id != phongban_id
            ).all()

        result = {
            "data": {            
                "chua_tham_gia": [
                    {
                        "user": u.to_dict(),
                        "is_manager": None,
                        "phong_ban_id": None,
                        "phong_ban": None
                    }
                    for u in users_no_phongban
                ],
                "da_tham_gia": [
                    {
                        "user": u.to_dict(),
                        "is_manager": u.phong_ban.is_manager(u),
                        "phong_ban_id": u.phong_ban_id,
                        "phong_ban": u.phong_ban.ten_phong if u.phong_ban else None
                    }
                    for u in users_with_phongban
                ]
            }
        }

        return jsonify(result), 200
    except Exception as e:
        print(str(e))
        return jsonify({"status": 500, "error": str(e)}), 500


# upsert: update + insert phòng ban
@phongban_bp.route('', methods=['POST'])
@jwt_required()
def upsert_phong_ban():
    try:
        data = request.get_json()
        ten_phong_ban = data.get("ten_phong_ban")
        truong_phong_data = data.get("truong_phong")
        id_phong_ban = data.get("id_phong_ban")
        members_data = data.get("members", [])

        phong_ban = None
        if id_phong_ban:
            phong_ban = db.session.get(PhongBan, id_phong_ban)
            if not phong_ban:
                return jsonify({"status": 404, "msg": "Phòng ban không tồn tại"}), 404

        all_members = [truong_phong_data] + members_data

        for member in all_members:
            is_manager = member.get("is_manager")
            user_data = member.get("user")
            user_id = decode(user_data.get("id"))

            if user_id is None:
                continue

            user = db.session.get(User, user_id)
            if not user:
                continue

            if is_manager is None:
                continue

            if is_manager is False:
                if user.phong_ban_id:
                    user.phong_ban_id = None
                    db.session.add(user)

            elif is_manager is True and not id_phong_ban:
                old_phong_ban = PhongBan.query.filter_by(truong_phong_username=user.username).first()
                if old_phong_ban:
                    users_in_pb = User.query.filter_by(phong_ban_id=old_phong_ban.id).all()
                    for u in users_in_pb:
                        u.phong_ban_id = None
                        db.session.add(u)
                    db.session.delete(old_phong_ban)

        # Lấy thông tin trưởng phòng
        truong_phong_user_id = decode(truong_phong_data["user"]["id"])
        truong_phong_user = db.session.get(User, truong_phong_user_id)
        if not truong_phong_user:
            raise ValueError("Trưởng phòng không hợp lệ.")

        # Tạo hoặc cập nhật phòng ban
        if phong_ban:
            phong_ban.ten_phong = ten_phong_ban
            phong_ban.truong_phong_username = truong_phong_user.username
        else:
            phong_ban = PhongBan(ten_phong=ten_phong_ban, truong_phong_username=truong_phong_user.username)

        db.session.add(phong_ban)
        db.session.flush()  # Lấy phong_ban.id sau khi insert/update

        # 🧹 XÓA các nhân viên cũ không còn trong danh sách mới
        if id_phong_ban:
            current_members = User.query.filter(User.phong_ban_id == phong_ban.id).all()
            new_member_ids = {decode(member["user"]["id"]) for member in members_data}
            for u in current_members:
                if u.id != truong_phong_user.id and u.id not in new_member_ids:
                    u.phong_ban_id = None
                    db.session.add(u)

        # Gán lại phòng ban cho trưởng phòng và thành viên mới
        truong_phong_user.phong_ban_id = phong_ban.id
        db.session.add(truong_phong_user)

        for member in members_data:
            user_data = member.get("user")
            user_id = decode(user_data.get("id"))
            user = db.session.get(User, user_id)
            if user:
                user.phong_ban_id = phong_ban.id
                db.session.add(user)

        db.session.commit()
        return jsonify({"status": 201, "msg": "Tạo/Cập nhật phòng ban thành công"}), 201

    except Exception as e:
        db.session.rollback()
        return jsonify({"status": 500, "msg": "Lỗi hệ thống", "error": str(e)}), 500


@phongban_bp.route('/<string:id>', methods=['DELETE'])
@jwt_required()
def delete_phong_ban(id):
    try:
        if not id:
            return jsonify({"status": 400, "msg": "ID phòng ban không hợp lệ."}), 400

        phong_ban = db.session.get(PhongBan, id)

        if not phong_ban:
            return jsonify({"status": 404, "msg": "Phòng ban không tồn tại."}), 404

        current_user_identity = get_jwt_identity()        
        try:
            decoded_id = decode(current_user_identity["id"])
        except Exception as e:
            return jsonify({"msg": "Invalid ID format!"}), 404
        current_user = db.session.get(User, decoded_id)
        print(current_user.is_admin())
        if not current_user or not current_user.is_admin():
            return jsonify({
                "status": 403,
                "msg": "Bạn không có quyền giải tán phòng ban này."
            }), 403

        # Gỡ liên kết các nhân viên
        users_in_pb = User.query.filter_by(phong_ban_id=id).all()
        for user in users_in_pb:
            user.phong_ban_id = None
            db.session.add(user)

        db.session.delete(phong_ban)
        db.session.commit()

        return jsonify({
            "status": 200,
            "msg": "Đã giải tán phòng ban thành công."
        }), 200

    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({
            "status": 500,
            "msg": "Đã xảy ra lỗi. Vui lòng thử lại sau."
        }), 500


@phongban_bp.route('/nhan-vien', methods=['POST'])
@jwt_required()
def add_nhan_vien():
    try:
        data = request.get_json()
        phong_ban_id = data.get("id")
        members_data = data.get("members", [])

        if not phong_ban_id:
            return jsonify({"status": 400, "msg": "Thiếu ID phòng ban."}), 400

        phong_ban = db.session.get(PhongBan, phong_ban_id)
        if not phong_ban:
            return jsonify({"status": 404, "msg": "Phòng ban không tồn tại."}), 404

        if not members_data:
            return jsonify({"status": 400, "msg": "Danh sách nhân viên trống."}), 400

        for member in members_data:
            is_manager = member.get("is_manager")
            user_data = member.get("user")
            user_id = decode(user_data.get("id"))

            if user_id is None:
                continue

            user = db.session.get(User, user_id)
            if not user:
                continue

            # Chỉ add nếu user chưa có phòng ban hoặc thuộc phòng ban khác
            if user.phong_ban_id is None or user.phong_ban_id != phong_ban_id:
                if is_manager is True:
                    # Kiểm tra nếu user là trưởng phòng của phòng ban khác
                    old_phong_ban = PhongBan.query.filter_by(truong_phong_username=user.username).first()
                    if old_phong_ban:
                        # Gỡ các user thuộc phòng ban đó
                        users_in_old_pb = User.query.filter_by(phong_ban_id=old_phong_ban.id).all()
                        for u in users_in_old_pb:
                            u.phong_ban_id = None
                            db.session.add(u)
                        db.session.delete(old_phong_ban)

                user.phong_ban_id = phong_ban_id
                db.session.add(user)

        db.session.commit()
        return jsonify({"status": 201, "msg": "Thêm nhân viên thành công."}), 201

    except Exception as e:
        print(e)
        db.session.rollback()
        return jsonify({"status": 500, "msg": "Đã có lỗi xảy ra! Hãy thử lại sau."}), 500

@phongban_bp.route("/nhan-vien/<string:id>", methods=["DELETE"])
@jwt_required()
def remove_nhan_vien_from_phong_ban(id):
    try:
        decoded_id = decode(id)
    except Exception as e:
        traceback.print_exc()
        return jsonify({"status": 404, "msg": "Invalid ID format!"}), 404
        
    user = User.query.get(decoded_id)

    if not user:
        return jsonify({"status": 404, "msg": "Nhân viên không tồn tại."}), 404

    phong_ban = PhongBan.query.filter_by(id=user.phong_ban_id).first()
    if phong_ban and phong_ban.truong_phong_username == user.username:
        return jsonify({
            "status": 400, 
            "msg": "Không thể xóa trưởng phòng. Hãy chuyển quyền quản lý trước."
        }), 400

    try:
        user.phong_ban_id = None
        db.session.commit()
        return jsonify({
            "status": 200,
            "msg": "Đã gỡ nhân viên khỏi phòng ban thành công."
        }), 200
    except Exception as e:
        traceback.print_exc()
        db.session.rollback()
        return jsonify({
            "status": 500,
            "msg": f"Xảy ra lỗi khi cập nhật: {str(e)}"
        }), 500
