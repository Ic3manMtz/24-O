import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http'; // Para peticiones HTTP
import { FormsModule } from '@angular/forms'; // Para formularios y [(ngModel)]

import { AppComponent } from './app.component';
import { CancionComponent } from './components/cancion/cancion.component';

@NgModule({
  declarations: [
    AppComponent,    // Componente raíz
    CancionComponent    // Componente adicional (ejemplo)
  ],
  imports: [
    BrowserModule,   // Módulo necesario para aplicaciones web
    HttpClientModule, // Módulo para consumir APIs
    FormsModule       // Módulo para usar [(ngModel)] en formularios
  ],
  providers: [],
  bootstrap: [AppComponent] // Componente inicial que se carga
})
export class AppModule {}
