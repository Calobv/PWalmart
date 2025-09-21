<%-- 
    Document   : reporteUsuarios
    Created on : 09-20-2025, 02:19:01 PM
    Author     : moraz
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.FontFactory"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.Document"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition","attachment;filename=usuarios.pdf");

    Document document = new Document();
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    document.add(new Paragraph("Reporte de Usuarios - Walmart", FontFactory.getFont(FontFactory.HELVETICA_BOLD,16)));
    document.add(new Paragraph(" ")); // espacio

    PdfPTable table = new PdfPTable(3); // columnas: Codigo, Nombre, Email
    table.addCell("Código");
    table.addCell("Nombre");
    table.addCell("Email");

    Dba db = null;
    ResultSet rs = null;
    try {
        db = new Dba(application.getRealPath("/") + "DBW.accdb");
        db.conectar();
        db.query.execute("SELECT Código, Nombre, Email FROM Usuarios");
        rs = db.query.getResultSet();

        while(rs.next()){
            table.addCell(rs.getString("Código"));
            table.addCell(rs.getString("Nombre"));
            table.addCell(rs.getString("Email"));
        }
        document.add(table);
    } catch(Exception e){
        document.add(new Paragraph("Error: " + e.getMessage()));
    } finally {
        if (rs!=null) rs.close();
        if (db!=null) db.desconectar();
    }

    document.close();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
    </body>
</html>
