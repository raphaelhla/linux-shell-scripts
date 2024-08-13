# Habilitar HTTPS na API Spring Boot

Este guia descreve como habilitar HTTPS em uma aplicação Spring Boot usando um certificado autoassinado.

## 1. Gerar um Certificado Autoassinado

Para gerar um certificado autoassinado, execute o seguinte comando. Substitua os valores conforme necessário:

```bash
keytool -genkeypair -alias tomcat -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore keystore.p12 -validity 3650
```

Este comando cria um arquivo `keystore.p12` no diretório atual.

### 1.1 Mover o Certificado

Após gerar o certificado, mova o arquivo `keystore.p12` para o diretório `src/main/resources/keystore` do seu projeto:

```bash
mv keystore.p12 src/main/resources/keystore/
```

## 2. Configurar a Aplicação para HTTPS

### 2.1 Configurar o Arquivo de Propriedades

Crie um arquivo `application-prod.properties` na pasta `src/main/resources/` (ou edite um existente) e adicione as seguintes propriedades para configurar o HTTPS:

```properties
server.port=8443
server.ssl.key-store-type=PKCS12
server.ssl.key-store=classpath:keystore/keystore.p12
server.ssl.key-store-password=sua-senha-do-certificado
server.ssl.key-alias=tomcat
```

### 2.2 Configurar Redirecionamento de HTTP para HTTPS

Crie uma classe de configuração `ConnectorConfig` para redirecionar automaticamente todas as requisições HTTP para HTTPS:

```java
import org.apache.catalina.Context;
import org.apache.catalina.connector.Connector;
import org.apache.tomcat.util.descriptor.web.SecurityCollection;
import org.apache.tomcat.util.descriptor.web.SecurityConstraint;
import org.springframework.boot.web.embedded.tomcat.TomcatServletWebServerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;

@Configuration
@Profile("prod")
public class ConnectorConfig {

    @Bean
    public TomcatServletWebServerFactory servletContainer() {
        TomcatServletWebServerFactory tomcat = new TomcatServletWebServerFactory() {
            @Override
            protected void postProcessContext(Context context) {
                SecurityConstraint securityConstraint = new SecurityConstraint();
                securityConstraint.setUserConstraint("CONFIDENTIAL");
                SecurityCollection collection = new SecurityCollection();
                collection.addPattern("/*");
                securityConstraint.addCollection(collection);
                context.addConstraint(securityConstraint);
            }
        };
        tomcat.addAdditionalTomcatConnectors(getHttpConnector());
        return tomcat;
    }

    private Connector getHttpConnector() {
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setScheme("http");
        connector.setPort(8080);
        connector.setSecure(false);
        connector.setRedirectPort(8443);
        return connector;
    }
}
```

Esta configuração cria um conector HTTP na porta 8080 que redireciona as solicitações para a porta HTTPS (8443).

## 3. Testar a Configuração

Inicie a aplicação e acesse a URL `https://localhost:8443`. Sua aplicação Spring Boot agora deve estar acessível via HTTPS.

## Referências

- [Autenticação de Certificado do Cliente com Spring Boot](https://stackoverflow.com/questions/51177317/client-certificate-authentication-with-spring-boot)
- [Baeldung - Spring Boot e Certificados Autoassinados](https://www.baeldung.com/spring-boot-https-self-signed-certificate)
