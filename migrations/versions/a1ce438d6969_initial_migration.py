"""initial migration

Revision ID: a1ce438d6969
Revises: 
Create Date: 2024-09-25 15:21:46.956605

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'a1ce438d6969'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('dongho',
    sa.Column('serial_number', sa.String(length=255), nullable=False),
    sa.Column('phuong_tien_do', sa.String(length=255), nullable=True),
    sa.Column('seri_chi_thi', sa.String(length=255), nullable=True),
    sa.Column('seri_sensor', sa.String(length=255), nullable=True),
    sa.Column('kieu_chi_thi', sa.String(length=255), nullable=True),
    sa.Column('kieu_sensor', sa.String(length=255), nullable=True),
    sa.Column('kieu_thiet_bi', sa.String(length=255), nullable=True),
    sa.Column('co_so_san_xuat', sa.String(length=255), nullable=True),
    sa.Column('so_tem', sa.String(length=255), nullable=True),
    sa.Column('nam_san_xuat', sa.Date(), nullable=True),
    sa.Column('dn', sa.String(length=255), nullable=True),
    sa.Column('d', sa.String(length=255), nullable=True),
    sa.Column('ccx', sa.String(length=255), nullable=True),
    sa.Column('q3', sa.String(length=255), nullable=True),
    sa.Column('r', sa.String(length=255), nullable=True),
    sa.Column('qn', sa.String(length=255), nullable=True),
    sa.Column('k_factor', sa.String(length=255), nullable=True),
    sa.Column('so_qd_pdm', sa.String(length=255), nullable=True),
    sa.Column('ten_khach_hang', sa.String(length=255), nullable=True),
    sa.Column('co_so_su_dung', sa.String(length=255), nullable=True),
    sa.Column('phuong_phap_thuc_hien', sa.String(length=255), nullable=True),
    sa.Column('chuan_thiet_bi_su_dung', sa.String(length=255), nullable=True),
    sa.Column('implementer', sa.String(length=255), nullable=True),
    sa.Column('ngay_thuc_hien', sa.Date(), nullable=True),
    sa.Column('vi_tri', sa.String(length=255), nullable=True),
    sa.Column('nhiet_do', sa.String(length=255), nullable=True),
    sa.Column('do_am', sa.String(length=255), nullable=True),
    sa.Column('du_lieu_kiem_dinh', sa.Text(), nullable=True),
    sa.Column('hieu_luc_bien_ban', sa.Date(), nullable=True),
    sa.Column('so_giay_chung_nhan', sa.String(length=255), nullable=True),
    sa.PrimaryKeyConstraint('serial_number')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('dongho')
    # ### end Alembic commands ###
