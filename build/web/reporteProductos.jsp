<%-- 
    Document   : reporteProductos
    Created on : 09-20-2025, 02:28:34 PM
    Author     : moraz
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Dba"%>
<%@page import="com.lowagie.text.pdf.PdfPTable"%>
<%@page import="com.lowagie.text.Paragraph"%>
<%@page import="com.lowagie.text.FontFactory"%>
<%@page import="com.lowagie.text.pdf.PdfWriter"%>
<%@page import="com.lowagie.text.Document"%>
<%
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition","attachment;filename=productos.pdf");

    Document document = new Document();
    PdfWriter.getInstance(document, response.getOutputStream());
    document.open();

    document.add(new Paragraph("Reporte de Productos - Walmart", FontFactory.getFont(FontFactory.HELVETICA_BOLD,16)));
    document.add(new Paragraph(" "));

    PdfPTable table = new PdfPTable(4); // columnas: Codigo, Nombre, Descripcion, Precio
    table.addCell("Código");
    table.addCell("Nombre");
    table.addCell("Descripción");
    table.addCell("Precio");

    Dba db = null;
    ResultSet rs = null;
    try {
        db = new Dba(application.getRealPath("/") + "daw.mdb");
        db.conectar();
        db.query.execute("SELECT Codigo, Nombre, Descripcion, Precio FROM Productos");
        rs = db.query.getResultSet();

        while(rs.next()){
            table.addCell(rs.getString("Codigo"));
            table.addCell(rs.getString("Nombre"));
            table.addCell(rs.getString("Descripcion"));
            table.addCell("L. " + rs.getDouble("Precio"));
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
