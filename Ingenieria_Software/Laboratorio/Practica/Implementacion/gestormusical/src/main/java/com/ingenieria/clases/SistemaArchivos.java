package com.ingenieria.clases;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Scanner;
import org.jaudiotagger.*;

public class SistemaArchivos {
  private String path;
  private Scanner scanner;
  private File directory;

  public SistemaArchivos(){
    this.path = "";
    this.scanner = new Scanner(System.in);
  }

  public void setPath(){
    while (true) {
      System.out.print("Por favor, ingrese la ruta del directorio: ");
      path = scanner.nextLine();

            // Validar la ruta ingresada
      directory = new File(path);

      if (!directory.exists()) {
        System.out.println("La ruta ingresada no existe. Intente de nuevo.");
      } else if (!directory.isDirectory()) {
        System.out.println("La ruta ingresada no es un directorio. Intente de nuevo.");
      } else {
        System.out.println("Ruta válida: " + directory.getAbsolutePath());
        break;
      }
    }
  }

  public void indexFiles() {
    try {
        Files.walk(Paths.get(path))
             .filter(Files::isRegularFile) // Filtrar solo archivos regulares
             .filter(file -> file.toString().toLowerCase().endsWith(".mp3")) // Filtrar por extensión MP3
             .forEach(file -> extractMetadata(file)); // Procesar cada archivo
    } catch (IOException e) {
        System.err.println("Error al recorrer los archivos: " + e.getMessage());
    }
  }

  private void extractMetadata(Path file){
    try {
        // Leer el archivo de audio
        AudioFile audioFile = AudioFileIO.read(file.toFile());
        Tag tag = audioFile.getTag();

        if (tag != null) {
            System.out.println("Archivo: " + file.toString());
            System.out.println("Título: " + tag.getFirst("TITLE"));
            System.out.println("Artista: " + tag.getFirst("ARTIST"));
            System.out.println("Álbum: " + tag.getFirst("ALBUM"));
            System.out.println("Año: " + tag.getFirst("YEAR"));
            System.out.println("-------------------------");
        } else {
            System.out.println("No se encontraron metadatos para: " + file.toString());
        }
    } catch (Exception e) {
        System.err.println("Error al leer metadatos de " + file.toString() + ": " + e.getMessage());
    }
  }
}
