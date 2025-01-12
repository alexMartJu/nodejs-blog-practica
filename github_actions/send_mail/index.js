const core = require('@actions/core');
const nodemailer = require('nodemailer');

async function run() {
    try {
        // Obtiene los parámetros de entrada de la acción personalizada
        const to = core.getInput('to'); // Dirección de correo de destino
        const subject = core.getInput('subject'); // Asunto del correo
        const body = core.getInput('body'); // Cuerpo del correo

        // Obtiene las credenciales de Gmail desde las variables de entorno
        const user = process.env.GMAIL_USER; // Usuario de Gmail, debe estar configurado en GitHub secrets
        const pass = process.env.GMAIL_PASS; // Contraseña de Gmail, debe estar configurada en GitHub secrets

        // Si no se encuentran las credenciales, lanza un error
        if (!user || !pass) {
            throw new Error("Missing credentials for Gmail authentication");
        }

        // Crea el objeto para enviar el correo utilizando Nodemailer
        let transporter = nodemailer.createTransport({
            service: 'gmail', // Usamos el servicio de Gmail para enviar el correo
            auth: { user, pass }, // Autenticación con las credenciales de Gmail
        });

        // Envia el correo utilizando la configuración creada
        await transporter.sendMail({
            from: user, // Dirección de correo del remitente
            to, // Dirección de correo del destinatario
            subject, // Asunto del correo
            text: body // Cuerpo del correo
        });

        console.log("Correo enviado"); // Muestra un mensaje en la consola si el correo fue enviado exitosamente
    } catch (error) {
        // Si ocurre un error, marca la acción como fallida y muestra el mensaje de error
        core.setFailed(error.message);
    }
}

// Llama a la función que ejecuta todo el proceso
run();
