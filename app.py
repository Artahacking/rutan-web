from flask import Flask, render_template, request, redirect, url_for, session, flash, send_file
import mysql.connector
import os
import pandas as pd
import io
from werkzeug.utils import secure_filename
from datetime import datetime
import urllib.parse # Untuk encode pesan WA

# Import file konfigurasi (pastikan file config.py ada di folder yang sama)
import config

app = Flask(__name__)

# Konfigurasi App
app.secret_key = config.SECRET_KEY
app.config['UPLOAD_FOLDER'] = config.UPLOAD_FOLDER

# Buat folder upload jika belum ada
if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])

# ==========================================
# 1. FUNGSI BANTUAN (DATABASE & FILE)
# ==========================================

def get_db():
    """Membuat koneksi ke database MySQL."""
    return mysql.connector.connect(**config.DB_CONFIG)

def allowed_file(filename, allowed_types):
    """Cek apakah ekstensi file diperbolehkan."""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in allowed_types

def format_whatsapp_number(phone):
    """
    Format nomor HP agar kompatibel dengan API WhatsApp (62...).
    Menghapus spasi, strip, dan mengubah 0 di depan menjadi 62.
    """
    if not phone:
        return ""
    
    # Hapus karakter non-digit (spasi, strip, plus, dll)
    phone = ''.join(filter(str.isdigit, str(phone)))
    
    # Jika diawali '0', ganti dengan '62'
    if phone.startswith('0'):
        phone = '62' + phone[1:]
    
    return phone

# ==========================================
# 2. ROUTES PUBLIK (USER INTERFACE)
# ==========================================

@app.route('/')
def index():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    
    # Ambil data Slider
    cursor.execute("SELECT * FROM sliders")
    sliders = cursor.fetchall()
    
    # Ambil 3 Berita Terbaru
    cursor.execute("SELECT * FROM news ORDER BY created_at DESC LIMIT 3")
    news = cursor.fetchall()
    
    # Ambil Statistik WBP
    try:
        cursor.execute("SELECT count FROM wbp_stats WHERE id = 1")
        wbp_data = cursor.fetchone()
        wbp_count = wbp_data['count'] if wbp_data else 0
    except:
        wbp_count = 0
        
    conn.close()
    return render_template('index.html', sliders=sliders, news=news, wbp_count=wbp_count)

@app.route('/profil')
def profil():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM profiles WHERE section_type='main' LIMIT 1")
    main_profile = cursor.fetchone()
    cursor.execute("SELECT * FROM profiles WHERE section_type='point'")
    points = cursor.fetchall()
    conn.close()
    return render_template('profil.html', main=main_profile, points=points)

# --- ROUTES LAYANAN (Integrasi, Litmas, Bebas) ---

@app.route('/layanan/integrasi')
def layanan_integrasi():
    # Ambil data layanan untuk ditampilkan di bagian bawah (jika ada template download)
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM services")
    services = cursor.fetchall()
    conn.close()
    return render_template('layanan_integrasi.html', services=services)

# FITUR BARU: PROSES UPLOAD SURAT JAMINAN
@app.route('/layanan/upload_surat', methods=['POST'])
def upload_surat_jaminan():
    nama = request.form['nama']
    nik = request.form['nik']
    no_wa_raw = request.form['no_wa']
    
    # Format nomor WA
    no_wa = format_whatsapp_number(no_wa_raw)
    
    # Cek File
    if 'file_surat' not in request.files:
        flash('Tidak ada file yang diunggah', 'danger')
        return redirect(url_for('layanan_integrasi'))
    
    file = request.files['file_surat']
    
    if file.filename == '':
        flash('Tidak ada file yang dipilih', 'danger')
        return redirect(url_for('layanan_integrasi'))

    # Gabungkan ekstensi gambar dan dokumen untuk validasi
    ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'pdf', 'doc', 'docx'}
    
    if file and allowed_file(file.filename, ALLOWED_EXTENSIONS):
        filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_SURAT_" + file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        
        conn = get_db()
        cursor = conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO surat_jaminan (nama_pengirim, nik, no_wa, file_surat, status)
                VALUES (%s, %s, %s, %s, 'Pending')
            """, (nama, nik, no_wa, filename))
            conn.commit()
            flash('Surat Jaminan berhasil dikirim! Petugas akan memverifikasi dan menghubungi Anda via WhatsApp.', 'success')
        except Exception as e:
            conn.rollback()
            flash(f'Terjadi kesalahan: {e}', 'danger')
        finally:
            conn.close()
    else:
        flash('Format file tidak didukung. Harap upload PDF, DOC, atau Gambar.', 'danger')
        
    return redirect(url_for('layanan_integrasi'))

@app.route('/layanan/litmas')
def layanan_litmas():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM litmas_data ORDER BY id DESC")
    data_litmas = cursor.fetchall()
    conn.close()
    return render_template('layanan_litmas.html', data=data_litmas)

@app.route('/download/litmas')
def download_litmas():
    conn = get_db()
    query = "SELECT nama_wbp, pidana_tahun, pidana_bulan, besaran_denda, subs_bulan FROM litmas_data ORDER BY id DESC"
    df = pd.read_sql(query, conn)
    conn.close()
    df.columns = ['Nama WBP', 'Pidana (Tahun)', 'Pidana (Bulan)', 'Besaran Denda', 'Subsider (Bulan)']
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name='Data Litmas')
    output.seek(0)
    return send_file(output, mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', as_attachment=True, download_name=f'Data_Litmas_{datetime.now().strftime("%Y%m%d")}.xlsx')

@app.route('/layanan/bebas')
def layanan_bebas():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM wbp_bebas ORDER BY tgl_ekspirasi ASC")
    data_bebas = cursor.fetchall()
    conn.close()
    return render_template('layanan_bebas.html', data=data_bebas)

@app.route('/download/bebas')
def download_bebas():
    conn = get_db()
    query = "SELECT nama_wbp, tgl_ekspirasi, keterangan FROM wbp_bebas ORDER BY tgl_ekspirasi ASC"
    df = pd.read_sql(query, conn)
    conn.close()
    df.columns = ['Nama WBP', 'Tanggal Ekspirasi', 'Keterangan']
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name='WBP Bebas')
    output.seek(0)
    return send_file(output, mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', as_attachment=True, download_name=f'Data_WBP_Bebas_{datetime.now().strftime("%Y%m%d")}.xlsx')

# --- ROUTES FITUR BARU: KUNJUNGAN ONLINE ---

@app.route('/layanan/kunjungan', methods=['GET', 'POST'])
def layanan_kunjungan():
    if request.method == 'POST':
        # Ambil data input form
        nama = request.form['nama']
        alamat = request.form['alamat']
        no_wa_raw = request.form['no_wa']
        umur = request.form['umur']
        jk = request.form['jenis_kelamin']
        nama_wbp = request.form['nama_wbp']
        perkara = request.form['perkara']
        
        # Format Nomor WA
        no_wa = format_whatsapp_number(no_wa_raw)
        
        conn = get_db()
        cursor = conn.cursor()
        try:
            # Query INSERT
            cursor.execute("""
                INSERT INTO kunjungan_online 
                (nama_pengunjung, alamat, no_wa, umur, jenis_kelamin, nama_wbp, perkara) 
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (nama, alamat, no_wa, umur, jk, nama_wbp, perkara))
            
            conn.commit()
            flash('Pendaftaran Kunjungan Berhasil! Data telah masuk ke sistem kami.', 'success')
        except Exception as e:
            conn.rollback()
            flash(f'Terjadi kesalahan: {e}', 'danger')
        finally:
            conn.close()
        return redirect(url_for('layanan_kunjungan'))
        
    return render_template('layanan_kunjungan.html')

# --- ROUTES FITUR BARU: PENGADUAN & INFORMASI ONLINE ---

@app.route('/layanan/informasi', methods=['GET', 'POST'])
def layanan_informasi():
    if request.method == 'POST':
        nama = request.form['nama']
        nik = request.form['nik']
        jk = request.form['jenis_kelamin']
        alamat = request.form['alamat']
        no_wa_raw = request.form['no_wa']
        deskripsi = request.form['deskripsi']
        jenis = 'Informasi'
        
        no_wa = format_whatsapp_number(no_wa_raw)
        
        conn = get_db()
        cursor = conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO pengaduan_online 
                (jenis_layanan, nama_pelapor, nik, jenis_kelamin, alamat, no_wa, deskripsi) 
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (jenis, nama, nik, jk, alamat, no_wa, deskripsi))
            
            conn.commit()
            flash('Permintaan Informasi terkirim! Petugas kami akan menghubungi via WhatsApp.', 'success')
        except Exception as e:
            flash(f'Gagal mengirim: {e}', 'danger')
        finally:
            conn.close()
        return redirect(url_for('layanan_informasi'))
    
    return render_template('layanan_pengaduan_form.html', page_title="Layanan Informasi Online", form_action=url_for('layanan_informasi'))

@app.route('/layanan/pengaduan', methods=['GET', 'POST'])
def layanan_pengaduan_user():
    if request.method == 'POST':
        nama = request.form['nama']
        nik = request.form['nik']
        jk = request.form['jenis_kelamin']
        alamat = request.form['alamat']
        no_wa_raw = request.form['no_wa']
        deskripsi = request.form['deskripsi']
        jenis = 'Pengaduan'
        
        no_wa = format_whatsapp_number(no_wa_raw)
        
        conn = get_db()
        cursor = conn.cursor()
        try:
            cursor.execute("""
                INSERT INTO pengaduan_online 
                (jenis_layanan, nama_pelapor, nik, jenis_kelamin, alamat, no_wa, deskripsi) 
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """, (jenis, nama, nik, jk, alamat, no_wa, deskripsi))
            
            conn.commit()
            flash('Pengaduan Anda telah kami terima dan akan segera diproses.', 'success')
        except Exception as e:
            flash(f'Gagal mengirim: {e}', 'danger')
        finally:
            conn.close()
        return redirect(url_for('layanan_pengaduan_user'))

    return render_template('layanan_pengaduan_form.html', page_title="Formulir Pengaduan Masyarakat", form_action=url_for('layanan_pengaduan_user'))

@app.route('/layanan')
def layanan():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM services")
    services = cursor.fetchall()
    conn.close()
    return render_template('layanan.html', services=services)

# --- ROUTES BERITA, KONTAK, GALERI ---

@app.route('/berita')
def berita():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    search_query = request.args.get('q')
    if search_query:
        query = "SELECT * FROM news WHERE title LIKE %s OR content LIKE %s ORDER BY created_at DESC"
        val = (f"%{search_query}%", f"%{search_query}%")
        cursor.execute(query, val)
    else:
        cursor.execute("SELECT * FROM news ORDER BY created_at DESC")
    news_list = cursor.fetchall()
    cursor.execute("SELECT id, title, created_at FROM news ORDER BY created_at DESC LIMIT 5")
    recent_news = cursor.fetchall()
    conn.close()
    return render_template('berita.html', news=news_list, recent=recent_news, search_query=search_query)

@app.route('/berita/<int:id>')
def detail_berita(id):
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM news WHERE id = %s", (id,))
    news_item = cursor.fetchone()
    cursor.execute("SELECT id, title, created_at FROM news ORDER BY created_at DESC LIMIT 5")
    recent_news = cursor.fetchall()
    conn.close()
    if not news_item: return "Berita tidak ditemukan", 404
    return render_template('detail_berita.html', item=news_item, recent=recent_news)

@app.route('/kontak', methods=['GET', 'POST'])
def kontak():
    if request.method == 'POST':
        name = request.form['name']
        phone = request.form['phone']
        message = request.form['message']
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute("INSERT INTO messages (name, phone, message) VALUES (%s, %s, %s)", (name, phone, message))
        conn.commit()
        conn.close()
        flash('Pesan berhasil dikirim! Kami akan menghubungi via WhatsApp.', 'success')
        return redirect(url_for('kontak'))
    return render_template('kontak.html')

@app.route('/galeri')
def galeri():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM gallery")
    photos = cursor.fetchall()
    conn.close()
    return render_template('galeri.html', photos=photos)

# ==========================================
# 3. ROUTES ADMIN (DASHBOARD & MANAGEMENT)
# ==========================================

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE username=%s AND password=%s", (username, password))
        user = cursor.fetchone()
        conn.close()
        if user:
            session['user'] = user['username']
            session['user_image'] = user.get('image') 
            return redirect(url_for('admin_dashboard'))
        else:
            flash('Username atau Password salah.', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/reset_password', methods=['GET', 'POST'])
def reset_password():
    if request.method == 'POST':
        username = request.form['username']
        new_password = request.form['new_password']
        recovery_code = request.form['recovery_code']
        if recovery_code != config.RECOVERY_CODE:
            flash('Kode Keamanan Salah!', 'danger')
            return redirect(url_for('reset_password'))
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users WHERE username=%s", (username,))
        user = cursor.fetchone()
        if user:
            cursor.execute("UPDATE users SET password=%s WHERE username=%s", (new_password, username))
            conn.commit()
            conn.close()
            flash('Password berhasil direset.', 'success')
            return redirect(url_for('login'))
        else:
            conn.close()
            flash('Username tidak ditemukan.', 'danger')
            return redirect(url_for('reset_password'))
    return render_template('reset_password.html')

@app.route('/admin')
def admin_dashboard():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    stats = {}
    
    # Hitung data dari tabel-tabel utama
    tables = ['news', 'messages', 'services', 'gallery', 'profiles', 'users', 'kunjungan_online', 'pengaduan_online', 'surat_jaminan']
    for t in tables:
        try:
            cursor.execute(f"SELECT COUNT(*) as count FROM {t}")
            stats[t] = cursor.fetchone()['count']
        except:
            stats[t] = 0
            
    # Statistik Khusus WBP
    try:
        cursor.execute("SELECT count FROM wbp_stats WHERE id=1")
        wbp = cursor.fetchone()
        stats['wbp'] = wbp['count'] if wbp else 0
    except:
        stats['wbp'] = 0
        
    conn.close()
    return render_template('admin/dashboard.html', stats=stats)

@app.route('/admin/wbp', methods=['GET', 'POST'])
def admin_wbp():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    if request.method == 'POST':
        new_count = request.form['wbp_count']
        cursor.execute("UPDATE wbp_stats SET count=%s WHERE id=1", (new_count,))
        conn.commit()
        flash('Jumlah WBP berhasil diperbarui!', 'success')
        conn.close()
        return redirect(url_for('admin_wbp'))
    
    cursor.execute("SELECT count FROM wbp_stats WHERE id=1")
    data = cursor.fetchone()
    current_count = data['count'] if data else 0
    conn.close()
    return render_template('admin/kelola_wbp.html', current_count=current_count)

# --- ADMIN: KELOLA KUNJUNGAN ONLINE ---
@app.route('/admin/kunjungan')
def admin_kunjungan():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM kunjungan_online ORDER BY created_at DESC")
    data = cursor.fetchall()
    conn.close()
    return render_template('admin/kelola_kunjungan.html', data=data)

@app.route('/admin/kunjungan/update', methods=['POST'])
def admin_kunjungan_update():
    if 'user' not in session: return redirect(url_for('login'))
    
    id_kunjungan = request.form['id']
    status_baru = request.form['status']
    
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE kunjungan_online SET status=%s WHERE id=%s", (status_baru, id_kunjungan))
    conn.commit()
    conn.close()
    
    flash('Status kunjungan berhasil diperbarui!', 'success')
    return redirect(url_for('admin_kunjungan'))

@app.route('/admin/kunjungan/delete/<int:id>')
def admin_kunjungan_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM kunjungan_online WHERE id=%s", (id,))
        conn.commit()
        flash('Data kunjungan berhasil dihapus!', 'success')
    except Exception as e:
        flash(f'Gagal menghapus: {e}', 'danger')
    finally:
        conn.close()
    return redirect(url_for('admin_kunjungan'))

# --- ADMIN: KELOLA PENGADUAN & INFO ---
@app.route('/admin/pengaduan')
def admin_pengaduan():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM pengaduan_online ORDER BY created_at DESC")
    data = cursor.fetchall()
    conn.close()
    return render_template('admin/kelola_pengaduan.html', data=data)

@app.route('/admin/pengaduan/delete/<int:id>')
def admin_pengaduan_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    try:
        cursor.execute("DELETE FROM pengaduan_online WHERE id=%s", (id,))
        conn.commit()
        flash('Data pengaduan berhasil dihapus.', 'success')
    except Exception as e:
        flash(f'Gagal menghapus data: {e}', 'danger')
    finally:
        conn.close()
    return redirect(url_for('admin_pengaduan'))

# --- ADMIN: FITUR BARU - KELOLA SURAT JAMINAN ---

@app.route('/admin/surat_jaminan')
def admin_surat_jaminan():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM surat_jaminan ORDER BY created_at DESC")
    data = cursor.fetchall()
    conn.close()
    return render_template('admin/kelola_surat.html', data=data)

@app.route('/admin/surat_jaminan/status', methods=['POST'])
def admin_surat_status():
    if 'user' not in session: return redirect(url_for('login'))
    id_surat = request.form['id']
    
    # Update status menjadi 'Dibalas' saat tombol kirim WA ditekan (via AJAX atau form ini)
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE surat_jaminan SET status='Dibalas' WHERE id=%s", (id_surat,))
    conn.commit()
    conn.close()
    return "OK", 200 # Digunakan untuk AJAX call

@app.route('/admin/surat_jaminan/delete/<int:id>')
def admin_surat_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    
    # Ambil info file untuk dihapus dari folder
    cursor.execute("SELECT file_surat FROM surat_jaminan WHERE id=%s", (id,))
    data = cursor.fetchone()
    if data and data['file_surat']:
        try:
            os.remove(os.path.join(app.config['UPLOAD_FOLDER'], data['file_surat']))
        except:
            pass
            
    cursor.execute("DELETE FROM surat_jaminan WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    flash('Data surat jaminan berhasil dihapus.', 'success')
    return redirect(url_for('admin_surat_jaminan'))

# --- ADMIN: DOWNLOAD TEMPLATE ---
@app.route('/download/template/litmas')
def template_litmas():
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df_title = pd.DataFrame(["PENGUMUMAN DAFTAR NAMA YANG BISA USUL LITMAS"])
        df_title.to_excel(writer, index=False, header=False, startrow=0, startcol=0, sheet_name='Template Litmas')
        df = pd.DataFrame(columns=['No', 'Nama', 'Lama Pidana (tahun)', 'Lama Pidana (bulan)', 'Besaran Denda', 'Subs Bulan'])
        df.to_excel(writer, index=False, startrow=2, sheet_name='Template Litmas')
    output.seek(0)
    return send_file(output, mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', as_attachment=True, download_name='Template_Upload_Litmas.xlsx')

@app.route('/download/template/bebas')
def template_bebas():
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df_title = pd.DataFrame(["DAFTAR NAMA WBP YANG AKAN BEBAS"])
        df_title.to_excel(writer, index=False, header=False, startrow=0, startcol=0, sheet_name='Template Bebas')
        df = pd.DataFrame(columns=['No', 'Nama', 'Tgl Ekspirasi', 'Keterangan'])
        df.loc[0] = [1, 'CONTOH NAMA', '01/01/2026', 'BEBAS BIASA']
        df.to_excel(writer, index=False, startrow=2, sheet_name='Template Bebas')
    output.seek(0)
    return send_file(output, mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', as_attachment=True, download_name='Template_Upload_Bebas.xlsx')

# --- ADMIN: KELOLA LITMAS ---
@app.route('/admin/litmas', methods=['GET'])
def admin_litmas():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM litmas_data ORDER BY id DESC")
    data = cursor.fetchall()
    conn.close()
    return render_template('admin/kelola_litmas.html', data=data)

@app.route('/admin/litmas/add', methods=['POST'])
def admin_litmas_add():
    if 'user' not in session: return redirect(url_for('login'))
    if 'file' not in request.files: return redirect(url_for('admin_litmas'))
    file = request.files['file']
    if file.filename == '': return redirect(url_for('admin_litmas'))

    if file and (file.filename.endswith('.xlsx') or file.filename.endswith('.xls')):
        try:
            df = pd.read_excel(file, header=2)
            conn = get_db()
            cursor = conn.cursor()
            count = 0
            for index, row in df.iterrows():
                if pd.isna(row.iloc[1]): continue
                nama = str(row.iloc[1])
                tahun = int(row.iloc[2]) if pd.notna(row.iloc[2]) else 0
                bulan = int(row.iloc[3]) if pd.notna(row.iloc[3]) else 0
                denda = str(row.iloc[4]) if pd.notna(row.iloc[4]) else "Rp. 0"
                subs = int(row.iloc[5]) if pd.notna(row.iloc[5]) else 0
                cursor.execute("INSERT INTO litmas_data (nama_wbp, pidana_tahun, pidana_bulan, besaran_denda, subs_bulan) VALUES (%s, %s, %s, %s, %s)",
                               (nama, tahun, bulan, denda, subs))
                count += 1
            conn.commit()
            conn.close()
            flash(f'Berhasil impor {count} data Litmas.', 'success')
        except Exception as e:
            flash(f'Error: {str(e)}', 'danger')
    return redirect(url_for('admin_litmas'))

@app.route('/admin/litmas/update', methods=['POST'])
def admin_litmas_update():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE litmas_data SET nama_wbp=%s, pidana_tahun=%s, pidana_bulan=%s, besaran_denda=%s, subs_bulan=%s WHERE id=%s",
                   (request.form['nama'], request.form['tahun'], request.form['bulan'], request.form['denda'], request.form['subs'], request.form['id']))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_litmas'))

@app.route('/admin/litmas/delete/<int:id>')
def admin_litmas_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM litmas_data WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_litmas'))

# --- ADMIN: KELOLA BEBAS ---
@app.route('/admin/bebas', methods=['GET'])
def admin_bebas():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM wbp_bebas ORDER BY tgl_ekspirasi ASC")
    data = cursor.fetchall()
    conn.close()
    return render_template('admin/kelola_bebas.html', data=data)

@app.route('/admin/bebas/add', methods=['POST'])
def admin_bebas_add():
    if 'user' not in session: return redirect(url_for('login'))
    if 'file' not in request.files: return redirect(url_for('admin_bebas'))
    file = request.files['file']
    if file.filename == '': return redirect(url_for('admin_bebas'))

    if file and (file.filename.endswith('.xlsx') or file.filename.endswith('.xls')):
        try:
            df = pd.read_excel(file, header=2)
            conn = get_db()
            cursor = conn.cursor()
            count = 0
            for index, row in df.iterrows():
                if pd.isna(row.iloc[1]): continue
                nama = str(row.iloc[1])
                raw_tgl = row.iloc[2]
                ket = str(row.iloc[3]) if pd.notna(row.iloc[3]) else "-"
                tgl_str = datetime.now().strftime('%Y-%m-%d')
                if pd.notna(raw_tgl):
                    try: tgl_str = pd.to_datetime(raw_tgl, dayfirst=True).strftime('%Y-%m-%d')
                    except: pass
                cursor.execute("INSERT INTO wbp_bebas (nama_wbp, tgl_ekspirasi, keterangan) VALUES (%s, %s, %s)",
                               (nama, tgl_str, ket))
                count += 1
            conn.commit()
            conn.close()
            flash(f'Berhasil impor {count} data WBP Bebas.', 'success')
        except Exception as e:
            flash(f'Error: {str(e)}', 'danger')
    return redirect(url_for('admin_bebas'))

@app.route('/admin/bebas/update', methods=['POST'])
def admin_bebas_update():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("UPDATE wbp_bebas SET nama_wbp=%s, tgl_ekspirasi=%s, keterangan=%s WHERE id=%s",
                   (request.form['nama'], request.form['tgl'], request.form['ket'], request.form['id']))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_bebas'))

@app.route('/admin/bebas/delete/<int:id>')
def admin_bebas_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM wbp_bebas WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_bebas'))

# --- ADMIN: KELOLA USERS ---
@app.route('/admin/users')
def admin_users():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users ORDER BY id DESC")
    users = cursor.fetchall()
    conn.close()
    return render_template('admin/kelola_admin.html', data=users)

@app.route('/admin/users/add', methods=['POST'])
def admin_users_add():
    if 'user' not in session: return redirect(url_for('login'))
    username = request.form['username']
    password = request.form['password']
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE username=%s", (username,))
    if cursor.fetchone():
        conn.close()
        flash('Username sudah digunakan!', 'danger')
        return redirect(url_for('admin_users'))
    filename = None
    if 'image' in request.files:
        file = request.files['image']
        if file and allowed_file(file.filename, config.IMG_EXTENSIONS):
            filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    cursor.execute("INSERT INTO users (username, password, image) VALUES (%s, %s, %s)", (username, password, filename))
    conn.commit()
    conn.close()
    flash('Admin baru ditambahkan', 'success')
    return redirect(url_for('admin_users'))

@app.route('/admin/users/update', methods=['POST'])
def admin_users_update():
    if 'user' not in session: return redirect(url_for('login'))
    user_id = request.form['id']
    username = request.form['username']
    new_password = request.form.get('password') 
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE id=%s", (user_id,))
    old_data = cursor.fetchone()
    if not old_data:
        conn.close()
        return "User not found"
    filename = old_data['image']
    if 'image' in request.files:
        file = request.files['image']
        if file and allowed_file(file.filename, config.IMG_EXTENSIONS):
            if old_data['image']:
                try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], old_data['image']))
                except: pass
            filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            if session['user'] == old_data['username']: session['user_image'] = filename
    if new_password:
        cursor.execute("UPDATE users SET username=%s, password=%s, image=%s WHERE id=%s", (username, new_password, filename, user_id))
    else:
        cursor.execute("UPDATE users SET username=%s, image=%s WHERE id=%s", (username, filename, user_id))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_users'))

@app.route('/admin/users/delete/<int:id>')
def admin_users_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users WHERE id=%s", (id,))
    user = cursor.fetchone()
    if user and user['username'] == session['user']:
        conn.close()
        flash('Tidak bisa menghapus akun sendiri!', 'danger')
        return redirect(url_for('admin_users'))
    if user and user['image']:
        try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], user['image']))
        except: pass
    cursor.execute("DELETE FROM users WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_users'))

# --- ADMIN: KELOLA KONTEN GENERIC (BERITA, GALERI, PROFIL, DLL) ---
@app.route('/admin/<category>', methods=['GET'])
def admin_list(category):
    if 'user' not in session: return redirect(url_for('login'))
    table_map = {'berita': 'news', 'layanan': 'services', 'galeri': 'gallery', 'slider': 'sliders', 'pesan': 'messages', 'profil': 'profiles'}
    if category not in table_map: return "Kategori tidak ditemukan"
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    if category == 'profil': cursor.execute("SELECT * FROM profiles ORDER BY section_type")
    elif category == 'pesan': cursor.execute("SELECT * FROM messages ORDER BY created_at DESC")
    else: cursor.execute(f"SELECT * FROM {table_map[category]} ORDER BY id DESC")
    data = cursor.fetchall()
    conn.close()
    if category == 'berita': return render_template('admin/kelola_berita.html', category=category, data=data)
    elif category == 'pesan': return render_template('admin/kelola_pesan.html', category=category, data=data)
    return render_template('admin/kelola_konten.html', category=category, data=data)

@app.route('/admin/<category>/add', methods=['POST'])
def admin_add(category):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    filename = None
    if 'image' in request.files:
        file = request.files['image']
        if category == 'layanan':
            if file and allowed_file(file.filename, config.DOC_EXTENSIONS):
                filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        else:
            if file and allowed_file(file.filename, config.IMG_EXTENSIONS):
                filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    
    if category == 'berita':
        # UPDATE DISINI: Menambahkan kolom category ke query INSERT
        content = f"<strong>{request.form.get('city')}</strong> — {request.form['content']}" if request.form.get('city') else request.form['content']
        category_val = request.form.get('category', 'Kegiatan Rutan') # Default value
        cursor.execute("INSERT INTO news (title, category, content, author, image) VALUES (%s, %s, %s, %s, %s)", 
                       (request.form['title'], category_val, content, request.form['author'], filename))
    elif category == 'layanan':
        cursor.execute("INSERT INTO services (title, description, file) VALUES (%s, %s, %s)", (request.form['title'], request.form['description'], filename))
    elif category == 'galeri':
        cursor.execute("INSERT INTO gallery (title, image) VALUES (%s, %s)", (request.form['title'], filename))
    elif category == 'slider':
        auto_title = "Slider " + datetime.now().strftime("%Y-%m-%d %H:%M")
        cursor.execute("INSERT INTO sliders (title, link, image) VALUES (%s, %s, %s)", (auto_title, '#', filename))
    elif category == 'profil':
        cursor.execute("INSERT INTO profiles (section_type, title, content, image) VALUES ('point', %s, %s, %s)", (request.form['title'], request.form['content'], filename))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_list', category=category))

@app.route('/admin/<category>/update', methods=['POST'])
def admin_update(category):
    if 'user' not in session: return redirect(url_for('login'))
    data_id = request.form['id']
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    table_map = {'berita': 'news', 'layanan': 'services', 'galeri': 'gallery', 'slider': 'sliders', 'profil': 'profiles'}
    table = table_map.get(category)
    cursor.execute(f"SELECT * FROM {table} WHERE id=%s", (data_id,))
    old_data = cursor.fetchone()
    
    filename = old_data.get('file' if category == 'layanan' else 'image')
    if 'image' in request.files:
        file = request.files['image']
        allowed = config.DOC_EXTENSIONS if category == 'layanan' else config.IMG_EXTENSIONS
        if file and allowed_file(file.filename, allowed):
            if filename:
                try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], filename))
                except: pass
            filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

    if category == 'berita':
        # UPDATE DISINI: Menambahkan kolom category ke query UPDATE
        category_val = request.form.get('category', 'Kegiatan Rutan')
        cursor.execute("UPDATE news SET title=%s, category=%s, content=%s, author=%s, image=%s WHERE id=%s", 
                       (request.form['title'], category_val, request.form['content'], request.form['author'], filename, data_id))
    elif category == 'layanan':
        cursor.execute("UPDATE services SET title=%s, description=%s, file=%s WHERE id=%s", (request.form['title'], request.form['description'], filename, data_id))
    elif category == 'galeri':
        cursor.execute("UPDATE gallery SET title=%s, image=%s WHERE id=%s", (request.form['title'], filename, data_id))
    elif category == 'slider':
        if 'image' in request.files and request.files['image'].filename != '':
             cursor.execute("UPDATE sliders SET image=%s WHERE id=%s", (filename, data_id))
    elif category == 'profil':
        cursor.execute("UPDATE profiles SET title=%s, content=%s, image=%s WHERE id=%s", (request.form['title'], request.form['content'], filename, data_id))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_list', category=category))

@app.route('/admin/<category>/delete/<int:id>')
def admin_delete(category, id):
    if 'user' not in session: return redirect(url_for('login'))
    table_map = {'berita': 'news', 'layanan': 'services', 'galeri': 'gallery', 'slider': 'sliders', 'pesan': 'messages', 'profil': 'profiles'}
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute(f"SELECT * FROM {table_map[category]} WHERE id=%s", (id,))
    item = cursor.fetchone()
    if item:
        file = item.get('file' if category == 'layanan' else 'image')
        if file:
            try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], file))
            except: pass
    cursor.execute(f"DELETE FROM {table_map[category]} WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('admin_list', category=category))

if __name__ == '__main__':
    app.run(debug=True)