<%-- 
    Document   : eliminar_usuario
    Created on : 09-16-2025, 04:07:42 PM
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


<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Usuario - Admin</title>
        <link rel="stylesheet" href="walmart.css">
    </head>
    <body>

        <%
            String codigo = request.getParameter("codigo");
            String mensaje = "";

            if (codigo != null) {
                Dba db = null;
                try {
                    db = new Dba(application.getRealPath("") + "/DBW.accdb");
                    db.conectar();

                    String sql = "DELETE FROM Usuarios WHERE Código='" + codigo + "'";
                    int filas = db.query.executeUpdate(sql);
                    db.commit();

                    if (filas > 0) {
                        mensaje = "Usuario eliminado correctamente.";
                    } else {
                        mensaje = "No se encontró el usuario con ese código.";
                    }
                } catch (Exception e) {
                    mensaje = "Error al eliminar: " + e.getMessage();
                } finally {
                    if (db != null) {
                        db.desconectar();
                    }
                }
            } else {
                mensaje = "Código inválido.";
            }

            response.sendRedirect("listausuarios.jsp?mensaje=" + java.net.URLEncoder.encode(mensaje, "UTF-8"));
        %>

    </body>
</html>
