# --- Tahap 1: Build ---
# Menggunakan image Go versi 1.22 yang berbasis Alpine sebagai builder.
# Alpine dipilih karena ukurannya yang kecil.
FROM golang:1.24-alpine AS builder

# Menentukan direktori kerja di dalam container.
WORKDIR /app

# Menyalin semua file dari direktori lokal ke direktori kerja di container.
# Untuk proyek sederhana, ini sudah cukup.
COPY . .

# Menjalankan perintah build Go.
# CGO_ENABLED=0 diperlukan untuk membuat biner statis tanpa dependensi C.
# -o main menentukan nama file output menjadi 'main'.
RUN CGO_ENABLED=0 go build -o main .

# --- Tahap 2: Final Image ---
# Memulai dari image 'scratch', yang merupakan image paling minimal (kosong).
# Ini sangat aman dan efisien karena tidak ada shell atau tool lain.
FROM scratch

# Menentukan direktori kerja.
WORKDIR /app

# Menyalin *hanya* biner 'main' yang sudah di-build dari tahap 'builder'.
COPY --from=builder /app/main .

# Memberi tahu Docker bahwa container akan mendengarkan di port 8080.
EXPOSE 8080

# Perintah default yang akan dijalankan saat container dimulai.
ENTRYPOINT ["/app/main"]
