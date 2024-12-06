package classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Database {
	private Connection connection;
	
	public Database() {
		connectToDatabase();
	}
	
	private void connectToDatabase() {
		try {
			Class.forName("org.sqlite.JDBC");
			
			connection = DriverManager.getConnection("jdbc:sqlite:musica:db");
			System.out.println("Conexion a la base de datos establecida");
			
            String createTableQuery = "CREATE TABLE IF NOT EXISTS canciones ("
                    + "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    + "path TEXT NOT NULL, "
                    + "title TEXT, "
                    + "artist TEXT, "
                    + "album TEXT, "
                    + "year TEXT)";
            try (Statement stmt = connection.createStatement()) {
                stmt.execute(createTableQuery);
                System.out.println("Tabla 'canciones' asegurada.");
            }
		} catch (ClassNotFoundException | SQLException e) {
			System.err.println("Error al conectar a la base de datos: "+ e.getMessage());
		}
	}
	
	public void saveMetadataToDatabase(String filePath, String title, String artist, String album, String year) {
		String query = "INSERT INTO canciones (path, title, artist, album, year) VALUES (?, ?, ?, ?, ?)";
			try (PreparedStatement pstmt = connection.prepareStatement(query)) {
	            pstmt.setString(1, filePath);
	            pstmt.setString(2, title);
	            pstmt.setString(3, artist);
	            pstmt.setString(4, album);
	            pstmt.setString(5, year);
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.err.println("Error al guardar metadatos en la base de datos: " + e.getMessage());
	        }
	    }
	    
	public void displayAllRecords() {
		String query = "SELECT * FROM canciones";
	    try (Statement stmt = connection.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
	    	while (rs.next()) {
	    		int id = rs.getInt("id");
	            String filePath = rs.getString("path");
	            String title = rs.getString("title");
	            String artist = rs.getString("artist");
	            String album = rs.getString("album");
	            String year = rs.getString("year");

	            System.out.println("ID: " + id);
	            System.out.println("Ubicacion: " + filePath);
	            System.out.println("Título: " + title);
	            System.out.println("Artista: " + artist);
	            System.out.println("Álbum: " + album);
	            System.out.println("Año: " + year);
	            System.out.println("-------------------------");
	    	}
	    } catch (SQLException e) {
	    	System.err.println("Error al obtener los registros de la base de datos: " + e.getMessage());
	    }
	}
	
	public void searchFilesByQuery(String title, String artist, String album, String year) {
		StringBuilder queryBuilder = new StringBuilder("SELECT * FROM canciones WHERE 1=1");

	    if (!year.isEmpty()) {
	        queryBuilder.append(" AND year LIKE '%").append(year).append("%'");
	    }
	    if (!artist.isEmpty()) {
	        queryBuilder.append(" AND artist LIKE '%").append(artist).append("%'");
	    }
	    if (!title.isEmpty()) {
	        queryBuilder.append(" AND title LIKE '%").append(title).append("%'");
	    }
	    if (!album.isEmpty()) {
	        queryBuilder.append(" AND album LIKE '%").append(album).append("%'");
	    }

	    if (year.isEmpty() && artist.isEmpty() && title.isEmpty() && album.isEmpty()) {
	        System.out.println("No se ingresaron filtros, se mostrarán todos los registros.");
	        displayAllRecords();  
	    } else {
	        String query = queryBuilder.toString();
	        System.out.println("\nConsulta SQL generada: " + query);
		    try (Statement statement = connection.createStatement(); ResultSet resultSet = statement.executeQuery(query)) {

		        while (resultSet.next()) {
		            System.out.println("ID: " + resultSet.getInt("ID"));
		            System.out.println("Archivo: " + resultSet.getString("path"));
		            System.out.println("Título: " + resultSet.getString("title"));
		            System.out.println("Artista: " + resultSet.getString("artist"));
		            System.out.println("Álbum: " + resultSet.getString("album"));
		            System.out.println("Año: " + resultSet.getInt("year"));
		            System.out.println("-------------------------");
		        }
		    } catch (SQLException e) {
		        System.err.println("Error al realizar la consulta: " + e.getMessage());
		    }
	    }

	}
	
    public void deleteAllRecords() {
        String sqlDelete = "DELETE FROM canciones";  
        String sqlVacuum = "VACUUM"; 
        
        try (Statement stmt = connection.createStatement()) {
            int rowsAffected = stmt.executeUpdate(sqlDelete);
            System.out.println("Se han eliminado " + rowsAffected + " registros de la tabla 'canciones'.");

            stmt.executeUpdate(sqlVacuum);
            System.out.println("Contador de AUTOINCREMENT reiniciado.");
            
        } catch (Exception e) {
            System.err.println("Error al eliminar los registros o reiniciar el AUTOINCREMENT: " + e.getMessage());
        }
    }
	
	public void closeConnection() {
		try {
			if (connection != null && !connection.isClosed()) {
				connection.close();
	            System.out.println("Conexión a la base de datos cerrada.");
			}
		} catch (SQLException e) {
			System.err.println("Error al cerrar la base de datos: " + e.getMessage());
		}
	}
}
