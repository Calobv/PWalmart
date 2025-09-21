<%-- 
    Document   : quitar_de_carrito
    Created on : 4/09/2025, 06:34:00 PM
    Author     : pc
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



<%@page import="objetos.productos"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Iterator"%>
<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String productCode = request.getParameter("codigo_producto");
    String mensaje = "";
    
    if (productCode != null && !productCode.trim().isEmpty()) {
        Dba db = null;
        try {
            db = new Dba(application.getRealPath("/") + "daw.mdb");
            db.conectar();
            
          
            String updateSql = "UPDATE Productos SET EnCarrito = 0 WHERE Codigo = '" + productCode + "'";
            db.executeUpdate(updateSql);
            db.commit();
            
           
            List<productos> cartItems = (List<productos>) session.getAttribute("cart");
            if (cartItems != null) {
                Iterator<productos> iterator = cartItems.iterator();
                while (iterator.hasNext()) {
                    productos item = iterator.next();
                    if (item.getCodigo().equals(productCode)) {
                        iterator.remove();
                        item.quitarDeCarrito();
                        break;
                    }
                }
                session.setAttribute("cart", cartItems);
            }
            
            mensaje = "Producto removido del carrito exitosamente";
            
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "Error al remover producto del carrito: " + e.getMessage();
        } finally {
            if (db != null) {
                db.desconectar();
            }
        }
    } else {
    }
    
    
    session.setAttribute("mensaje", mensaje);
    response.sendRedirect("carrito.jsp");
%>