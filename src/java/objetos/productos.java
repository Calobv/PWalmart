/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

/**
 *
 * @author pc
 */
public class productos {
    private String codigo;
    private String nombre;
    private String descripcion;
    private String imagenUrl;
    private double precio;
    private double isv; 
    private boolean enCarrito;

 
    public productos() {
    }

    
    public productos(String codigo, String nombre, String descripcion, String imagenUrl, double precio, double isv, boolean enCarrito) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.imagenUrl = imagenUrl;
        this.precio = precio;
        this.isv = isv;
        this.enCarrito = enCarrito;
    }


    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagenUrl() {
        return imagenUrl;
    }

    public void setImagenUrl(String imagenUrl) {
        this.imagenUrl = imagenUrl;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public double getIsv() {
        return isv;
    }

    public void setIsv(double isv) {
        this.isv = isv;
    }
 
    public boolean estaEnCarrito() {
        return enCarrito;
    }

    public void agregarAcarrito() {
        this.enCarrito = true;
    }
    
    public void quitarDeCarrito() {
        this.enCarrito = false;
    }


    public boolean getEnCarrito() {
        return enCarrito;
    }
    
    public void setEnCarrito(boolean enCarrito) {
        this.enCarrito = enCarrito;
    }

    @Override
    public String toString() {
        return "Producto{" +
                "codigo='" + codigo + '\'' +
                ", nombre='" + nombre + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", precio=" + precio +
                ", enCarrito=" + enCarrito +
                '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        productos producto = (productos) obj;
        return codigo != null ? codigo.equals(producto.codigo) : producto.codigo == null;
    }
    
    @Override
    public int hashCode() {
        return codigo != null ? codigo.hashCode() : 0;
    }
}