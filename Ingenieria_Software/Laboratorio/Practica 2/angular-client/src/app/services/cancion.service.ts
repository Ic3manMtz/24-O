import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class CancionService {
  private apiUrl = 'http://localhost:8080/api/canciones';

  constructor(private http: HttpClient) {}

  // Obtener todas las canciones
  getAllSongs(): Observable<any> {
    return this.http.get(`${this.apiUrl}`);
  }

  // Buscar canciones con filtros
  searchSongs(params: any): Observable<any> {
    return this.http.get(`${this.apiUrl}/search`, { params });
  }

  // Indexar canciones
  indexSongs(directoryPath: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/index`, null, {
      params: { directoryPath },
    });
  }

  // Eliminar canciones
  deleteAllSongs(): Observable<any> {
    return this.http.delete(`${this.apiUrl}`);
  }
}
