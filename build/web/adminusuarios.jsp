<%
    // Bloque de seguridad para administración
    String rol = (String) session.getAttribute("rol");

    if (rol == null || !rol.equals("admin")) {
        // No está logueado o no es admin -> redirige al index
        response.sendRedirect("index.jsp");
        return;
    }
%>


<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Crear Usuario</title>
    <link rel="stylesheet" href="walmart.css">
</head>
<body>
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
             alt="Walmart Logo" class="logo">
        <br>
    </div>
    <h1>Crear Nuevo Usuario</h1>

    <form method="post">
        <label for="codigo">Código:</label>
        <input type="number" id="codigo" name="codigo" required><br><br>

        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required><br><br>

        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required><br><br>

        <label for="correo">Correo:</label>
        <input type="email" id="correo" name="correo" required><br><br>

        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" minlength="8" required><br><br>

        
        <button type="button" onclick="location.href='homeadmin.jsp'">Regresar a Home Administrador</button>

        <button type="submit">Guardar Usuario</button>
    </form>

    <%
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");

        if (codigo != null && nombre != null  && correo != null && password != null) {
            String mensaje = "";

            try {
                Dba db = new Dba(application.getRealPath("") + "/DBW.accdb");
                db.conectar();

                // Verificar si el correo ya existe
                db.query.execute("SELECT * FROM Usuarios WHERE Email='" + correo + "'");
                ResultSet rs = db.query.getResultSet();
                if (rs.next()) {
                    mensaje = "Ya existe un usuario con ese correo.";
                } else {
                    // Insertar usuario (rol = cliente por defecto, cámbialo si quieres admin)
                    String sql = "INSERT INTO Usuarios (Código, Nombre, Email, Password, Rol) "
                               + "VALUES ('" + codigo + "', '" + nombre +  "', '" + correo + "', '" + password + "', 'cliente')";
                    db.query.execute(sql);
                    db.commit();
                    mensaje = "Usuario creado correctamente.";
                }

                rs.close();
                db.desconectar();

            } catch (Exception e) {
                mensaje = "Error al registrar: " + e.getMessage();
            }

            out.print("<p style='color:green'>" + mensaje + "</p>");
        }
    %>
</body>
</html>
