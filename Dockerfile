# 1. Gunakan sistem operasi Linux Alpine yang sangat ringan dan sudah terinstal Node.js versi 20
FROM node:20-alpine

# 2. Instal manajer paket pnpm secara global di dalam kontainer
RUN npm install -g pnpm

# 3. Tetapkan folder /app sebagai ruang kerja di dalam kontainer
WORKDIR /app

# 4. Salin fail daftar pustaka bawaan asisten terlebih dahulu
COPY package.json pnpm-lock.yaml* ./

# 5. KUNCI UTAMA: Paksa pnpm meloloskan msw dan sharp sebelum instalasi dimulai
RUN pnpm config set only-built-dependencies msw,sharp

# 6. Eksekusi instalasi pustaka
RUN pnpm install

# 7. Salin seluruh sisa kode sumber (komponen, halaman web, dll) ke dalam kontainer
COPY . .

# 8. Kompilasi aplikasi Next.js menjadi versi produksi yang siap tayang
RUN pnpm run build

# 9. Buka gerbang port (Cloud Run akan otomatis mengarahkan lalu lintas ke port ini)
EXPOSE 8080

# 10. Perintah wajib untuk menyalakan peladen web saat kontainer hidup
CMD ["pnpm", "start"]