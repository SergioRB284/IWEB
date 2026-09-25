public class ConexionFibra extends Conexion {
    private int metrosCable;

    public ConexionFibra(String codigo, String cliente, String distrito, int velocidadContratada, int metrosCable) {
        super(codigo, cliente, distrito, velocidadContratada);
        this.metrosCable = metrosCable;
    }

    public int getMetrosCable() {
        return metrosCable;
    }

    public void mostrarFicha() {
        System.out.println("[FIBRA]");
        mostrarDatos();
        System.out.println("Metros de cable: " + metrosCable);
    }
}
