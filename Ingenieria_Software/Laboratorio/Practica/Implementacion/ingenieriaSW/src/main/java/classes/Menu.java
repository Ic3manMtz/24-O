package classes;

import java.util.Scanner;

public class Menu {
  private int option;
  private Scanner scanner;
  private FileSystem fileSystem;
  private Database database;

  public Menu(){
    this.option = 0;
    this.scanner = new Scanner(System.in);
    this.database = new Database();
    this.fileSystem = new FileSystem(database);
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
      scanner.nextLine();

      menuOptions();
    }while(option != 4);
    
    database.deleteAllRecords();
    database.closeConnection();
  }

  private void menuOptions(){
    switch(option){
	    case 1:
	    	fileSystem.setPath();
	    	fileSystem.indexFiles();
	    	break;
	    case 2:
	    	searchFile();
	    	break;
	    case 3:
	    	database.displayAllRecords();
	    	break;
	    default: break;    	  
    }
  }
  
  private void searchFile() {
  	System.out.println("Puedes buscar por título, artista, álbum o año");
  	System.out.println("Para salir, deje el campo vacío");
  	
  	System.out.println("Ingrese el título de la cancion (o presione Enter para omitir)");
  	String title = scanner.nextLine();
  	System.out.println("Ingrese el artista a buscar (o presione Enter para omitir)");
  	String artist = scanner.nextLine();
  	System.out.println("Ingrese el álbum a buscar (o presione Enter para omitir)");
  	String album = scanner.nextLine();
  	System.out.println("Ingrese el año a buscar (o presione Enter para omitir)");
  	String year = scanner.nextLine();
  	
  	database.searchFilesByQuery(title, artist, album, year);
  }
}
