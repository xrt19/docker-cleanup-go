// main.go
// Ini adalah aplikasi web server sederhana menggunakan Go.

package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	// Menampilkan pesan bahwa server sedang berjalan.
	fmt.Println("Server akan berjalan di port 8080...")
	fmt.Println("tes pembeda senin 30 juni 2025 jam 09.54")

	// Menangani permintaan ke path root "/"
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Mendapatkan hostname dari mesin untuk menunjukkan container mana yang merespons.
		hostname, err := os.Hostname()
		if err != nil {
			hostname = "tidak diketahui"
		}
		// Menulis respons ke klien.
		fmt.Fprintf(w, "Halo Dunia dari Go! Server ini berjalan di container: %s", hostname)
	})

	// Mulai mendengarkan koneksi di port 8080.
	// Jika ada error (misalnya port sudah digunakan), program akan berhenti.
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Printf("Gagal memulai server: %s\n", err)
		os.Exit(1)
	}
}
