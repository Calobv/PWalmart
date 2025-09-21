<%-- 
    Document   : editarusuario
    Created on : 09-17-2025, 12:03:46 PM
    Author     : moraz
--%>

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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuario</title>
        <link rel="stylesheet" href="walmart.css">
    </head>
    <body>
        <h1>Editar Usuario</h1>

        <%
            String codigo = request.getParameter("codigo");
            String nombre = "";
            String correo = "";
            String pass = "";

            if (codigo != null) {
                Dba db = null;
                ResultSet rs = null;
                try {
                    db = new Dba(application.getRealPath("") + "/DBW.accdb");
                    db.conectar();

                    db.query.execute("SELECT * FROM Usuarios WHERE Código='" + codigo + "'");
                    rs = db.query.getResultSet();
                    if (rs.next()) {
                        nombre = rs.getString("Nombre");
                        correo = rs.getString("Email");
                        pass = rs.getString("Password");
                    }
                } catch (Exception e) {
                    out.print("<p style='color:red;'>Error al cargar usuario: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                }
            }

            // Si se presionó Guardar
            if (request.getParameter("guardar") != null) {
                nombre = request.getParameter("nombre");
                correo = request.getParameter("correo");
                pass = request.getParameter("pass");

                Dba db = null;
                try {
                    db = new Dba(application.getRealPath("") + "/DBW.accdb");
                    db.conectar();

                    String updateSQL = "UPDATE Usuarios SET "
                            + "Nombre='" + nombre + "', "
                            + "Email='" + correo + "', "
                            + "Password='" + pass + "' "
                            + "WHERE Código='" + codigo + "'";
                    db.query.executeUpdate(updateSQL);
                    db.commit();

                    response.sendRedirect("listausuarios.jsp");
                    return;
                } catch (Exception e) {
                    out.print("<p style='color:red;'>Error al actualizar: " + e.getMessage() + "</p>");
                }
            }
        %>

        <form method="post">
            <input type="hidden" name="codigo" value="<%= codigo%>">

            <label>Código:</label>
            <input type="text" value="<%= codigo%>" disabled><br>

            <label>Nombre:</label>
            <input type="text" name="nombre" value="<%= nombre%>" required><br>

            <label>Email:</label>
            <input type="email" name="correo" value="<%= correo%>" required><br>

            <label>Password:</label>
            <input type="password" name="pass" value="<%= pass%>" required><br><br>

            <button type="submit" name="guardar">Guardar Cambios</button>
            <button type="button" onclick="location.href = 'listausuarios.jsp'">Cancelar</button>
        </form>
    </body>
</html>
