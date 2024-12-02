package com.ingenieria.clases;

import java.util.Scanner;

public class Menu {
  private int option;
  private Scanner scanner;
  private SistemaArchivos sistemaArchivos;

  public Menu(){
    this.option = 0;
    this.scanner = new Scanner(System.in);
    this.sistemaArchivos = new SistemaArchivos();
  }

  public void startMenu(){
    do{
      System.out.println("\n=== Gestor Musical ===");
      System.out.println("1. Indexar archivos");
      System.out.println("2. Buscar canciones");
      System.out.println("3. Mostrar archivos indexados");
      System.out.println("4. Salir");

      while(!scanner.hasNextInt()){
        System.out.println("Opción inválida. Por favor, ingrese un número válido");
        scanner.next();
      }

      option = scanner.nextInt();

      menuOptions();
    }while(option != 4);
  }

  private void menuOptions(){
    switch(option){
      case 1: sistemaArchivos.setPath();
              sistemaArchivos.indexFiles();
    }
  }
}
