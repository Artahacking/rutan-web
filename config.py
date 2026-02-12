import os

# --- KONFIGURASI DATABASE ---
# Menggunakan os.getenv:
# Jika ada settingan dari Docker (Environment Variable), pakai itu.
# Jika tidak ada (Localhost), pakai default value di parameter kedua.

DB_CONFIG = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', ''), # Kosong jika di XAMPP, tapi di Docker nanti kita set
    'database': os.getenv('DB_NAME', 'rutan_db')
}

# --- KONFIGURASI APLIKASI ---
SECRET_KEY = os.getenv('SECRET_KEY', 'kunci_rahasia_rutan_makassar')
RECOVERY_CODE = 'rutan_pangkalan_brandan'

# --- KONFIGURASI UPLOAD ---
UPLOAD_FOLDER = 'static/uploads'
IMG_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
DOC_EXTENSIONS = {'pdf'}