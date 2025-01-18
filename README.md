# API Testing Framework

Este proyecto implementa un framework de pruebas de API utilizando Postman, Newman, Allure Reports, y Docker, con integración continua en CircleCI.
Tecnologías Utilizadas

Visual Studio Code
Postman
Newman
Allure Reports
Docker
CircleCI

Prerrequisitos

Node.js
Docker
Java JDK 11 (para Allure)
Git

Estructura del Proyecto
Copy├── JSONPlaceholder-CRUD.postman_collection.json
├── package.json
├── Dockerfile
├── .circleci/
│   └── config.yml
├── allure-results/
└── allure-report/
Configuración Inicial

Clonar el repositorio:

cd <"nombre-directorio">

Instalar dependencias:

bashCopynpm install
Comandos Principales
Ejecutar Pruebas Localmente
bashCopy# Ejecutar pruebas con Newman y generar reporte Allure
npm test

### Generar y abrir reporte Allure

npm run report
Ejecutar Pruebas con Docker
bashCopy# Construir imagen Docker
docker build -t api-tests .

### Ejecutar pruebas en Docker

docker run api-tests

## Ejecutar pruebas y conservar resultados Allure

docker run -v $(pwd)/allure-results:/app/allure-results api-tests
Configuración de CircleCI

Ir a CircleCI
Conectar tu repositorio de GitHub
Seleccionar el proyecto
CircleCI detectará automáticamente el archivo de configuración en .circleci/config.yml

Detalles de Configuración
package.json
jsonCopy{
  "scripts": {
    "test": "newman run JSONPlaceholder-CRUD.postman_collection.json -r cli,allure --reporter-allure-export allure-results",
    "report": "allure generate allure-results --clean && allure open"
  }
}
Dockerfile
dockerfileCopyFROM node:16-alpine
RUN apk add --no-cache openjdk11-jre
WORKDIR /app
COPY package*.json ./
COPY JSONPlaceholder-CRUD.postman_collection.json ./
RUN npm install -g newman allure-commandline
RUN npm install
RUN mkdir -p allure-results
CMD ["npm", "test"]
Reportes

Los reportes de Allure se generan en el directorio allure-results/
Para ver el reporte: npm run report
En CircleCI, los reportes están disponibles como artefactos en la interfaz web

Enlaces Útiles

Documentación de Newman
Documentación de Allure
Documentación de CircleCI

Notas Adicionales

Asegúrate de tener Java instalado para ejecutar Allure Reports
Los resultados de las pruebas en Docker se pueden persistir usando volúmenes
CircleCI guarda los reportes como artefactos después de cada ejecución