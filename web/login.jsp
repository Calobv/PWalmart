<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - Walmart</title>
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
<h2>Iniciar Sesión</h2>

<form method="post" class="formulario">
    <label>Email:</label>
    <input type="email" name="email" required placeholder="usuario@gmail.com"><br>

    <label>Contraseña:</label>
    <input type="password" name="pass" minlength="8" required><br>

    <button type="button" onclick="location.href='index.jsp'">Regresar</button>
    <button type="submit">Ingresar</button>
</form>

<p>¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
<p><a href="reestablecer.jsp">¿Olvidaste tu contraseña?</a></p>

<%
    String email = request.getParameter("email");
    String pass = request.getParameter("pass");

    if(email != null && pass != null) {
        String mensajeError = null;

        // Validaciones
        if(!email.matches("^[A-Za-z0-9._%+-]+@gmail\\.com$")) {
            mensajeError = "El email debe ser un Gmail válido.";
        } else if(pass.length() < 8) {
            mensajeError = "La contraseña debe tener al menos 8 caracteres.";
        }

        if(mensajeError == null) {
            Dba db = null;
            ResultSet rs = null;
            try {
                db = new Dba(application.getRealPath("") + "/DBW.accdb");
                db.conectar();

                // Consulta insensible a mayúsculas y espacios
                String sql = "SELECT Rol FROM Usuarios WHERE LOWER(TRIM(Email))='" 
                            + email.toLowerCase().trim() 
                            + "' AND LOWER(TRIM(Password))='" 
                            + pass.toLowerCase().trim() + "'";
                db.query.execute(sql);
                rs = db.query.getResultSet();

                if(rs.next()) {
                    String rol = rs.getString("Rol").trim();
                    session.setAttribute("email", email.trim());
                    session.setAttribute("rol", rol);

                    if("admin".equalsIgnoreCase(rol)) {
                        response.sendRedirect("homeadmin.jsp");
                    } else {
                        response.sendRedirect("home.jsp");
                    }
                } else {
                    mensajeError = "Usuario o contraseña incorrectos.";
                }

            } catch(Exception e) {
                mensajeError = "Error al iniciar sesión: " + e.getMessage();
                e.printStackTrace();
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(db != null) db.desconectar();
                } catch(Exception e) { e.printStackTrace(); }
            }
        }

        if(mensajeError != null) {
%>
            <p style="color:red;"><%= mensajeError %></p>
<%
        }
    }
%>

</main>
</body>
</html>
