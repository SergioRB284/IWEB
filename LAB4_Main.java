import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        GestorConexiones gestor = new GestorConexiones();
        boolean salir = false;

        while (!salir) {
            System.out.println("***** MENU PRINCIPAL *****");
            System.out.println("(1) Registrar conexión");
            System.out.println("(2) Listar conexiones");
            System.out.println("(3) Registrar pruebas de velocidad");
            System.out.println("(4) Reporte por distrito");
            System.out.println("(5) Salir");
            System.out.print("Ingrese la opción: ");

            String opcion = sc.nextLine().trim();

            switch (opcion) {
                case "1":
                    gestor.registrarConexion(sc);
                    break;
                case "2":
                    gestor.listarConexiones();
                    break;
                case "3":
                    gestor.registrarPruebas(sc);
                    break;
                case "4":
                    gestor.reportePorDistrito();
                    break;
                case "5":
                    salir = true;
                    break;
                default:
                    System.out.println("La opción NO es válida");
                    break;
            }
        }
    }
}
