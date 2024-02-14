# Resmi nginx imajını temel al
FROM nginx:alpine

# Çalışma dizinini belirt
WORKDIR /usr/share/nginx/html

# wget paketini yükle
RUN apk add --no-cache wget

# index.html dosyasını GitHub deposundan al
RUN wget https://raw.githubusercontent.com/uguroral/app1/main/index.html

# 80 numaralı portu aç
EXPOSE 80