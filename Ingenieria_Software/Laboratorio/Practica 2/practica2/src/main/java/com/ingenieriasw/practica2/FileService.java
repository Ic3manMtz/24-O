package com.ingenieriasw.practica2;

import org.jaudiotagger.audio.AudioFile;
import org.jaudiotagger.audio.AudioFileIO;
import org.jaudiotagger.tag.FieldKey;
import org.jaudiotagger.tag.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@Service
public class FileService {

    @Autowired
    private ISongRepository songRepository;

    public void indexFiles(String directoryPath) {
        try {
            Files.walk(Paths.get(directoryPath))
                .filter(Files::isRegularFile)
                .filter(file -> file.toString().toLowerCase().endsWith(".mp3"))
                .forEach(this::extractMetadata);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void extractMetadata(Path file) {
        try {
            AudioFile audioFile = AudioFileIO.read(file.toFile());
            Tag tag = audioFile.getTag();
            if (tag != null) {
                Song song = new Song();
                song.setPath(file.toString());
                song.setTitle(tag.getFirst(FieldKey.TITLE));
                song.setArtist(tag.getFirst(FieldKey.ARTIST));
                song.setAlbum(tag.getFirst(FieldKey.ALBUM));
                song.setYear(tag.getFirst(FieldKey.YEAR));
                songRepository.save(song);
            }
        } catch (Exception e) {
            System.err.println("Error leyendo metadatos de " + file + ": " + e.getMessage());
        }
    }
}
