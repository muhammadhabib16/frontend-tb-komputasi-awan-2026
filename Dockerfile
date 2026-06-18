# 1. Menggunakan basis sistem operasi Linux Alpine yang ringan dengan Node.js 20
FROM node:20-alpine

# 2. Menentukan folder internal kontainer sebagai ruang eksekusi
WORKDIR /app

# 3. Menyalin deskriptor pustaka proyek
COPY package.json package-lock.json* ./

# 4. Mengeksekusi instalasi seluruh dependensi menggunakan NPM murni
RUN npm install

# 5. Menyalin sisa seluruh kode sumber aplikasi ke dalam kontainer
COPY . .

# 6. Melakukan kompilasi Next.js menjadi kode siap tayang (kinerja produksi)
RUN npm run build

# 7. Membuka gerbang port standar yang diminta oleh Google Cloud Run
ENV PORT=8080
EXPOSE 8080

# 8. Menyalakan server Next.js saat kontainer diaktifkan
CMD ["npm", "start"]