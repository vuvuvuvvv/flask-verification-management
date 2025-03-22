from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.models import PDM
from app import db
from app.utils.url_encrypt import decode, encode
import math

pdm_bp = Blueprint("pdm", __name__)


@pdm_bp.route("", methods=["GET"])
@jwt_required()
def get_pdms():
    try:
        query = PDM.query
        total_count = query.count()

        # ma_tim_dong_ho_pdm = request.args.get("ma_tim_dong_ho_pdm")
        # if ma_tim_dong_ho_pdm:
        #     query = query.filter(PDM.ma_tim_dong_ho_pdm.ilike(f"%{ma_tim_dong_ho_pdm}%"))

        ten_dong_ho = request.args.get("ten_dong_ho")
        if ten_dong_ho:
            query = query.filter(PDM.ten_dong_ho.ilike(f"%{ten_dong_ho.replace('@gach_cheo', '/')}%"))

        so_qd_pdm = request.args.get("so_qd_pdm")
        if so_qd_pdm:
            query = query.filter(PDM.so_qd_pdm.ilike(f"%{so_qd_pdm.replace('@gach_cheo', '/')}%"))

        ngay_qd_pdm_from = request.args.get("ngay_qd_pdm_from")
        if ngay_qd_pdm_from:
            query = query.filter(PDM.ngay_qd_pdm >= ngay_qd_pdm_from)

        ngay_qd_pdm_to = request.args.get("ngay_qd_pdm_to")
        if ngay_qd_pdm_to:
            query = query.filter(PDM.ngay_qd_pdm <= ngay_qd_pdm_to)

        tinh_trang = request.args.get("tinh_trang")
        if tinh_trang:
            if int(tinh_trang) == 1:
                query = query.filter(PDM.ngay_het_han >= db.func.current_date())
            else:
                query = query.filter(PDM.ngay_het_han < db.func.current_date())

        dn = request.args.get("dn")
        if dn:
            query = query.filter(PDM.dn.ilike(f"%{dn.replace('@gach_cheo', '/')}%"))

        ccx = request.args.get("ccx")
        if ccx:
            query = query.filter(PDM.ccx.ilike(f"%{ccx.replace('@gach_cheo', '/')}%"))

        sensor = request.args.get("sensor")
        if sensor:
            query = query.filter(PDM.sensor.ilike(f"%{sensor.replace('@gach_cheo', '/')}%"))

        transmitter = request.args.get("transmitter")
        if transmitter:
            query = query.filter(PDM.transmitter.ilike(f"%{transmitter.replace('@gach_cheo', '/')}%"))

        # Keyset pagination
        limit = int(request.args.get("limit", 10))  
        last_seen = request.args.get("last_seen", "")
        next_from_id = request.args.get("next_from", 0)
        prev_from_id = request.args.get("prev_from", 0)
        if last_seen:
            query = query.filter(PDM.id >= last_seen).order_by(PDM.id.asc()).limit(limit)
        else:
            if prev_from_id != 0 and next_from_id != 0:
                query = query.filter(PDM.id > 0).order_by(PDM.id.asc()).limit(limit)
            elif prev_from_id != 0:
                query = query.filter(PDM.id < prev_from_id).order_by(PDM.id.desc()).limit(limit)
            else:
                query = query.filter(PDM.id > next_from_id).order_by(PDM.id.asc()).limit(limit)
        pdms = query.all()
        
        if prev_from_id:
            pdms = list(reversed(pdms))

        result = [pdm.to_dict() for pdm in pdms]

        return jsonify({"total_page": math.ceil(total_count / limit), "total_records": total_count, "data": result}), 200

    except Exception as e:
        print(f"Error occurred: {e}")
        return jsonify({"msg": "Đã có lỗi xảy ra khi lấy dữ liệu phê duyệt mẫu.", "error": str(e)}), 500
    
@pdm_bp.route("", methods=["POST"])
@jwt_required()
def create_pdm():
    data = request.get_json()
    existing_pdm = PDM.query.filter_by(ma_tim_dong_ho_pdm=data.get("ma_tim_dong_ho_pdm")).first()
    if existing_pdm:
        return jsonify({"msg": f"Mã {data.get('ma_tim_dong_ho_pdm')} đã tồn tại!", "data": existing_pdm.to_dict()}), 400
    new_pdm = PDM(
        ma_tim_dong_ho_pdm=data.get("ma_tim_dong_ho_pdm"),
        ten_dong_ho=data.get("ten_dong_ho"),
        noi_san_xuat=data.get("noi_san_xuat"),
        dn=data.get("dn"),
        ccx=data.get("ccx"),
        sensor=data.get("sensor"),
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

@pdm_bp.route("", methods=["PUT"])
@jwt_required()
def update_pdm():
    try: 
        data = request.get_json()
        pdm_id = data.get("id") 
        existing_pdm = PDM.query.get(pdm_id) 
        print(data)
        if existing_pdm:
            existing_pdm.ma_tim_dong_ho_pdm = data.get("ma_tim_dong_ho_pdm")
            existing_pdm.ten_dong_ho = data.get("ten_dong_ho")
            existing_pdm.noi_san_xuat = data.get("noi_san_xuat")
            existing_pdm.dn = data.get("dn")
            existing_pdm.ccx = data.get("ccx")
            existing_pdm.sensor = data.get("sensor")
            existing_pdm.transmitter = data.get("transmitter")
            existing_pdm.qn = data.get("qn")
            existing_pdm.q3 = data.get("q3")
            existing_pdm.r = data.get("r")
            existing_pdm.don_vi_pdm = data.get("don_vi_pdm")
            existing_pdm.dia_chi = data.get("dia_chi")
            existing_pdm.so_qd_pdm = data.get("so_qd_pdm")
            existing_pdm.ngay_qd_pdm = data.get("ngay_qd_pdm")
            existing_pdm.ngay_het_han = data.get("ngay_het_han")
            existing_pdm.anh_pdm = data.get("anh_pdm")

            db.session.commit() 
            return jsonify(existing_pdm.to_dict()), 200 
        else:  
            new_pdm = PDM(
                ma_tim_dong_ho_pdm=data.get("ma_tim_dong_ho_pdm"),
                ten_dong_ho=data.get("ten_dong_ho"),
                noi_san_xuat=data.get("noi_san_xuat"),
                dn=data.get("dn"),
                ccx=data.get("ccx"),
                sensor=data.get("sensor"),
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

    except Exception as e: 
        db.session.rollback()  
        return jsonify({"msg": "Đã xảy ra lỗi khi cập nhật hoặc tạo mới PDM!", "error": str(e)}), 500 

@pdm_bp.route("/id/<int:id>", methods=["GET"])
@jwt_required()
def get_pdm(id):
    try:
        pdm = PDM.query.get_or_404(id)
        return jsonify(pdm.to_dict()), 200
    except Exception as e:
        print(f"Error retrieving PDM with id {id}: {e}")
        return jsonify({"msg": "Đã xảy ra lỗi khi lấy thông tin PDM!", "error": str(e)}), 500  

@pdm_bp.route("/so_qd_pdm/<string:so_qd_pdm>", methods=["GET"])
@jwt_required()
def get_so_qd_pdm(so_qd_pdm):
    so_qd_pdm = so_qd_pdm.replace('@gach_cheo', '/')
    try:
        pdm_identifier = so_qd_pdm.split("-")[0].strip() 
        year = so_qd_pdm.split("-")[1].strip() 
        print(f"Identifier: {pdm_identifier}, Year: {year}")
        query = PDM.query.filter(
            PDM.so_qd_pdm == pdm_identifier,
            db.extract('year', PDM.ngay_qd_pdm) == int(year) 
        )
        print(query)
        pdm = query.first() 
        if pdm is None:
            return jsonify({"msg": "No matching PDM found."}), 404
        return jsonify(pdm.to_dict()), 200 
    except Exception as e:
        print(e)
        return jsonify({"msg": "Đã xảy ra lỗi khi lấy thông tin PDM!", "error": str(e)}), 500  
    
@pdm_bp.route("/ma_tim_dong_ho_pdm/<string:ma_tim_dong_ho_pdm>", methods=["GET"])
@jwt_required()
def get_ma_tim_dong_ho_pdm(ma_tim_dong_ho_pdm):
    try:
        ma_tim_dong_ho_pdm = ma_tim_dong_ho_pdm.replace('@gach_cheo', '/')
        print(ma_tim_dong_ho_pdm)
        pdm = PDM.query.filter_by(ma_tim_dong_ho_pdm=ma_tim_dong_ho_pdm).first()
        if not pdm:
            return jsonify({"msg": "PDM not found!"}), 404
        
        print("pdm: ", pdm)
        return jsonify(pdm.to_dict()), 200
    except Exception as e:
        print(f"Error fetching PDM: {e}")
        return jsonify({"msg": "An internal server error occurred!"}), 500

@pdm_bp.route("/ma_tim_dong_ho_pdm/<string:ma_tim_dong_ho_pdm>", methods=["DELETE"])
@jwt_required()
def delete_by_pdm_id(ma_tim_dong_ho_pdm):
    try:
        ma_tim_dong_ho_pdm = ma_tim_dong_ho_pdm.replace('@gach_cheo', '/')
        
        pdm = PDM.query.filter_by(ma_tim_dong_ho_pdm=ma_tim_dong_ho_pdm).first_or_404()
        
        db.session.delete(pdm)
        db.session.commit()
        
        return jsonify({"msg": "Xóa phê duyệt mẫu thành công!"}), 200
    except Exception as e:
        print(f"Error deleting PDM: {e}")
        db.session.rollback()
        return jsonify({"msg": "Đã có lỗi xảy ra. Hãy thử lại sau."}), 500

@pdm_bp.route("/so_qd_pdm/<string:so_qd_pdm>", methods=["DELETE"])
@jwt_required()
def delete_by_so_qd_pdm(so_qd_pdm):
    pdm = PDM.query.filter_by(so_qd_pdm=so_qd_pdm).first_or_404()
    db.session.delete(pdm)
    db.session.commit()
    return jsonify({"msg": "PDM deleted successfully!"}), 200