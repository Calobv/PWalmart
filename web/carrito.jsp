<!--<%
    //seguridad para acceder a principal solamente si ha pasado del login
    //if (session.getAttribute("s_user") == null) {
      //  request.getRequestDispatcher("index.jsp").forward(request, response);
 //   }
%>
-->

<%
    // Bloque de seguridad general
    String rol = (String) session.getAttribute("rol");

    if (rol == null) {
        // Usuario no logueado -> redirige al index
        response.sendRedirect("index.jsp");
        return; // Detiene el resto del JSP
    }
%>


<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="objetos.productos"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Carrito de Compras - Walmart</title>
    <link rel="stylesheet" href="walmart.css">
</head>

<body>
    <!-- Encabezado -->
    <div class="header">
        <img src="https://walmarthn.vtexassets.com/assets/vtex/assets-builder/walmarthn.store-theme/1.1.19/waltmart-logo___e887a7c223ca5d5111202f45453db619.png"
            alt="Walmart Logo" class="logo">
        <br>
        <a href="home.jsp">Home</a>
        <a href="oredenes.jsp">Mis Órdenes</a>
        <a href="index.jsp">Cerrar Sesión</a>
    </div>
  
    <!-- Carrito -->
    <div class="contenedor">
        <p class="titulo"><b>Mi Carrito de Compras</b></p>

        <table class="tabla-productos">
            <thead>
                <tr>
                    <th>Imagen</th>
                    <th>Nombre</th>
                    <th>Descripcion</th>
                    <th>Precio</th>
                    <th>ISV (15%)</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>     <%
                    Dba db = null;
                    ResultSet rs = null;
                    double subtotal = 0.0;
                    double totalIsv = 0.0;
                    double total = 0.0;
                    double descuento = 0.0;
                    String promoCode = request.getParameter("promocode");
                    boolean hayProductos = false;

                    try {
                  
                        db = new Dba(application.getRealPath("/") + "daw.mdb");
                        db.conectar();
                        
                        
                        if (promoCode != null && !promoCode.trim().isEmpty()) {
                            String promoQuery = "SELECT Descuento FROM PromoteCode WHERE Codigo = '" + promoCode + "'";
                            db.query.execute(promoQuery);
                            ResultSet promoRs = db.query.getResultSet();
                            if (promoRs.next()) {
                                descuento = promoRs.getDouble("Descuento");
                            }
                            promoRs.close();
                        }

                    
                        String query = "SELECT * FROM Productos WHERE EnCarrito = -1";
                        db.query.execute(query);
                        rs = db.query.getResultSet();

                        while (rs.next()) {
                            hayProductos = true;
                            double precioProducto = rs.getDouble("Precio");
                            double isvProducto = precioProducto * 0.15; 
                            subtotal += precioProducto;
                            totalIsv += isvProducto;
                %>
                <tr>
                    <td><img src="<%= rs.getString("Imagen") %>" alt="Imagen del producto" style="width:100px;"></td>
                    <td><%= rs.getString("Nombre") %></td>
                    <td><%= rs.getString("Descripcion") %></td>
                    <td>L. <%= String.format("%.2f", precioProducto) %></td>
                    <td>L. <%= String.format("%.2f", isvProducto) %></td>
                    <td>
                        <form action="quitar_de_carrito.jsp" method="post">
                            <input type="hidden" name="codigo_producto" value="<%= rs.getString("Codigo") %>">
                            <button type="submit">Quitar</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        
                        if (!hayProductos) {
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 20px;">
                        <p>Tu carrito está vacío</p>
                        <a href="home.jsp">Continuar comprando</a>
                    </td>
                </tr>
                <%
                        }
                        
                    } catch (Exception e) {
                        e.printStackTrace();
                %>
                <tr>
                    <td colspan="6" style="text-align: center; padding: 20px;">
                        <p>Error al cargar el carrito: <%= e.getMessage() %></p>
                        <a href="home.jsp">Volver al inicio</a>
                    </td>
                </tr>
                <%
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (db != null) db.desconectar();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    
                    total = subtotal + totalIsv;
                    double finalTotal = total - (total * (descuento / 100));
                %>
            </tbody>
        </table>

        <!-- Total y Promo Code -->
        <% if (hayProductos) { %>
        <div class="resumen-carrito">
            <form action="carrito.jsp" method="get">
                <label><b>Promo Code:</b></label>
                <input type="text" name="promocode" placeholder="Ingresa tu código" value="<%= promoCode != null ? promoCode : "" %>">
                <button type="submit" class="btn-auntentificarcode">Aplicar Código</button>
            </form>
            <p><b>Subtotal: L. <%= String.format("%.2f", subtotal) %></b></p>
            <p><b>ISV: L. <%= String.format("%.2f", totalIsv) %></b></p>
            <% if (descuento > 0) { %>
                <p><b>Descuento (<%= String.format("%.0f", descuento) %>&#37;): L. <%= String.format("%.2f", total * (descuento / 100)) %></b></p>
            <% } %>
            <p><b>Total a pagar: L. <%= String.format("%.2f", finalTotal) %></b></p>
            
            <button type="button" class="btn-comprar" onclick="location.href='home.jsp'">Continuar Comprando</button>
            <input type="button" value="Realizar Compra" class="btn-comprar" onclick="location.href='pago.jsp<%= promoCode != null && !promoCode.trim().isEmpty() ? "?promocode=" + promoCode : "" %>'">
        </div>
        <% } %>
    </div>

   
    <div class="footer">
        <p>&copy; 2025 Walmart | <a
                href="https://www.walmartcentroamerica.com/content/dam/walmart-centro-america/documents/privacidad/19032025_AVISO_DE_PRIVACIDAD.pdf">Políticas
                de Privacidad</a> |
            <a href="https://www.walmart.com.hn/terminos-y-condiciones-de-compra">Términos</a>
        </p>
    </div>
</body>

</html>pro