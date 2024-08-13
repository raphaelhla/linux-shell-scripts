# Habilitar Https na API Spring Boot

## Gerar certificado autoassinado para a API
1. Gere o certificado autoassinado:
    ```
    keytool -genkeypair -alias tomcat -keyalg RSA -keysize 2048 -storetype PKCS12 -keystore keystore.p12 -validity 3650
    ```
2. Mova ele para `src/main/resources/keystore`
3. Crie o `application-prod.properties` e adicione as propriedades:
    ```
    server.port=8443
    #security.require-ssl=true 
    server.ssl.key-store-type=PKCS12
    server.ssl.key-store=classpath:keystore/keystore.p12
    server.ssl.key-store-password=raphael
    server.ssl.key-alias=tomcat
    ```
4. Crie a classe `ConnectorConfig`:
    ```java
    package com.accenture.academico.Acc.Bank.config;
    
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
5. Agora sua aplicação está acessível via `https://localhost:8443`    

## References

https://stackoverflow.com/questions/51177317/client-certificate-authentication-with-spring-boot
https://www.baeldung.com/spring-boot-https-self-signed-certificate
