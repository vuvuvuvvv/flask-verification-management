from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required
from app.models import DongHo
from app import db

dongho_bp = Blueprint('dongho', __name__)

@dongho_bp.route('', methods=['POST'])
@jwt_required()
def create_dongho():
    data = request.get_json()
    seri_number = data.get('seri_number')

    # Check if seri_number already exists
    existing_dongho = DongHo.query.filter_by(seri_number=seri_number).first()
    if existing_dongho:
        return jsonify({"msg": "Serinumber đã tồn tại!"}), 400

    new_dongho = DongHo(**data)
    db.session.add(new_dongho)
    db.session.commit()
    return jsonify(new_dongho.to_dict()), 201

@dongho_bp.route('/<int:id>', methods=['PUT'])
@jwt_required()
def update_dongho(id):
    data = request.get_json()
    dongho = DongHo.query.get_or_404(id)
    for key, value in data.items():
        setattr(dongho, key, value)
    db.session.commit()
    return jsonify(dongho.to_dict()), 200

@dongho_bp.route('/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_dongho(id):
    dongho = DongHo.query.get_or_404(id)
    db.session.delete(dongho)
    db.session.commit()
    return jsonify({"msg": "Xóa thành công!"}), 200

@dongho_bp.route('/serinumber/<string:serinumber>', methods=['GET'])
@jwt_required()
def get_dongho_by_serinumber(serinumber):
    dongho = DongHo.query.filter_by(serinumber=serinumber).first_or_404()
    return jsonify(dongho.to_dict()), 200

@dongho_bp.route('/tenkhachhang/<string:tenkhachhang>', methods=['GET'])
@jwt_required()
def get_dongho_by_tenkhachhang(tenkhachhang):
    donghos = DongHo.query.filter_by(tenkhachhang=tenkhachhang).all()
    result = [dongho.to_dict() for dongho in donghos]
    return jsonify(result), 200