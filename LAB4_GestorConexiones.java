import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;

public class GestorConexiones {
    private ArrayList<ConexionFibra> listaFibra;
    private ArrayList<ConexionMovil> listaMovil;

    public GestorConexiones() {
        this.listaFibra = new ArrayList<>();
        this.listaMovil = new ArrayList<>();
    }

    // Ejercicio 2a: Registrar conexión
    public void registrarConexion(Scanner sc) {
        System.out.print("Tipo de conexión (F: Fibra / M: Móvil): ");
        String tipo = sc.nextLine().trim().toUpperCase();

        if (!tipo.equals("F") && !tipo.equals("M")) {
            System.out.println("Tipo inválido.");
            return;
        }

        System.out.print("Código: ");
        String codigo = sc.nextLine().trim();

        System.out.print("Cliente: ");
        String cliente = sc.nextLine().trim();

        System.out.print("Distrito: ");
        String distrito = sc.nextLine().trim();

        System.out.print("Velocidad contratada (Mbps): ");
        int velocidad = Integer.parseInt(sc.nextLine().trim());

        if (tipo.equals("F")) {
            System.out.print("Metros de cable: ");
            int metros = Integer.parseInt(sc.nextLine().trim());
            ConexionFibra fibra = new ConexionFibra(codigo, cliente, distrito, velocidad, metros);
            listaFibra.add(fibra);
        } else {
            System.out.print("Banda: ");
            String banda = sc.nextLine().trim();
            ConexionMovil movil = new ConexionMovil(codigo, cliente, distrito, velocidad, banda);
            listaMovil.add(movil);
        }

        System.out.println("Conexión registrada.");
    }

    // Ejercicio 2b: Listar conexiones
    public void listarConexiones() {
        for (ConexionFibra fibra : listaFibra) {
            fibra.mostrarFicha();
        }
        for (ConexionMovil movil : listaMovil) {
            movil.mostrarFicha();
        }
    }

    // Ejercicio 3b: Registrar pruebas de velocidad
    public void registrarPruebas(Scanner sc) {
        System.out.print("Código: ");
        String codigo = sc.nextLine().trim();

        ConexionFibra fibraEncontrada = null;
        for (ConexionFibra fibra : listaFibra) {
            if (fibra.getCodigo().equalsIgnoreCase(codigo)) {
                fibraEncontrada = fibra;
                break;
            }
        }

        if (fibraEncontrada == null) {
            System.out.println("Conexión no encontrada");
            return;
        }

        for (int i = 0; i < 3; i++) {
            System.out.print("Medición " + (i + 1) + " (Mbps): ");
            double valor = Double.parseDouble(sc.nextLine().trim());
            fibraEncontrada.registrarMedicion(i, valor);
        }

        double promedio = fibraEncontrada.calcularPromedio();
        double maxima = fibraEncontrada.obtenerMaxima();

        System.out.println("Promedio: " + promedio + " Mbps | Máxima: " + maxima + " Mbps");

        if (promedio >= fibraEncontrada.getVelocidadContratada() * 0.8) {
            System.out.println("Estado: CUMPLE");
        } else {
            System.out.println("Estado: NO CUMPLE");
        }
    }

    // Ejercicio 4: Reporte por distrito
    public void reportePorDistrito() {
        HashSet<String> distritos = new HashSet<>();
        HashMap<String, Integer> conteoDistritos = new HashMap<>();

        // Recorrer conexiones de Fibra
        for (ConexionFibra fibra : listaFibra) {
            String dist = fibra.getDistrito();
            distritos.add(dist);
            if (conteoDistritos.containsKey(dist)) {
                conteoDistritos.put(dist, conteoDistritos.get(dist) + 1);
            } else {
                conteoDistritos.put(dist, 1);
            }
        }

        // Recorrer conexiones Móvil
        for (ConexionMovil movil : listaMovil) {
            String dist = movil.getDistrito();
            distritos.add(dist);
            if (conteoDistritos.containsKey(dist)) {
                conteoDistritos.put(dist, conteoDistritos.get(dist) + 1);
            } else {
                conteoDistritos.put(dist, 1);
            }
        }

        System.out.println("Distritos con cobertura: " + distritos.size());

        for (String dist : distritos) {
            System.out.println(dist + ": " + conteoDistritos.get(dist));
        }
    }
}
