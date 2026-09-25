public class Conexion {
    private String codigo;
    private String cliente;
    private String distrito;
    private int velocidadContratada;
    private double[] mediciones;

    public Conexion(String codigo, String cliente, String distrito, int velocidadContratada) {
        this.codigo = codigo;
        this.cliente = cliente;
        this.distrito = distrito;
        this.velocidadContratada = velocidadContratada;
        this.mediciones = new double[3]; // Inicializa arreglo de longitud 3
    }

    public String getCodigo() {
        return codigo;
    }

    public String getCliente() {
        return cliente;
    }

    public String getDistrito() {
        return distrito;
    }

    public int getVelocidadContratada() {
        return velocidadContratada;
    }

    public double[] getMediciones() {
        return mediciones;
    }

    public void mostrarDatos() {
        System.out.println("Código: " + codigo + " | Cliente: " + cliente + " | Distrito: " + distrito + " | " + velocidadContratada + " Mbps");
    }

    public void registrarMedicion(int posicion, double valor) {
        if (posicion >= 0 && posicion < mediciones.length) {
            mediciones[posicion] = valor;
        }
    }

    public double calcularPromedio() {
        double suma = 0.0;
        for (double m : mediciones) {
            suma += m;
        }
        return suma / mediciones.length;
    }

    public double obtenerMaxima() {
        double max = mediciones[0];
        for (double m : mediciones) {
            if (m > max) {
                max = m;
            }
        }
        return max;
    }
}
