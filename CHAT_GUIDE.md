# DEGENI Chat - Cara Menggunakan

## Masalah yang Diperbaiki
Chat DEGENI sekarang sudah berfungsi dengan baik setelah perbaikan konfigurasi.

## Cara Menggunakan Chat

### 1. Menggunakan Command Degeni
```bash
cd /home/himy/DEGENI
./bin/degeni chat
```

### 2. Menggunakan Script Chat Langsung
```bash
/home/himy/DEGENI/bin/degeni-chat
```

### 3. Menggunakan Alias (setelah restart terminal)
```bash
degeni-chat
```

## Fitur Chat
- Interactive chat dengan Claude AI
- Model: gemini-claude-sonnet-4-5-thinking
- Auto-recovery untuk auth errors
- Terintegrasi dengan proxy server lokal

## Troubleshooting
Jika chat tidak berfungsi:
1. Pastikan proxy server berjalan: `degeni status`
2. Restart proxy jika perlu: `degeni restart`
3. Periksa akun tersedia: buka dashboard di browser

## Dashboard Web
Akses dashboard di: http://localhost:8321/ui/dashboard.html
- Monitor status sistem
- Kelola akun AI
- Lihat logs
- Switch model

Chat sudah siap digunakan! 🚀
