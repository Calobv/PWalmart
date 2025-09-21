

<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Registro - Walmart</title>
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
            <h2>Crear Cuenta</h2>

            <form method="post" class="formulario">
                <label>Código:</label>
                <input type="number" name="codigo" required><br>

                <label>Nombre:</label>
                <input type="text" name="nombre" required><br>

                <label>Apellido:</label>
                <input type="text" name="apellido" required><br>

                <label>Email:</label>
                <input type="email" name="correo" required><br>

                <label>Contraseña:</label>
                <input type="password" name="pass" minlength="8" required><br>

                <button type="button" onclick="location.href = 'index.jsp'">Regresar</button>
                <button type="submit">Registrarse</button>
            </form>

            <%
                String codigo = request.getParameter("codigo");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String correo = request.getParameter("correo");
                String pass = request.getParameter("pass");

                if (codigo != null && nombre != null && apellido != null && correo != null && pass != null) {
                    String mensaje = null;

                    // Validaciones
                    if (!codigo.matches("\\d+")) {
                        mensaje = "El código debe contener solo números.";
                    } else if (!nombre.matches("[a-zA-Z]+")) {
                        mensaje = "El nombre solo puede contener letras.";
                    } else if (!apellido.matches("[a-zA-Z]+")) {
                        mensaje = "El apellido solo puede contener letras.";
                    } else if (!correo.matches("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$")) {
                        mensaje = "El correo no es válido.";
                    } else if (pass.length() < 8) {
                        mensaje = "La contraseña debe tener al menos 8 caracteres.";
                    } else {
                        // Insertar en DB si todo es correcto
                        Dba db = null;
                        ResultSet rs = null;
                        try {
                            db = new Dba(application.getRealPath("") + "/DBW.accdb");
                            db.conectar();

                            // Verificar si ya existe el email
                            db.query.execute("SELECT * FROM Usuarios WHERE Email='" + correo + "'");
                            rs = db.query.getResultSet();
                            if (rs.next()) {
                                mensaje = "Ya existe una cuenta con ese correo.";
                            } else {
                                // Insertar nuevo usuario (por defecto Rol = cliente)
                                String insertSQL = "INSERT INTO Usuarios (Código, Nombre, Email, Password, Rol) "
                                        + "VALUES ('" + codigo + "', '" + nombre + "', '" + correo + "', '" + pass + "', 'cliente')";
                                db.executeUpdate(insertSQL);
                                db.commit();
                                mensaje = "Cuenta creada correctamente. Ya puedes iniciar sesión.";
                            }

                        } catch (Exception e) {
                            mensaje = "Error al registrar: " + e.getMessage();
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (db != null) {
                                    db.desconectar();
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }
            %>
            <p style="color:<%= mensaje.contains("correctamente") ? "green" : "red"%>"><%= mensaje%></p>
            <%
                }
            %>

        </main>
    </body>
</html>
