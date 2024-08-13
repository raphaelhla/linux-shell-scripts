# Configuração de Certificado SSL para HTTPS em Domínios Próprios com Nginx na AWS

Este guia descreve como configurar um certificado SSL em uma instância EC2 da AWS usando Nginx e Let's Encrypt. Isso habilitará HTTPS em seu domínio personalizado.

## Pré-requisitos

- Uma instância EC2 em execução.
- Um domínio próprio apontando para o IP da instância EC2.
- Acesso SSH à instância EC2.

## 1. Acessar a Instância EC2

Faça login na sua instância EC2 via SSH:

```bash
ssh -i /caminho/para/sua-chave.pem usuario@seu-endereco-ip
```

## 2. Instalar o Certbot

Atualize os pacotes e instale o Certbot, que será usado para gerar certificados SSL:

```bash
sudo apt update
sudo apt install certbot
```

Abra a porta 80 no firewall para permitir que o Certbot faça o desafio de validação HTTP:

```bash
sudo ufw allow 80
```

## 3. Gerar Certificado SSL com Let's Encrypt

Gere o certificado SSL usando o Certbot. Substitua `seudominio.com.br` pelo seu domínio:

```bash
sudo certbot certonly --standalone --preferred-challenges http -d seudominio.com.br
```

> **Nota:** O Certbot irá gerar os certificados SSL e armazená-los no diretório `/etc/letsencrypt/live/seudominio.com.br/`.

## 4. Configurar Nginx

### 4.1 Criar Diretório para Configurações do Nginx

Crie um diretório para armazenar o Dockerfile e as configurações do Nginx:

```bash
mkdir ~/nginx
cd ~/nginx
```

### 4.2 Criar Dockerfile para o Nginx

Crie um `Dockerfile` que será usado para construir a imagem do Nginx:

```bash
cat <<EOF > Dockerfile
FROM nginx:alpine
EXPOSE 80
EXPOSE 443 # Linha gerada pelo ChatGPT
COPY fullchain.pem /etc/nginx/certs/fullchain.pem
COPY privkey.pem /etc/nginx/certs/privkey.pem
COPY nginx.conf /etc/nginx/nginx.conf
EOF
```

### 4.3 Criar Arquivo de Configuração do Nginx

Crie um arquivo `nginx.conf` para configurar o Nginx. Substitua `seudominio.com.br` pelo seu domínio e ajuste o `proxy_pass` de acordo com o endereço de sua API:

```bash
cat <<EOF > nginx.conf
worker_processes 1;
events {worker_connections 1024;}

http {
  sendfile on;

  server {
    listen 80;
    listen [::]:80;

    server_tokens off;

    location /.well-known/acme-challenge/ {
        root /var/www/certbot;
    }

    location / {
        return 301 https://seudominio.com.br$request_uri;
    }
  }

  server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name seudominio.com.br;

    ssl_certificate /etc/nginx/certs/fullchain.pem;
    ssl_certificate_key /etc/nginx/certs/privkey.pem;

    location / {
        proxy_pass https://accbank-api:8443; # Substitua pelo endereço da sua API
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}
EOF
```

### 4.4 Copiar Certificados para o Diretório do Nginx

Copie os certificados gerados para o diretório `~/nginx`:

```bash
sudo cp /etc/letsencrypt/live/seudominio.com.br/fullchain.pem ~/nginx/
sudo cp /etc/letsencrypt/live/seudominio.com.br/privkey.pem ~/nginx/
sudo chmod 644 ~/nginx/privkey.pem
```

## 5. Configurar Docker Compose

Adicione o serviço Nginx ao seu arquivo `docker-compose.yaml`. A configuração mínima para o Nginx deve ser a seguinte:

```yaml
services:
  nginx:
    container_name: nginx
    build:
      context: ./nginx
    ports:
      - '80:80'
      - '443:443'
    restart: unless-stopped
    networks:
      - sua-rede
```

> **Nota:** Certifique-se de que o `docker-compose.yaml` está na raiz do projeto e que a rede `sua-rede` esteja configurada corretamente.

## 6. Configurar DNS do Domínio

No provedor onde o domínio está registrado, adicione um registro DNS do tipo `A` apontando para o endereço IPv4 público da sua instância EC2:

- **Tipo:** A
- **Nome:** `@` ou `www` (dependendo do provedor)
- **Valor:** `IP público da sua instância EC2`

## 7. Reiniciar os Serviços

Finalmente, reinicie os serviços Docker para aplicar as configurações:

```bash
docker-compose up -d
```
