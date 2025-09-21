<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    // Bloque de seguridad general
    String rol = (String) session.getAttribute("rol");

    if (rol == null) {
        // Usuario no logueado -> redirige al index
        response.sendRedirect("index.jsp");
        return; // Detiene el resto del JSP
    }
%>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Home - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
    <style>
        .mensaje {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
            text-align: center;
        }
        .mensaje.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .mensaje.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>

<body>
    <!-- Encabezado -->
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
        <a href="carrito.jsp">Mi Carrito</a>
        <a href="oredenes.jsp">Mis Órdenes</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>

    <!-- Buscador -->
    <div class="buscador">
        <form action="home.jsp" method="post">
            <input type="text" name="buscar" size="40" placeholder="Buscar producto...">
            <input type="submit" value="Buscar">
        </form>
    </div>

    <div class="contenedor">
        <p class="titulo"><b>Productos Disponibles</b></p>

        <%
            String mensaje = (String) session.getAttribute("mensaje");
            if (mensaje != null) {
                session.removeAttribute("mensaje"); // Limpiar el mensaje después de mostrarlo
        %>
            <div class="mensaje success">
                <%= mensaje %>
            </div>
        <%
            }
        %>

        <table class="tabla-productos">
            <thead>
                <tr>
                    <th>Código</th>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Descripcion</th>
                    <th>Precio</th>
                    <th>En carrito</th>
                    <th>Accion</th>
                </tr>
            </thead>
            <tbody>
                            <%

    Dba db = null;
    ResultSet rs = null;
    try {
     
        db = new Dba(application.getRealPath("/") + "daw.mdb");
        db.conectar();

       
        String searchTerm = request.getParameter("buscar");
        String sql;
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
          
            sql = "SELECT Codigo, Nombre, Imagen, Descripcion, EnCarrito, Precio FROM Productos WHERE Nombre LIKE '%" + searchTerm + "%' OR Descripcion LIKE '%" + searchTerm + "%'";
        } else {
           
            sql = "SELECT Codigo, Nombre, Imagen, Descripcion, EnCarrito, Precio FROM Productos";
        }
        
       
        db.query.execute(sql);
        rs = db.query.getResultSet();
                    while (rs.next()) {
                        boolean enCarrito = rs.getBoolean("EnCarrito");
            %>
                        <tr>
                            <td><%= rs.getString("Codigo") %></td>
                            <td><img src="<%= rs.getString("Imagen") %>" alt="<%= rs.getString("Nombre") %>" width="100"></td>
                            <td><%= rs.getString("Nombre") %></td>
                            <td><%= rs.getString("Descripcion") %></td>
                            <td>L. <%= String.format("%.2f", rs.getDouble("Precio")) %></td>
                            <td>
                        <%
                            if (enCarrito) {
                                out.println("Sí");
                            } else {
                                out.println("No");
                            }
                        %>
                    </td>
                            <td>
    <form action="agregar_a_carrito.jsp" method="post">
        <input type="hidden" name="codigo_producto" value="<%= rs.getString("Codigo") %>">
        <% if (enCarrito) { %>
            <button type="button" disabled style="background-color: #ccc; cursor: not-allowed;">Ya en carrito</button>
        <% } else { %>
            <button type="submit">Agregar al carrito</button>
        <% } %>
    </form>
</td>
                        </tr>
            <%
                    }
                } catch (Exception e) {
         
                    e.printStackTrace();     
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (db != null) db.desconectar();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            %>
            </tbody>
        </table>
        <!-- Botón para regresar -->
<button onclick="location.href='index.jsp'">Regresar</button>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2025 Walmart | <a
                href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">Políticas
                de Privacidad</a>
            | <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a></p>
    </div>
</body>

</html>