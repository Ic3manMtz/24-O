import { Component } from '@angular/core';
import { CancionService } from '../../services/cancion.service';

@Component({
  selector: 'app-cancion',
  templateUrl: './cancion.component.html',
  styleUrl: './cancion.component.css'
})
export class CancionComponent {
  songs: any[] = [];
  searchParams = { title: '', artist: '', album: '', year: '' };
  directoryPath = '';

  constructor(private songService: CancionService) {}

  ngOnInit(): void {
    this.getAllSongs();
  }

  getAllSongs(): void {
    this.songService.getAllSongs().subscribe((data) => (this.songs = data));
  }

  searchSongs(): void {
    this.songService.searchSongs(this.searchParams).subscribe((data) => (this.songs = data));
  }

  indexSongs(): void {
    this.songService.indexSongs(this.directoryPath).subscribe(() => this.getAllSongs());
  }

  deleteAllSongs(): void {
    this.songService.deleteAllSongs().subscribe(() => this.getAllSongs());
  }
}
