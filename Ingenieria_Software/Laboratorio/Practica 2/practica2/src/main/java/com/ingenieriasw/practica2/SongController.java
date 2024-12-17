package com.ingenieriasw.practica2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/canciones")
public class SongController {

    @Autowired
    private FileService fileService;

    @Autowired
    private ISongRepository songRepository;

    // Indexar archivos desde un directorio
    @PostMapping("/index")
    public String indexFiles(@RequestParam String directoryPath) {
        fileService.indexFiles(directoryPath);
        return "Archivos indexados exitosamente.";
    }

    // Obtener todos los registros
    @GetMapping
    public List<Song> getAllSongs() {
        return songRepository.findAll();
    }

    // Buscar registros
    @GetMapping("/search")
    public List<Song> searchSongs(
            @RequestParam(required = false) String title,
            @RequestParam(required = false) String artist,
            @RequestParam(required = false) String album,
            @RequestParam(required = false) String year) {
        if (title != null) return songRepository.findByTitleContainingIgnoreCase(title);
        if (artist != null) return songRepository.findByArtistContainingIgnoreCase(artist);
        if (album != null) return songRepository.findByAlbumContainingIgnoreCase(album);
        if (year != null) return songRepository.findByYear(year);
        return songRepository.findAll();
    }

    // Eliminar todos los registros
    @DeleteMapping
    public String deleteAllSongs() {
        songRepository.deleteAll();
        return "Todos los registros han sido eliminados.";
    }
}
