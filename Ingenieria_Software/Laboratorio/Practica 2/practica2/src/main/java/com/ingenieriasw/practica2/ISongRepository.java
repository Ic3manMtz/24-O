package com.ingenieriasw.practica2;


import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface ISongRepository extends JpaRepository<Song, Long> {
    List<Song> findByTitleContainingIgnoreCase(String title);
    List<Song> findByArtistContainingIgnoreCase(String artist);
    List<Song> findByAlbumContainingIgnoreCase(String album);
    List<Song> findByYear(String year);
}
