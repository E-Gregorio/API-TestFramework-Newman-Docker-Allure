API Testing Framework
Este proyecto implementa un framework de pruebas de API utilizando Postman, Newman, Allure Reports y Docker, con integración continua en CircleCI. El framework está diseñado para ejecutar pruebas de API tanto localmente como en un entorno de CI/CD, garantizando la consistencia de los resultados en diferentes ambientes.
Tecnologías Utilizadas

Visual Studio Code
Postman (para diseño de pruebas)
Newman (ejecutor de colecciones Postman)
Allure Reports (reportería detallada)
Docker (containerización)
CircleCI (integración continua)

Prerrequisitos

Node.js (v16 o superior)
Docker Desktop
Java JDK 11 (requerido para Allure Reports)
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

bashCopygit clone <url-repositorio>
cd JasonPlaceholderCrud

Instalar dependencias:

bashCopynpm install
Ejecución de Pruebas
Localmente con Newman

Ejecutar pruebas y generar reporte:

bashCopynpm run test:report

Ver el reporte generado:

bashCopynpm run report:open
Usando Docker

Construir la imagen:

bashCopydocker build -t api-tests .

Ejecutar pruebas en Docker:

bashCopy# Ejecutar pruebas y mantener resultados de Allure
docker run -v $(pwd)/allure-results:/app/allure-results api-tests
En Pipeline de CI/CD
Las pruebas se ejecutan automáticamente en CircleCI después de cada push al repositorio. Los reportes de Allure están disponibles como artefactos en la interfaz de CircleCI.
Archivos de Configuración
package.json
jsonCopy{
  "scripts": {
    "test": "newman run JSONPlaceholder-CRUD.postman_collection.json -r cli,allure --reporter-allure-export=allure-results",
    "report:clean": "rimraf allure-report/ allure-results/",
    "report:generate": "allure generate --clean",
    "report:open": "allure open",
    "test:report": "npm run report:clean && npm test && npm run report:generate"
  }
}
Dockerfile
dockerfileCopyFROM node:16-alpine

RUN apk add --no-cache openjdk11-jre

WORKDIR /app

COPY package*.json ./
COPY JSONPlaceholder-CRUD.postman_collection.json ./

RUN npm install -g newman allure-commandline && \
    npm install && \
    mkdir -p allure-results

CMD ["npm", "test"]
CircleCI (config.yml)
El pipeline está configurado para:

Instalar dependencias necesarias
Ejecutar las pruebas usando Newman
Generar reportes de Allure
Almacenar los resultados como artefactos

Reportes
Los reportes de Allure se generan en dos ubicaciones:

allure-results/: Contiene los resultados crudos de las pruebas
allure-report/: Contiene el reporte HTML generado

Para ver el reporte después de ejecutar las pruebas:
bashCopynpm run report:open
Ventajas del Framework

Consistencia: Las pruebas se ejecutan en un entorno containerizado, garantizando resultados consistentes independientemente del ambiente.
Automatización: Integración completa con CI/CD para ejecución automática de pruebas.
Reportería: Reportes detallados con Allure que incluyen:

Resultados de pruebas
Tiempos de ejecución
Detalles de fallos
Estadísticas



Enlaces Útiles

Documentación de Newman
Documentación de Allure
Documentación de CircleCI

Notas Importantes

Asegúrese de tener Java JDK 11 instalado para la generación de reportes Allure
Los resultados de las pruebas en Docker se persisten usando volúmenes
Los reportes están disponibles como artefactos en CircleCI después de cada ejecución
Para modificar las pruebas, edite la colección Postman y actualice el archivo JSON en el repositorio

comandos utilizados en el proyecto, paso a paso:

Crear y configurar el repositorio:

bashCopy# Crear directorio del proyecto
mkdir JasonPlaceholderCrud
cd JasonPlaceholderCrud

# Inicializar repositorio git
git init

# Crear archivo .gitignore
echo "node_modules/" > .gitignore
echo "allure-report/" >> .gitignore
echo "allure-results/" >> .gitignore

Inicializar proyecto Node.js y instalar dependencias:

bashCopy# Inicializar proyecto npm
npm init -y

# Instalar dependencias
npm install --save-dev newman
npm install --save-dev newman-reporter-allure
npm install --save-dev allure-commandline
npm install --save-dev rimraf

Ejecutar pruebas con Newman localmente:

bashCopy# Ejecutar colección y generar reporte
npm run test:report

# Limpiar reportes anteriores
npm run report:clean

# Generar reporte Allure
npm run report:generate

# Abrir reporte en el navegador
npm run report:open

Comandos Docker:

bashCopy# Construir imagen Docker
docker build -t api-tests .

# Ejecutar pruebas en Docker
docker run api-tests

# Ejecutar pruebas manteniendo resultados Allure
docker run -v $(pwd)/allure-results:/app/allure-results api-tests

Comandos Git para subir cambios:

bashCopy# Agregar repositorio remoto
git remote add origin https://github.com/tuusuario/JasonPlaceholderCrud.git

# Verificar estado de archivos
git status

# Agregar todos los archivos
git add .

# Crear commit
git commit -m "Configuración inicial del proyecto de pruebas API"

# Subir cambios a GitHub
git push -u origin master

Comandos para actualizar cambios:

bashCopy# Verificar cambios
git status

# Agregar cambios
git add .

# Crear nuevo commit
git commit -m "Actualización de pruebas y configuración"

# Subir cambios
git push origin master

Comandos para verificar configuración:

bashCopy# Verificar configuración de git
git config --list

# Verificar ramas
git branch

# Verificar remotes
git remote -v

Comandos para ver logs y historial:

bashCopy# Ver historial de commits
git log

# Ver historial simplificado
git log --oneline

# Ver cambios específicos
git show
Esta secuencia de comandos representa el flujo completo desde la creación del proyecto hasta la ejecución de pruebas y su integración con CircleCI