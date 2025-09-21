<%-- 
    Document   : homeadmin
    Created on : 09-03-2025, 12:22:40 PM
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


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home - Admin</title>
        <link rel="stylesheet" href="walmart.css">
    </head> 
    <body>
        <div class="header">
            <a href="index.jsp">
                <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
                     alt="Walmart Logo" class="logo">
            </a>
            <br>
            <a href="homeadmin.jsp">Inicio Admin</a>
            <a href="adminproductos.jsp">Productos</a>
            <a href="adminusuarios.jsp">Usuarios</a>
            <a href="adminpromos.jsp">Promociones</a>
            <a href="index.jsp">Cerrar Sesión</a>
        </div>

        <!-- Contenido -->
        <div class="contenedor">
            <h2>Bienvenido Administrador</h2>
            <p>Desde aquí puedes gestionar todo el sistema:</p>
            <ul>
                <li><a href="adminproductos.jsp">Gestionar productos</a></li>
                <li><a href="listaproductos.jsp">Ver lista de productos</a></li>
                <li><a href="adminusuarios.jsp">Gestionar usuarios</a></li>
                <li><a href="listausuarios.jsp">Ver lista de usuarios</a></li>
                <li><a href="adminpromos.jsp">Gestionar promociones</a></li>
            </ul>
            <!-- 🔹 Nueva sección para reportes -->
            <h3>Reportes</h3>
            <p>Genera reportes en PDF:</p>
            <button onclick="location.href='reporteUsuarios.jsp'">Reporte de Usuarios</button>
            <button onclick="location.href='reporteProductos.jsp'">Reporte de Productos</button>
        </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 Walmart | Panel de administración</p>
        </div>
    </body>
</html>
