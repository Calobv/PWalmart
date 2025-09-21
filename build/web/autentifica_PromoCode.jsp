<%-- 
    Document   : autentifica_PromoCode
    Created on : 4/09/2025, 11:06:36 AM
    Author     : pc
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


<%@page import="java.sql.*"%> 
<%@page import="database.*"%>
<%
    try {

        Dba db = new Dba(application.getRealPath("") + "/daw.mdb");
        db.conectar();
        db.query.execute("select Codigo, password from PromoteCode");
        ResultSet rs = db.query.getResultSet();
        String centinela = "n";
        while (rs.next()) {
            if (request.getParameter("ti_usuario").equals(rs.getString(1))
                    && request.getParameter("ti_password").equals(rs.getString(2))) {

                System.out.println(rs.getString(1));
                centinela = "s";
            }
        }
        if (centinela.equals("s")) {
      
            session.setAttribute("s_user", request.getParameter("ti_usuario"));
            session.setAttribute("s_pass", request.getParameter("ti_password"));
            //llamar jsp correspondiente desde linea de comando
            request.getRequestDispatcher("principal.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        db.desconectar();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
