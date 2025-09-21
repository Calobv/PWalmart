<%-- 
    Document   : reestablecer
    Created on : 09-03-2025, 11:44:09 AM
    Author     : moraz
--%>
<%
    // Bloque de seguridad general
    String rol = (String) session.getAttribute("rol");

    if (rol == null) {
        // Usuario no logueado -> redirige al index
        response.sendRedirect("index.jsp");
        return; // Detiene el resto del JSP
    }
%>
<%@page import="java.util.UUID"%>
<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.*"%>
<%@page import="javax.mail.internet.*"%>
<%@page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Reestablecer Contraseña</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <header>
        <a href="index.jsp">
            <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
                 alt="Walmart Logo" class="logo">
        </a>
    </header>

    <main>
        <h2>Restablecer Contraseña</h2>
        <form method="post" class="formulario">
            <label>Email (Gmail):</label>
            <input type="email" name="email" required pattern="[a-zA-Z0-9._%+-]+@gmail\.com"><br>
            <button type="submit">Actualizar Contraseña</button>
        </form>
        <p><a href="login.jsp">Volver a iniciar sesión</a></p>

        <%
            String email = request.getParameter("email");
            if(email != null) {
                Dba db = new Dba(application.getRealPath("") + "/DBW.accdb");
                db.conectar();
                db.query.execute("SELECT * FROM Usuarios WHERE Email='" + email + "'");
                ResultSet rs = db.query.getResultSet();

                if(rs.next()) {
                    // Generar nueva contraseña
                    String nuevaPass = UUID.randomUUID().toString().substring(0,8);

                    // Actualizar contraseña en la base de datos
                    db.query.execute("UPDATE Usuarios SET Password='" + nuevaPass + "' WHERE Email='" + email + "'");

                    // Configurar propiedades de Gmail
                    final String remitente = "massielmorazan171@gmail.com"; // Tu Gmail
                    final String clave = "x y t r k q q r v v j k a c w j";       // Contraseña de app de Gmail
                    Properties props = new Properties();
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "587");

                    Session sessionMail = Session.getInstance(props,
                        new javax.mail.Authenticator() {
                            protected PasswordAuthentication getPasswordAuthentication() {
                                return new PasswordAuthentication(remitente, clave);
                            }
                        });

                    try {
                        Message mensaje = new MimeMessage(sessionMail);
                        mensaje.setFrom(new InternetAddress(remitente));
                        mensaje.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                        mensaje.setSubject("Restablecimiento de contraseña Walmart");
                        mensaje.setText("Hola, tu nueva contraseña es: " + nuevaPass);

                        Transport.send(mensaje);
                        out.print("<p style='color:green;'>Contraseña actualizada y enviada por correo exitosamente.</p>");
                    } catch (Exception e) {
                        out.print("<p style='color:red;'>Error al enviar el correo: " + e.getMessage() + "</p>");
                    }

                } else {
                    out.print("<p style='color:red;'>No existe ninguna cuenta con ese email</p>");
                }

                db.desconectar();
            }
        %>
    </main>
</body>
</html>
