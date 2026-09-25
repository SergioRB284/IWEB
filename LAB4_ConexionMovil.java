public class ConexionMovil extends Conexion {
    private String banda;

    public ConexionMovil(String codigo, String cliente, String distrito, int velocidadContratada, String banda) {
        super(codigo, cliente, distrito, velocidadContratada);
        this.banda = banda;
    }

    public String getBanda() {
        return banda;
    }

    public void mostrarFicha() {
        System.out.println("[5G]");
        mostrarDatos();
        System.out.println("Banda: " + banda);
    }
}
