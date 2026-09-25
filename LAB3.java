package org.example;

import java.util.Scanner;

public class Main {
    // Variables globales para el estado del juego
    private static int saldoTokens = 0;
    private static int totalHeroesCreados = 0;
    private static int totalHeroesComprados = 0;
    private static Heroe ultimoHeroeCreado = null;

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        boolean continuar = true;

        System.out.println("===== TOYOVERSE - INVOCACION DE HEROES =====");

        while (continuar) {
            System.out.println("Menu:");
            System.out.println("1. Crear un heroe");
            System.out.println("2. Comprar tokens");
            System.out.println("3. Comprar un heroe");
            System.out.println("4. Mostrar total de heroes comprados");
            System.out.println("5. Finalizar programa");
            System.out.print("Elige una opcion: ");

            String opcionStr = sc.nextLine();

            switch (opcionStr) {
                case "1":
                    crearHeroe(sc);
                    break;
                case "2":
                    comprarTokens(sc);
                    break;
                case "3":
                    comprarHeroe();
                    break;
                case "4":
                    mostrarTotalComprados();
                    break;
                case "5":
                    System.out.println("Gracias por jugar. Hasta la proxima invocacion!");
                    continuar = false;
                    break;
                default:
                    System.out.println("Opcion invalida. Intente nuevamente.");
                    break;
            }
        }
    }

    // Pregunta 1: Metodo para comprar tokens
    public static void comprarTokens(Scanner sc) {
        boolean tokenValido = false;

        while (!tokenValido) {
            System.out.print("Ingrese la cantidad de tokens a comprar: ");
            String entrada = sc.nextLine();

            try {
                int cantidad = Integer.parseInt(entrada);
                if (cantidad <= 0) {
                    System.out.println("La cantidad debe ser mayor a cero.");
                } else if (cantidad > 500) {
                    System.out.println("La cantidad no puede ser mayor a 500.");
                } else {
                    saldoTokens += cantidad;
                    System.out.println("Compra de tokens exitosa.");
                    System.out.println("Tokens disponibles: " + saldoTokens);
                    tokenValido = true;
                }
            } catch (NumberFormatException e) {
                System.out.println("Ingrese un numero entero valido.");
            }
        }
    }

    // Pregunta 2: Metodo para crear un héroe con validaciones paso a paso
    public static void crearHeroe(Scanner sc) {
        Heroe nuevoHeroe = new Heroe();

        // 1. Validar Nombre
        while (true) {
            System.out.print("Ingrese nombre del heroe: ");
            String nombre = sc.nextLine().trim();
            if (!nombre.isEmpty()) {
                nuevoHeroe.setNombre(nombre);
                break;
            }
            System.out.println("El atributo no puede estar en blanco. Intente nuevamente");
        }

        // 2. Validar Tipo (atacante, defensor o soporte)
        while (true) {
            System.out.print("Ingrese tipo (atacante/defensor/soporte): ");
            String tipo = sc.nextLine().trim().toLowerCase();
            if (tipo.equals("atacante") || tipo.equals("defensor") || tipo.equals("soporte")) {
                nuevoHeroe.setTipo(tipo);
                break;
            }
            System.out.println("El atributo no puede estar en blanco. Intente nuevamente");
        }

        // 3. Validar HP (> 0)
        while (true) {
            System.out.print("Ingrese HP: ");
            String entrada = sc.nextLine().trim();
            try {
                int hp = Integer.parseInt(entrada);
                if (hp > 0) {
                    nuevoHeroe.setHp(hp);
                    break;
                }
            } catch (NumberFormatException ignored) {}
            System.out.println("El atributo no puede estar en blanco. Intente nuevamente");
        }

        // 4. Validar MP (> 0)
        while (true) {
            System.out.print("Ingrese MP: ");
            String entrada = sc.nextLine().trim();
            try {
                int mp = Integer.parseInt(entrada);
                if (mp > 0) {
                    nuevoHeroe.setMp(mp);
                    break;
                }
            } catch (NumberFormatException ignored) {}
            System.out.println("El atributo no puede estar en blanco. Intente nuevamente");
        }

        // 5. Validar Rareza (1 a 5)
        while (true) {
            System.out.print("Ingrese rareza (1-5): ");
            String entrada = sc.nextLine().trim();
            try {
                int rareza = Integer.parseInt(entrada);
                if (rareza >= 1 && rareza <= 5) {
                    nuevoHeroe.setRarity(rareza);
                    break;
                }
            } catch (NumberFormatException ignored) {}
            System.out.println("El atributo no puede estar en blanco. Intente nuevamente");
        }

        // 6. Validar Precio (> 0)
        while (true) {
            System.out.print("Ingrese precio: ");
            String entrada = sc.nextLine().trim();
            try {
                int precio = Integer.parseInt(entrada);
                if (precio > 0) {
                    nuevoHeroe.setPrice(precio);
                    break;
                }
            } catch (NumberFormatException ignored) {}
            System.out.println("El atributo no puede estar en blanco. Intente nuevamente");
        }

        // Guardar el héroe creado y actualizar contador
        ultimoHeroeCreado = nuevoHeroe;
        totalHeroesCreados++;
        System.out.println("Heroe creado correctamente.");
        System.out.println("Total de heroes creados: " + totalHeroesCreados);
    }

    // Pregunta 3: Metodo para comprar héroe
    public static void comprarHeroe() {
        if (ultimoHeroeCreado == null) {
            System.out.println("No hay ningun heroe creado para comprar.");
            return;
        }

        if (saldoTokens >= ultimoHeroeCreado.getPrice()) {
            saldoTokens -= ultimoHeroeCreado.getPrice();
            totalHeroesComprados++;
            System.out.println("Compra exitosa!");
            System.out.println("Tokens disponibles: " + saldoTokens);
        } else {
            System.out.println("No hay saldo suficiente.");
        }
    }

    // Pregunta 3: Metodo para mostrar total de héroes comprados
    public static void mostrarTotalComprados() {
        System.out.println("Total de heroes comprados: " + totalHeroesComprados);
    }
}
