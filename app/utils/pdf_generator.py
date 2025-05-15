# utils/pdf_generator.py
from io import BytesIO

def process_excel_bytesio_to_pdf(excel_buffer: BytesIO, file_name: str) -> tuple[BytesIO, str]:
    """
    Xử lý Excel từ BytesIO, tạo PDF và trả về đường dẫn file PDF.
    """
    import os
    import datetime

    # Tạo temp file từ buffer
    BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
    TEMP_DIR = os.path.join(BASE_DIR, "files", "temp_files")
    os.makedirs(TEMP_DIR, exist_ok=True)

    timestamp = datetime.datetime.now().strftime("%d%m%y_%H%M%S")
    temp_excel_filename = f"temp_{file_name}_{timestamp}.xlsx"
    temp_excel_path = os.path.join(TEMP_DIR, temp_excel_filename)

    excel_buffer.seek(0)
    with open(temp_excel_path, "wb") as f:
        f.write(excel_buffer.read())

    # Gọi lại hàm gốc
    return process_excel_to_pdf(temp_excel_path, file_name)


def process_excel_to_pdf(source_excel_path: str, file_name: str) -> tuple[BytesIO, str]:
    """
    Xử lý file Excel đầu vào và trả về buffer chứa PDF sau khi đã xoá watermark.
    
    :param source_excel_path: Đường dẫn file Excel gốc
    :return: Tuple (buffer PDF, tên file PDF)
    """
    import os
    import shutil
    from spire.xls import Workbook, ExcelVersion
    import fitz
    from PyPDF2 import PdfReader, PdfWriter
    from reportlab.lib.pagesizes import letter
    from reportlab.pdfgen import canvas
    from io import BytesIO
    from PIL import Image, ImageEnhance
    import datetime

    BASE_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), "../.."))
    TEMP_DIR = os.path.join(BASE_DIR, "files", "temp_files")
    os.makedirs(TEMP_DIR, exist_ok=True)

    filename = os.path.splitext(os.path.basename(source_excel_path))[0] + ".pdf"
    output_pdf_path_base = os.path.join(TEMP_DIR, "output_base.pdf")

    # Tạo tên file tạm thời
    timestamp = datetime.datetime.now().strftime("%d%m%y_%H%M%S")
    temp_excel_filename = f"{file_name}_{timestamp}.xlsx"
    print(f"Temporary Excel file: {temp_excel_filename}")
    temp_excel_path = os.path.join(TEMP_DIR, temp_excel_filename)
    shutil.copy(source_excel_path, temp_excel_path)

    # Chỉnh sửa row 1 để tăng chiều cao & căn dưới
    workbook_kl = Workbook()
    workbook_kl.LoadFromFile(temp_excel_path)
    sheet_kl = workbook_kl.Worksheets[0]
    original_height = sheet_kl.GetRowHeight(1)
    sheet_kl.SetRowHeight(1, original_height + 165.75)
    for col in range(1, sheet_kl.LastColumn + 1):
        cell = sheet_kl.Range[1, col]
    workbook_kl.SaveToFile(temp_excel_path, ExcelVersion.Version2016)
    workbook_kl.Dispose()

    # Tạo bản PDF gốc và PDF đã chỉnh sửa
    pdf_base_path = os.path.join(TEMP_DIR, "output_base.pdf")
    pdf_kl_path = os.path.join(TEMP_DIR, "output_kl.pdf")

    workbook_main = Workbook()
    workbook_main.LoadFromFile(source_excel_path)
    workbook_main.Worksheets[0].SaveToPdf(pdf_base_path)
    workbook_main.Dispose()

    workbook_crop = Workbook()
    workbook_crop.LoadFromFile(temp_excel_path)
    workbook_crop.Worksheets[0].SaveToPdf(pdf_kl_path)
    workbook_crop.Dispose()

    # Hàm cắt KL
    def extract_conclusions_from_pdf(pdf_path, rect):
        doc = fitz.open(pdf_path)
        images = []
        for i, page in enumerate(doc):
            rect_copy = fitz.Rect(rect)
            rect_copy.x0 = 0
            rect_copy.x1 = page.rect.width
            pix = page.get_pixmap(clip=rect_copy, dpi=400)
            img_path = os.path.join(TEMP_DIR, f"extracted_{i}.png")
            pix.save(img_path)
            images.append(img_path)
        return images

    def enhance_images(img_paths):
        enhanced = []
        for p in img_paths:
            img = Image.open(p)
            img = ImageEnhance.Sharpness(img).enhance(2.0)
            out = p.replace("extracted", "enhanced")
            img.save(out)
            enhanced.append(out)
        return enhanced

    def add_images_to_pdf(base_pdf, img_paths):
        reader = PdfReader(base_pdf)
        writer = PdfWriter()
        for i, page in enumerate(reader.pages):
            packet = BytesIO()
            can = canvas.Canvas(packet, pagesize=letter)
            img = Image.open(img_paths[i])
            pdf_width = letter[0] * 0.9726
            scale = pdf_width / img.width
            img_height_scaled = img.height * scale
            can.drawImage(img_paths[i], 0, 404.5, width=pdf_width, height=img_height_scaled)
            can.save()
            packet.seek(0)
            overlay = PdfReader(packet)
            page.merge_page(overlay.pages[0])
            writer.add_page(page)
        buffer = BytesIO()
        writer.write(buffer)
        buffer.seek(0)
        return buffer

    rect = fitz.Rect(0, 568, 550, 603)
    extracted = extract_conclusions_from_pdf(pdf_kl_path, rect)
    enhanced = enhance_images(extracted)
    pdf_buffer = add_images_to_pdf(pdf_base_path, enhanced)

    # Cleanup
    for f in [source_excel_path, temp_excel_path, pdf_base_path, pdf_kl_path] + extracted + enhanced: #source gốc: source_excel_path
        print(f"Deleting file: {f}")
        try:
            os.remove(f)
        except Exception as e:
            print(f"Error deleting file {f}: {e}")

    return pdf_buffer, filename

