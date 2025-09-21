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
        <title>Listado de Usuarios</title>
        <link rel="stylesheet" href="walmart.css">
    </head>
    <body>
        <h1>Listado de Usuarios</h1>


        <table border="1">
            <tr>
                <th>Código</th>
                <th>Nombre</th>
                
                <th>Correo</th>
                <th>Acciones</th>
            </tr>
            <%
                Dba db = null;
                ResultSet rs = null;
                try {
                    db = new Dba(application.getRealPath("") + "/DBW.accdb");
                    db.conectar();

                    db.query.execute("SELECT Código, Nombre, Email FROM Usuarios");
                    rs = db.query.getResultSet();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("Código")%></td>
                <td><%= rs.getString("Nombre")%></td>
                
                <td><%= rs.getString("Email")%></td>
                <td>
                    <!-- Botón Editar -->
                    <form action="editarusuario.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="codigo" value="<%= rs.getString("Código")%>">
                        <button type="submit">Editar</button>
                    </form>

                    <!-- Botón Eliminar -->
                    <form action="eliminar_usuario.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="codigo" value="<%= rs.getString("Código")%>">
                        <button type="submit">Eliminar</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.print("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (db != null) {
                        db.desconectar();
                    }
                }
            %>
        </table>

        <br>
        
        <button type="button" onclick="location.href = 'homeadmin.jsp'">Regresar a Home Administrador</button>
    </table>
</body>
</html>
