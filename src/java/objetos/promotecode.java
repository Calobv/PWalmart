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
public class promotecode {
    
    
    private String Codigo;
    private String Tipo; // "porcentaje" o "montoFijo"
    private int Restriccion;
    private boolean Activo;
    private int Descuento;

    public promotecode() {
    }

    public promotecode(String Codigo, String Tipo, int Restriccion, boolean activo,int Descuento) {
        this.Codigo = Codigo;
        this.Tipo = Tipo;
        this.Restriccion = Restriccion;
        this.Activo = Activo;
        this.Descuento = Descuento;
    }

  
    public String getCodigo() {
        return Codigo;
    }

    public void setCodigo(String codigo) {
        this.Codigo = codigo;
    }

    public String getTipo() {
        return Tipo;
    }

    public void setTipo(String Tipo) {
        this.Tipo = Tipo;
    }

    public int getRestriccion() {
        return Restriccion;
    }

    public void setRestriccion(int Restriccion) {
        this.Restriccion = Restriccion;
    }
        public int getDescuento() {
        return Descuento;
    }

    public void setDescuento(int Descuento) {
        this.Descuento = Descuento;
    }

    public boolean isActivo() {
        return Activo;
    }

    public void setActivo(boolean activo) {
        this.Activo = activo;
    }

    @Override
    public String toString() {
        return "PromoCode{" +
               "codigo='" + Codigo + '\'' +
               ", tipo='" + Tipo + '\'' +
               ", restriccion=" + Restriccion +
               ", activo=" + Activo +
                ", Descuento=" + Descuento +
               '}';
    }
}
    
    

