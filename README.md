Example of nextjs project using Cypress.io

<!---Start place for the badge -->
[![Cypress.io](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)](https://www.cypress.io/)

<!---End place for the badge -->

RESULTADOS DE LOS ÚLTIMOS TESTS
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)
![Cypress test badge](https://img.shields.io/badge/test-failure-red)

# Proyecto: Workflow con GitHub Actions

## Índice
1. [Introducción](#introducción)  
   1.1. [GitHub Actions](#github-actions)  
2. [Información teórica adicional](#información-teórica-adicional)  
   2.1. [Linter](#linter)  
   2.2. [Cypress](#cypress)  
   2.3. [Vercel](#vercel)  
   2.4. [Badges](#badges)  
   2.5. [Artefactos](#artefactos)  
   2.6. [Métricas](#métricas)  
3. [Objetivos del proyecto](#objetivos-del-proyecto)  
4. [Configuración del Workflow](#configuración-del-workflow)  
   4.1. [Linter_job](#linter-job)  
   4.2. [Cypress_job](#cypress-job)  
   4.3. [Add_badge_job](#add_badge_job)  
   4.4. [Deploy_job](#deploy_job)  
   4.5. [Notification_job](#notification_job)  
5. [Configuración de Métricas en el Perfil de GitHub](#configuración-de-métricas-en-el-perfil-de-github)

---

## Introducción

En este proyecto, hemos implementado un workflow completo utilizando **GitHub Actions**, una herramienta de integración y despliegue continuo (CI/CD). 

### GitHub Actions

Las **GitHub Actions** son una funcionalidad de GitHub que permite automatizar flujos de trabajo para el desarrollo de software. Con ellas podemos:
- Automatizar procesos como testing, análisis de código, despliegues, etc.
- Definir "workflows" que se ejecutan en respuesta a eventos como pushes, pull requests o eventos programados.
- Utilizar un ecosistema amplio de **actions** predefinidas o crear nuestras propias.

---

## Información teórica adicional

### **Linter**
Un **linter** es una herramienta que analiza el código fuente para identificar errores de sintaxis, inconsistencias o prácticas poco recomendadas. Esto ayuda a mantener el código legible, limpio y coherente.

- **Objetivo:** Garantizar que el código cumple con los estándares de calidad.
- **Beneficios:** Reduce los errores a largo plazo y ayuda a mejorar la mantenibilidad del código.

---

### **Cypress**
**Cypress** es una herramienta de testing end-to-end que permite verificar el comportamiento completo de una aplicación web desde el punto de vista del usuario. Es ampliamente utilizada para asegurar que las funcionalidades implementadas funcionan correctamente.

- **Objetivo:** Automatizar pruebas que reproduzcan la experiencia del usuario.
- **Beneficios:** Mejora la calidad del código y reduce la posibilidad de introducir regresiones.

---

### **Vercel**
**Vercel** es una plataforma de despliegue diseñada para aplicaciones web modernas. Ofrece una solución sencilla y eficiente para desplegar aplicaciones basadas en frameworks populares y con necesidades específicas de rendimiento.

- **Objetivo:** Permitir el despliegue rápido y fiable de aplicaciones.
- **Beneficios:** Facilidad de uso, compatibilidad con herramientas modernas y funcionalidades avanzadas como caché automática.

---

### **Badges**
Los **badges** son elementos visuales que muestran información sobre el estado de un proyecto, como el éxito de pruebas, la cobertura de código o versiones actuales. Se utilizan para proporcionar información relevante de un vistazo.

- **Objetivo:** Hacer visibles detalles clave del proyecto de manera rápida.
- **Beneficios:** Transparencia y comunicación visual del estado del proyecto.

---

### **Artefactos**
Los **artefactos** son archivos generados durante la ejecución de un workflow que se pueden almacenar y reutilizar posteriormente. Son útiles para compartir datos entre jobs de un mismo workflow o para analizar resultados.

- **Objetivo:** Facilitar la persistencia y reutilización de datos generados.
- **Beneficios:** Simplifican los procesos entre jobs y mejoran la trazabilidad de los resultados.

---

### **Métricas**
Las **métricas** son datos analíticos que proporcionan información sobre la actividad y las contribuciones en un repositorio o perfil de GitHub. Son una herramienta útil para comprender mejor los patrones de uso y destacar el trabajo realizado.

- **Objetivo:** Monitorizar y visualizar la actividad del perfil o repositorios.
- **Beneficios:** Aumentan la visibilidad de las contribuciones y permiten detectar oportunidades de mejora.

---

### Objetivos del proyecto

El objetivo de este workflow es:
1. Garantizar la calidad del código mediante un **linter**.
2. Ejecutar pruebas automáticas con **Cypress**.
3. Generar un **badge** para el `README.md` que muestre los resultados de las pruebas.
4. Desplegar la aplicación en **Vercel**.
5. Enviar notificaciones sobre el estado del workflow por correo electrónico.
6. Integrar métricas del perfil en el `README.md` personal de GitHub.

---

## Configuración del Workflow

El workflow está definido en el archivo `.github/workflows/nodejs-blog-practica.yml`. Incluye cinco jobs principales:

### 1. **Linter_job**
Este job valida que la sintaxis del código sea correcta utilizando un linter.

**Pasos realizados**:
1. Se descarga el código del repositorio (`actions/checkout`).
2. Se configura el entorno de Node.js (`actions/setup-node`).
3. Se descargan las dependencias (`npm install`).
4. Se verifica el código ejecutando el linter (`npm run lint`).

---

### 2. **Cypress_job**
Este job ejecuta las pruebas automáticas con Cypress.

**Pasos realizados**:
1. Se descarga el código del repositorio.
2. Se configuran las dependencias y se compila la aplicación con `npm run build`.
3. Se arranca el servidor de la aplicación.
4. Se verifican los resultados con Cypress (`npx cypress run`).
5. Se genera un artefacto (`result.txt`) con el resultado de las pruebas.

---

### 3. **Add_badge_job**
Este job añade un badge al `README.md` para mostrar si las pruebas han pasado o fallado.

#### Descripción de la acción personalizada `action.yaml`:

```yaml
name: "Update README Badge"
description: "Modifica el README.md con el badge apropiado en función del outcome de Cypress"

inputs:
  outcome:
    description: "Result of Cypress tests (success or failure)"
    required: true

runs:
  using: "composite"
  steps:
    - name: Ensure script is executable
      shell: bash
      run: chmod +x update-readme-badge.sh

    - name: Execute script
      shell: bash
      run: ./update-readme-badge.sh "${{ inputs.outcome }}"
```

#### Descripción de `update-readme-badge.sh`:
```bash
#!/usr/bin/env bash
set -e

OUTCOME=$1
README_FILE="README.md"

BADGE_FAILURE="https://img.shields.io/badge/test-failure-red"
BADGE_SUCCESS="https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg"
SEARCH_TEXT="RESULTADOS DE LOS ÚLTIMOS TESTS"
![Cypress test badge](https://img.shields.io/badge/test-failure-red)

if [ "$OUTCOME" = "success" ]; then
    BADGE="$BADGE_SUCCESS"
else
    BADGE="$BADGE_FAILURE"
fi

if grep -q "$SEARCH_TEXT" "$README_FILE"; then
    sed -i "/$SEARCH_TEXT/a ![Cypress test badge]($BADGE)" "$README_FILE"
else
    echo "" >> "$README_FILE"
    echo "$SEARCH_TEXT" >> "$README_FILE"
    echo "![Cypress test badge]($BADGE)" >> "$README_FILE"
fi

echo "README.md modificado con el badge ($OUTCOME): $BADGE"
```

**Pasos realizados**:
1. Se descarga el código del repositorio.
2. Se recupera el artefacto generado en el `Cypress_job`.
3. Se procesa el resultado del archivo `result.txt`.
4. Se ejecuta una acción personalizada para actualizar el `README.md` con el badge correspondiente:
   - ✅ Success: ![Success](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)
   - ❌ Failure: ![Failure](https://img.shields.io/badge/test-failure-red)

---

### 4. **Deploy_job**
Este job despliega la aplicación en Vercel utilizando la **action oficial de Vercel**.

**Pasos realizados**:
1. Se descarga el código del repositorio.
2. Se despliega la aplicación en Vercel utilizando `amondnet/vercel-action`.

---

### 5. **Notification_job**
Este job envía un correo electrónico con el resultado del workflow a un destinatario configurado como secreto. Para ello, se utiliza una acción personalizada que se encuentra en el directorio github_actions/send-mail. Esta acción consta de dos archivos principales: action.yaml e index.js.

**Pasos realizados**:
1. Se descarga el código del repositorio.
2. Se utiliza la acción personalizada almacenada en github_actions/send-mail para enviar un correo con los siguientes parámetros::
   - Destinatario: Correo configurado en el secreto `PERSONAL_EMAIL`.
   - Asunto: Resultado del workflow.
   - Cuerpo: Resultados de todos los jobs ejecutados.

#### Descripción de la acción personalizada send-mail:

La acción para enviar un correo se encuentra en github_actions/send-mail y consta de los siguientes archivos:

#### Archivo `action.yaml`:

```yaml
name: "Send Mail Action"
description: "Enviar correo con los resultados"

inputs:
  to:
    required: true
    description: "Dirección de correo a la que se enviará el correo."
    
  subject:
    required: true
    description: "Asunto del correo."

  body:
    required: true
    description: "Contenido o cuerpo del correo."

runs:
  using: "node16"
  main: "dist/index.js"
```

- inputs: Define los parámetros necesarios para ejecutar la acción. En este caso, se requieren tres parámetros:
   - to: dirección de correo electrónico del destinatario.
   - subject: El asunto del correo.
   - body: El cuerpo del correo, que contiene los detalles del resultado de los jobs.
- runs: La acción se ejecuta en un entorno Node.js (versión 16). El archivo principal es dist/index.js.

#### Archivo `index.js`:

```javascript
const core = require('@actions/core');
const nodemailer = require('nodemailer');

async function run() {
    try {
        const to = core.getInput('to'); // Dirección de correo de destino
        const subject = core.getInput('subject'); // Asunto del correo
        const body = core.getInput('body'); // Cuerpo del correo

        // Obtiene las credenciales de Gmail desde las variables de entorno
        const user = process.env.GMAIL_USER; // Usuario de Gmail, debe estar configurado en GitHub secrets
        const pass = process.env.GMAIL_PASS; // Contraseña de Gmail, debe estar configurada en GitHub secrets

        if (!user || !pass) {
            throw new Error("Missing credentials for Gmail authentication");
        }

        let transporter = nodemailer.createTransport({
            service: 'gmail', // Usamos el servicio de Gmail para enviar el correo
            auth: { user, pass }, // Autenticación con las credenciales de Gmail
        });

        await transporter.sendMail({
            from: user, // Dirección de correo del remitente
            to, // Dirección de correo del destinatario
            subject, // Asunto del correo
            text: body // Cuerpo del correo
        });

        console.log("Correo enviado"); // Muestra un mensaje en la consola si el correo fue enviado exitosamente
    } catch (error) {
        core.setFailed(error.message); // Si ocurre un error, marca la acción como fallida
    }
}

run();
```
- index.js: Este archivo contiene la lógica para enviar el correo utilizando Nodemailer, que se conecta al servicio de Gmail usando las credenciales almacenadas en los secretos del repositorio (GMAIL_USER y GMAIL_PASS).
   - Autenticación: Se realiza a través de las variables de entorno configuradas en los secretos de GitHub.
   - Envío de correo: Se usa Nodemailer para enviar un correo con el asunto, cuerpo y destinatario definidos por los inputs de la acción.
   - Errores: Si falta alguna de las credenciales o hay algún error, se marca la acción como fallida.
---

## Configuración de Métricas en el Perfil de GitHub

Además del workflow principal, se ha configurado un workflow en el repositorio del perfil personal para mostrar métricas automáticas.

### Configuración:
- Se utiliza la acción `lowlighter/metrics`.
- Se actualiza diariamente el `README.md` con información sobre:
  - Lenguajes más utilizados.
  - Actividad reciente.
  - Estadísticas de contribución.


<!--START_SECTION:metrics-->
![GitHub Metrics](/github-metrics.svg)
<!--END_SECTION:metrics-->
