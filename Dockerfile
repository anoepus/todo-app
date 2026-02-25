#Maven Build
FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY pom.xml .
#Bruges til at cache dependencies til næste build
RUN mvn dependency:go-offline -B
COPY src ./src
# Bruger maven til at bygge snapshot, og skipper tests, da der testes i CI inden build og deploy!
RUN mvn clean package -DskipTests -B

#Java Runtime image (opsætter runtime til at køre snapshot lavet af maven)
FROM eclipse-temurin:25-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=15s \
  CMD curl -f http://localhost:8080/actuator/health || exit 1
ENTRYPOINT ["java", "-jar", "app.jar"]
