<%-- 
    Document   : agregar_a_carrito
    Created on : 4/09/2025, 03:56:07 PM
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
<%@page import="database.Dba"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String productCode = request.getParameter("codigo_producto");
    String mensaje = "";
    
    if (productCode != null && !productCode.trim().isEmpty()) {
        Dba db = null;
        ResultSet rs = null;
        try {
            db = new Dba(application.getRealPath("/") + "daw.mdb");
            db.conectar();
            
            // Buscar el producto en la base de datos
            String sql = "SELECT Codigo, Nombre, Descripcion, Imagen, Precio, ISV, EnCarrito FROM Productos WHERE Codigo = '" + productCode + "'";
            db.query.execute(sql);
            rs = db.query.getResultSet();
            
            if (rs.next()) {
             
                if (!rs.getBoolean("EnCarrito")) {
              
                    String updateSql = "UPDATE Productos SET EnCarrito = -1 WHERE Codigo = '" + productCode + "'";
                    db.executeUpdate(updateSql);
                    db.commit();
                    
              
                    productos newProduct = new productos(
                        rs.getString("Codigo"),
                        rs.getString("Nombre"),
                        rs.getString("Descripcion"),
                        rs.getString("Imagen"),
                        rs.getDouble("Precio"),
                        rs.getDouble("ISV"),
                        true 
                    );

        
                    List<productos> cartItems = (List<productos>) session.getAttribute("cart");
                    if (cartItems == null) {
                        cartItems = new ArrayList<productos>();
                    }
            
                    boolean alreadyInCart = false;
                    for (productos item : cartItems) {
                        if (item.getCodigo().equals(newProduct.getCodigo())) {
                            alreadyInCart = true;
                            break;
                        }
                    }
                    
                    if (!alreadyInCart) {
                        cartItems.add(newProduct);
                        mensaje = "Producto agregado al carrito exitosamente";
                    } else {
                        mensaje = "El producto ya estaba en el carrito";
                    }
                    
    
                    session.setAttribute("cart", cartItems);
                } else {
                    mensaje = "El producto ya está en el carrito";
                }
            } else {
                mensaje = "Producto no encontrado";
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            mensaje = "Error al agregar producto al carrito: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (db != null) {
                db.desconectar();
            }
        }
    } else {
        mensaje = "Código de producto inválido";
    }
    
    // Redirigir con mensaje
    session.setAttribute("mensaje", mensaje);
    response.sendRedirect("home.jsp");
%>