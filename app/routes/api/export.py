from flask import Blueprint, jsonify
from flask_jwt_extended import jwt_required
from app.models import DongHo
from app import db
from werkzeug.exceptions import NotFound
import json
from helper.url_encrypt import decode
import openpyxl
from openpyxl.drawing.image import Image
from openpyxl.styles import Border, Side

import os

export_bp = Blueprint("export", __name__)

class DuLieuMotLanChay:
    def __init__(self, V1: float, V2: float, Vc1: float, Vc2: float):
        self.V1 = V1
        self.V2 = V2
        self.Vc1 = Vc1
        self.Vc2 = Vc2

def get_sai_so_dong_ho(form_value: DuLieuMotLanChay) -> float:
    if form_value:
        if form_value.V2 == 0 and form_value.Vc2 == 0 and form_value.Vc1 == 0:
            return None

        VDHCT = form_value.V2 - form_value.V1
        VDHC = form_value.Vc2 - form_value.Vc1
        if VDHC != 0:
            error = ((VDHCT - VDHC) / VDHC) * 100
            return round(error, 3)  # Làm tròn đến 3 chữ số thập phân

    return None

@export_bp.route("/kiemdinh/bienban/<string:id>", methods=["GET"])
# @jwt_required()
def get_bb_kiem_dinh(id):
    row_heights = 0.69 #cm

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
                print(f"Error at: {e.msg}")
        fileName = (
            "KĐ_BB_"
            + (dongho.ten_dong_ho or "")
            + (dongho.dn or "")
            + (dongho.ccx or "")
            + (dongho.q3 or "")
            + (dongho.r or "")
            + (dongho.qn or "")
            + (dongho.seri_sensor or "")
            + (dongho.seri_chi_thi or "")
            + (dongho.kieu_sensor or "")
            + (dongho.kieu_chi_thi or "")
            + ".xlsx"
        )

        file_path = f"excels/export/{fileName}"
        # if not os.path.exists(file_path):
        if True:
            src_file = "excels/ExcelForm.xlsx"
            sheet_name = "BB"
            workbook = openpyxl.load_workbook(src_file)
            sheet = workbook[sheet_name]

            positions = ["22", "23", "24", "26"]

            for pos in positions:
                check_img = Image("excels/data/check.png")
                sheet.add_image(check_img, f"U{pos}")
                check_img.width = 25
                check_img.height = 25

                circle_img = Image("excels/data/circle.png")
                sheet.add_image(circle_img, f"Z{pos}")
                circle_img.width = 25
                circle_img.height = 25

            sheet.cell(row=2, column=20, value="BIÊN BẢN KIỂM ĐỊNH")

            if dongho.so_giay_chung_nhan:
                sheet.cell(
                    row=3, column=20, value=f"FMS.KĐ.{dongho.so_giay_chung_nhan}.{dongho.ngay_thuc_hien.strftime('%y')}"
                )

            sheet.cell(
                row=5, column=8, value=dongho.ten_dong_ho if dongho.ten_dong_ho else ""
            )
            sheet.cell(
                row=6,
                column=8,
                value=dongho.co_so_san_xuat if dongho.co_so_san_xuat else "",
            )

            sheet.cell(
                row=7,
                column=8,
                value=(
                    (
                        f"Sensor: {dongho.kieu_sensor}"
                        if dongho.kieu_chi_thi
                        else dongho.kieu_sensor
                    )
                    if dongho.kieu_sensor
                    else ""
                ),
            )

            sheet.cell(
                row=8,
                column=8,
                value=(
                    f"Tranmistter: {dongho.kieu_chi_thi}" if dongho.kieu_chi_thi else ""
                ),
            )

            sheet.cell(
                row=7,
                column=27,
                value=(
                    (
                        f"Sensor: {dongho.seri_sensor}"
                        if dongho.seri_chi_thi
                        else dongho.seri_sensor
                    )
                    if dongho.seri_sensor
                    else ""
                ),
            )

            sheet.cell(
                row=8,
                column=27,
                value=(
                    f"Tranmistter: {dongho.seri_chi_thi}" if dongho.seri_chi_thi else ""
                ),
            )

            if dongho.dn:
                sheet.cell(row=9, column=26, value=dongho.dn)

            if dongho.q3 or dongho.qn:
                sheet.cell(row=10, column=24, value="Q3=" if dongho.q3 else "Qn=")
                sheet.cell(
                    row=10, column=25, value=dongho.q3 if dongho.q3 else dongho.qn
                )

            # M12
            if dongho.ccx:
                sheet.cell(row=11, column=13, value="-")
                sheet.cell(row=11, column=14, value=f"Cấp chính xác: {dongho.ccx}")

            if dongho.so_qd_pdm:
                sheet.cell(row=12, column=13, value="-")
                sheet.cell(row=12, column=14, value=f"Ký hiệu PDM / Số quyết định:")
                sheet.cell(row=12, column=26, value=dongho.so_qd_pdm)

            # R18
            if dongho.k_factor:
                sheet.cell(row=13, column=13, value="-")
                sheet.cell(row=13, column=14, value=f"Hệ số K:")
                sheet.cell(row=13, column=19, value=dongho.k_factor)
            # H7
            if dongho.co_so_su_dung:
                sheet.cell(row=14, column=8, value=dongho.co_so_su_dung)

            # K10
            if dongho.phuong_phap_thuc_hien:
                sheet.cell(row=16, column=11, value=dongho.phuong_phap_thuc_hien)

            if dongho.chuan_thiet_bi_su_dung:
                sheet.cell(row=17, column=11, value=dongho.chuan_thiet_bi_su_dung)

            if dongho.nguoi_kiem_dinh:
                sheet.cell(row=19, column=9, value=dongho.nguoi_kiem_dinh)

            sheet.cell(
                row=19,
                column=29,
                value=(
                    dongho.ngay_thuc_hien.strftime("%d/%m/%Y")
                    if dongho.ngay_thuc_hien
                    else ""
                ),
            )

            sheet.cell(
                row=20,
                column=2,
                value=f"Địa điểm thực hiện: {dongho.vi_tri}" if dongho.vi_tri else "",
            )

            if dongho.nguoi_kiem_dinh:
                sheet.cell(row=42, column=5, value=dongho.nguoi_kiem_dinh)

            desired_height = row_heights * 28.35
            # Run from row: 2
            for row in range(2, sheet.max_row + 1):
                sheet.row_dimensions[row].height = desired_height

            # Bảng dl: start from row 32:
            du_lieu = dongho_dict['du_lieu_kiem_dinh']['du_lieu']
            hieu_sai_so = list(dongho_dict['du_lieu_kiem_dinh']['hieu_sai_so'])
            titles = ["Q3","Q2","Q1"] if dongho.q3 else ['Qn', "Qt", "Qmin"]
            start_row = 32

            black_solid = Side(style="thin", color="000000")   # Viền liền màu đen (mỏng)
            black_dotted = Side(style="dotted", color="000000")

            for index, ll in enumerate(titles):
                tmp_start_row = start_row
                dl_ll = du_lieu[ll]
                lan_chay = dict(dl_ll['lan_chay'])
                #merge cell
                sheet[f"B{start_row}"] = ll    
                sheet[f"D{start_row}"] = dl_ll['value']    
                sheet[f"AJ{start_row}"] = hieu_sai_so[index]['hss']
                sheet.merge_cells(f"B{start_row}:C{start_row + len(lan_chay) - 1}")    #title ll
                sheet.merge_cells(f"D{start_row}:F{start_row + len(lan_chay) - 1}")    #value ll
                sheet.merge_cells(f"AJ{start_row}:AL{start_row + len(lan_chay) - 1}")  #hss

                for key, val in lan_chay.items():
                    sheet.merge_cells(f"G{start_row}:J{start_row}")
                    sheet[f"G{start_row}"] = val['V1']
                    sheet.merge_cells(f"K{start_row}:N{start_row}")
                    sheet[f"K{start_row}"] = val['V2']
                    sheet.merge_cells(f"O{start_row}:Q{start_row}")
                    sheet[f"O{start_row}"] = val['V2'] - val['V1']
                    sheet.merge_cells(f"R{start_row}:S{start_row}")
                    sheet[f"R{start_row}"] = val['Tdh']

                    sheet.merge_cells(f"T{start_row}:W{start_row}")
                    sheet[f"T{start_row}"] = val['Vc1']
                    sheet.merge_cells(f"X{start_row}:AA{start_row}")
                    sheet[f"X{start_row}"] = val['Vc2']
                    sheet.merge_cells(f"AB{start_row}:AD{start_row}")
                    sheet[f"AB{start_row}"] = val['Vc2'] - val['Vc1']
                    sheet.merge_cells(f"AE{start_row}:AF{start_row}")
                    sheet[f"AE{start_row}"] = val['Tc']

                    sheet.merge_cells(f"AG{start_row}:AI{start_row}")
                    du_lieu_instance = DuLieuMotLanChay(val['V1'], val['V2'], val['Vc1'], val['Vc2'])
                    sai_so = get_sai_so_dong_ho(du_lieu_instance)
                    sheet[f"AG{start_row}"] = sai_so if sai_so is not None else "Lỗi"
                    start_row += 1

                
                            
                # Tạo viền chấm cho toàn bộ vùng B2:AL3
                for row in sheet.iter_rows(min_row=tmp_start_row, max_row=tmp_start_row + len(lan_chay) - 1, min_col=2, max_col=38):
                    for cell in row:
                        cell.border = Border(
                            top=black_dotted,
                            bottom=black_dotted,
                            left=black_dotted,
                            right=black_dotted
                        )

                # Tạo viền liền đen cho các vùng bọc ngoài
                # Bọc ngoài B2:F3
                for row in sheet.iter_rows(min_row=tmp_start_row, max_row=tmp_start_row + len(lan_chay) - 1, min_col=2, max_col=6):
                    for cell in row:
                        if cell.row == 2:  # Top border
                            cell.border = Border(top=black_solid, left=cell.border.left, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.row == 3:  # Bottom border
                            cell.border = Border(bottom=black_solid, left=cell.border.left, right=cell.border.right, top=cell.border.top)
                        if cell.column == 2:  # Left border
                            cell.border = Border(left=black_solid, top=cell.border.top, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.column == 6:  # Right border
                            cell.border = Border(right=black_solid, top=cell.border.top, bottom=cell.border.bottom, left=cell.border.left)

                # Bọc ngoài G2:S3
                for row in sheet.iter_rows(min_row=tmp_start_row, max_row=tmp_start_row + len(lan_chay) - 1, min_col=7, max_col=19):
                    for cell in row:
                        if cell.row == 2:  # Top border
                            cell.border = Border(top=black_solid, left=cell.border.left, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.row == 3:  # Bottom border
                            cell.border = Border(bottom=black_solid, left=cell.border.left, right=cell.border.right, top=cell.border.top)
                        if cell.column == 7:  # Left border
                            cell.border = Border(left=black_solid, top=cell.border.top, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.column == 19:  # Right border
                            cell.border = Border(right=black_solid, top=cell.border.top, bottom=cell.border.bottom, left=cell.border.left)

                # Bọc ngoài T2:AF3
                for row in sheet.iter_rows(min_row=tmp_start_row, max_row=tmp_start_row + len(lan_chay) - 1, min_col=20, max_col=32):
                    for cell in row:
                        if cell.row == 2:  # Top border
                            cell.border = Border(top=black_solid, left=cell.border.left, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.row == 3:  # Bottom border
                            cell.border = Border(bottom=black_solid, left=cell.border.left, right=cell.border.right, top=cell.border.top)
                        if cell.column == 20:  # Left border
                            cell.border = Border(left=black_solid, top=cell.border.top, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.column == 32:  # Right border
                            cell.border = Border(right=black_solid, top=cell.border.top, bottom=cell.border.bottom, left=cell.border.left)

                # Bọc ngoài AG2:AL3
                for row in sheet.iter_rows(min_row=tmp_start_row, max_row=tmp_start_row + len(lan_chay) - 1, min_col=33, max_col=38):
                    for cell in row:
                        if cell.row == 2:  # Top border
                            cell.border = Border(top=black_solid, left=cell.border.left, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.row == 3:  # Bottom border
                            cell.border = Border(bottom=black_solid, left=cell.border.left, right=cell.border.right, top=cell.border.top)
                        if cell.column == 33:  # Left border
                            cell.border = Border(left=black_solid, top=cell.border.top, right=cell.border.right, bottom=cell.border.bottom)
                        if cell.column == 38:  # Right border
                            cell.border = Border(right=black_solid, top=cell.border.top, bottom=cell.border.bottom, left=cell.border.left)


            # TODO: Save
            workbook.save(file_path)
            print(f"File saved as: {file_path}")
        else:
            print(f"File already exists: {file_path}")
        return jsonify({"msg": "Thành công!", "data": dongho_dict}), 200
    except NotFound:
        return jsonify({"msg": "Id không hợp lệ!"}), 404
    except Exception as e:
        return jsonify({"msg": f"Đã có lỗi xảy ra: {str(e)}"}), 500


@export_bp.route("/kiemdinh/gcn/<string:id>", methods=["GET"])
@jwt_required()
def get_gcn_kiem_dinh(id):
    # tenDongHo + dn + ccx + q3 + r + qn + (ngayThucHien ? dayjs(ngayThucHien).format('DDMMYYHHmmss') : '')
    pass
