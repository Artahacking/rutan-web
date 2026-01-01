from flask import Flask, render_template, request, redirect, url_for, session, flash, send_file, send_from_directory, abort
import mysql.connector
import os
import pandas as pd
import io
from werkzeug.utils import secure_filename
from datetime import datetime

# Import file konfigurasi
import config

app = Flask(__name__)

# Konfigurasi
app.secret_key = config.SECRET_KEY
app.config['UPLOAD_FOLDER'] = config.UPLOAD_FOLDER

# Pastikan folder upload benar-benar ada saat aplikasi start
if not os.path.exists(app.config['UPLOAD_FOLDER']):
    os.makedirs(app.config['UPLOAD_FOLDER'])

# --- FUNGSI BANTUAN ---

def get_db():
    return mysql.connector.connect(**config.DB_CONFIG)

def allowed_file(filename, allowed_types):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in allowed_types

# --- ROUTE KHUSUS DOWNLOAD FILE (FIXED) ---
@app.route('/download/file/<filename>')
def download_file(filename):
    try:
        # Cek apakah file benar-benar ada di folder sebelum dikirim
        safe_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        
        if os.path.exists(safe_path):
            # as_attachment=True MEMAKSA browser untuk "Save As" / Download
            # bukan membuka preview PDF di tab baru
            return send_from_directory(
                app.config['UPLOAD_FOLDER'], 
                filename, 
                as_attachment=True
            )
        else:
            return "File tidak ditemukan di server.", 404
    except Exception as e:
        return f"Terjadi kesalahan saat mengunduh: {str(e)}", 500

# --- ROUTES PUBLIK ---

@app.route('/')
def index():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM sliders")
    sliders = cursor.fetchall()
    cursor.execute("SELECT * FROM news ORDER BY created_at DESC LIMIT 3")
    news = cursor.fetchall()
    
    # Ambil Data WBP
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

@app.route('/layanan')
def layanan():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM services")
    services = cursor.fetchall()
    conn.close()
    return render_template('layanan.html', services=services)

# --- ROUTE PUBLIC LITMAS ---
@app.route('/layanan/litmas')
def layanan_litmas():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM litmas_data ORDER BY id DESC")
    data_litmas = cursor.fetchall()
    conn.close()
    return render_template('layanan_litmas.html', data=data_litmas)

# --- ROUTE DOWNLOAD EXCEL LITMAS ---
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
    
    return send_file(
        output,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        as_attachment=True,
        download_name=f'Data_Litmas_{datetime.now().strftime("%Y%m%d")}.xlsx'
    )

# --- ROUTE PUBLIC WBP BEBAS ---
@app.route('/layanan/bebas')
def layanan_bebas():
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM wbp_bebas ORDER BY tgl_ekspirasi ASC")
    data_bebas = cursor.fetchall()
    conn.close()
    return render_template('layanan_bebas.html', data=data_bebas)

# --- ROUTE DOWNLOAD EXCEL BEBAS ---
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
    
    return send_file(
        output,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        as_attachment=True,
        download_name=f'Data_WBP_Bebas_{datetime.now().strftime("%Y%m%d")}.xlsx'
    )

# ---------------------------------------------------------

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
    if not news_item:
        return "Berita tidak ditemukan", 404
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

# --- ROUTES ADMIN & LOGIN ---

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

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/admin')
def admin_dashboard():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    stats = {}
    tables = ['news', 'messages', 'services', 'gallery', 'profiles', 'users']
    for t in tables:
        try:
            cursor.execute(f"SELECT COUNT(*) as count FROM {t}")
            stats[t] = cursor.fetchone()['count']
        except:
            stats[t] = 0
            
    # Ambil data WBP
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

# --- ADMIN KELOLA LITMAS (CRUD) ---
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
    conn = get_db()
    cursor = conn.cursor()
    
    nama = request.form['nama']
    tahun = request.form['tahun']
    bulan = request.form['bulan']
    denda = request.form['denda']
    subs = request.form['subs']
    
    cursor.execute("INSERT INTO litmas_data (nama_wbp, pidana_tahun, pidana_bulan, besaran_denda, subs_bulan) VALUES (%s, %s, %s, %s, %s)",
                   (nama, tahun, bulan, denda, subs))
    conn.commit()
    conn.close()
    flash('Data Usul Litmas berhasil ditambahkan', 'success')
    return redirect(url_for('admin_litmas'))

@app.route('/admin/litmas/update', methods=['POST'])
def admin_litmas_update():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    
    id_data = request.form['id']
    nama = request.form['nama']
    tahun = request.form['tahun']
    bulan = request.form['bulan']
    denda = request.form['denda']
    subs = request.form['subs']
    
    cursor.execute("UPDATE litmas_data SET nama_wbp=%s, pidana_tahun=%s, pidana_bulan=%s, besaran_denda=%s, subs_bulan=%s WHERE id=%s",
                   (nama, tahun, bulan, denda, subs, id_data))
    conn.commit()
    conn.close()
    flash('Data berhasil diperbarui', 'success')
    return redirect(url_for('admin_litmas'))

@app.route('/admin/litmas/delete/<int:id>')
def admin_litmas_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM litmas_data WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    flash('Data berhasil dihapus', 'warning')
    return redirect(url_for('admin_litmas'))

# --- ADMIN KELOLA WBP BEBAS (CRUD) ---
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
    conn = get_db()
    cursor = conn.cursor()
    
    nama = request.form['nama']
    tgl = request.form['tgl']
    ket = request.form['ket']
    
    cursor.execute("INSERT INTO wbp_bebas (nama_wbp, tgl_ekspirasi, keterangan) VALUES (%s, %s, %s)",
                   (nama, tgl, ket))
    conn.commit()
    conn.close()
    flash('Data WBP Bebas berhasil ditambahkan', 'success')
    return redirect(url_for('admin_bebas'))

@app.route('/admin/bebas/update', methods=['POST'])
def admin_bebas_update():
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    
    id_data = request.form['id']
    nama = request.form['nama']
    tgl = request.form['tgl']
    ket = request.form['ket']
    
    cursor.execute("UPDATE wbp_bebas SET nama_wbp=%s, tgl_ekspirasi=%s, keterangan=%s WHERE id=%s",
                   (nama, tgl, ket, id_data))
    conn.commit()
    conn.close()
    flash('Data berhasil diperbarui', 'success')
    return redirect(url_for('admin_bebas'))

@app.route('/admin/bebas/delete/<int:id>')
def admin_bebas_delete(id):
    if 'user' not in session: return redirect(url_for('login'))
    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM wbp_bebas WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    flash('Data berhasil dihapus', 'warning')
    return redirect(url_for('admin_bebas'))

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
    flash('Admin baru berhasil ditambahkan', 'success')
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
            if session['user'] == old_data['username']:
                session['user_image'] = filename
    if new_password:
        cursor.execute("UPDATE users SET username=%s, password=%s, image=%s WHERE id=%s", (username, new_password, filename, user_id))
    else:
        cursor.execute("UPDATE users SET username=%s, image=%s WHERE id=%s", (username, filename, user_id))
    conn.commit()
    conn.close()
    flash('Data Admin berhasil diperbarui', 'success')
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
        flash('Tidak bisa menghapus akun yang sedang digunakan!', 'danger')
        return redirect(url_for('admin_users'))
    if user and user['image']:
        try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], user['image']))
        except: pass
    cursor.execute("DELETE FROM users WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    flash('Admin berhasil dihapus', 'warning')
    return redirect(url_for('admin_users'))

@app.route('/admin/<category>', methods=['GET'])
def admin_list(category):
    if 'user' not in session: return redirect(url_for('login'))
    table_map = {'berita': 'news', 'layanan': 'services', 'galeri': 'gallery', 'slider': 'sliders', 'pesan': 'messages', 'profil': 'profiles'}
    if category not in table_map: return "Kategori tidak ditemukan"
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    if category == 'profil':
        cursor.execute("SELECT * FROM profiles ORDER BY section_type")
    elif category == 'pesan':
        cursor.execute("SELECT * FROM messages ORDER BY created_at DESC")
    else:
        cursor.execute(f"SELECT * FROM {table_map[category]} ORDER BY id DESC")
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
            elif file.filename != '':
                flash('Format file harus PDF!', 'danger')
                return redirect(url_for('admin_list', category=category))
        else:
            if file and allowed_file(file.filename, config.IMG_EXTENSIONS):
                filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
                file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    if category == 'berita':
        city = request.form.get('city')
        content = request.form['content']
        manual_author = request.form['author']
        if city: content = f"<strong>{city}</strong> — {content}"
        cursor.execute("INSERT INTO news (title, content, author, image) VALUES (%s, %s, %s, %s)", (request.form['title'], content, manual_author, filename))
    elif category == 'layanan':
        cursor.execute("INSERT INTO services (title, description, file) VALUES (%s, %s, %s)", (request.form['title'], request.form['description'], filename))
    elif category == 'galeri':
        cursor.execute("INSERT INTO gallery (title, image) VALUES (%s, %s)", (request.form['title'], filename))
    elif category == 'slider':
        cursor.execute("INSERT INTO sliders (title, link, image) VALUES (%s, %s, %s)", (request.form['title'], request.form.get('link', '#'), filename))
    elif category == 'profil':
        cursor.execute("INSERT INTO profiles (section_type, title, content, image) VALUES ('point', %s, %s, %s)", (request.form['title'], request.form['content'], filename))
    conn.commit()
    conn.close()
    flash('Data berhasil ditambahkan', 'success')
    return redirect(url_for('admin_list', category=category))

@app.route('/admin/<category>/update', methods=['POST'])
def admin_update(category):
    if 'user' not in session: return redirect(url_for('login'))
    data_id = request.form['id']
    title = request.form['title']
    content = request.form.get('content') or request.form.get('description')
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    table_map = {'berita': 'news', 'layanan': 'services', 'galeri': 'gallery', 'slider': 'sliders', 'profil': 'profiles'}
    table = table_map.get(category)
    cursor.execute(f"SELECT * FROM {table} WHERE id=%s", (data_id,))
    old_data = cursor.fetchone()
    if not old_data:
        conn.close()
        return "Data not found"
    filename = None
    file_column = 'file' if category == 'layanan' else 'image'
    if 'image' in request.files:
        file = request.files['image']
        allowed = config.DOC_EXTENSIONS if category == 'layanan' else config.IMG_EXTENSIONS
        if file and allowed_file(file.filename, allowed):
            old_file = old_data.get(file_column)
            if old_file:
                try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], old_file))
                except: pass
            filename = secure_filename(datetime.now().strftime("%Y%m%d%H%M%S") + "_" + file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        else:
            filename = old_data.get(file_column)
    else:
        filename = old_data.get(file_column)
    if category == 'berita':
        manual_author = request.form['author']
        cursor.execute("UPDATE news SET title=%s, content=%s, author=%s, image=%s WHERE id=%s", (title, content, manual_author, filename, data_id))
    elif category == 'layanan':
        cursor.execute("UPDATE services SET title=%s, description=%s, file=%s WHERE id=%s", (title, content, filename, data_id))
    elif category == 'galeri':
        cursor.execute("UPDATE gallery SET title=%s, image=%s WHERE id=%s", (title, filename, data_id))
    elif category == 'slider':
        link = request.form.get('link', '#')
        cursor.execute("UPDATE sliders SET title=%s, link=%s, image=%s WHERE id=%s", (title, link, filename, data_id))
    elif category == 'profil':
        cursor.execute("UPDATE profiles SET title=%s, content=%s, image=%s WHERE id=%s", (title, content, filename, data_id))
    conn.commit()
    conn.close()
    flash('Data berhasil diperbarui', 'success')
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
        file_to_delete = None
        if category == 'layanan': file_to_delete = item.get('file')
        elif category in ['berita', 'galeri', 'slider', 'profil']: file_to_delete = item.get('image')
        if file_to_delete:
            try: os.remove(os.path.join(app.config['UPLOAD_FOLDER'], file_to_delete))
            except: pass 
    cursor.execute(f"DELETE FROM {table_map[category]} WHERE id=%s", (id,))
    conn.commit()
    conn.close()
    flash('Data berhasil dihapus', 'warning')
    return redirect(url_for('admin_list', category=category))

if __name__ == '__main__':
    app.run(debug=True)
