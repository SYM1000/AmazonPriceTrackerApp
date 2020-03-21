//
//  SettingsView.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 16/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var enableNotifications = false
    @State private var prueba = ""
    
    @State private var icon = ""
    
    var body: some View {
        
        NavigationView {
            Form{
                
                //Seccion General
                Section(header: Text("General").font(.title)){ /*.padding(.top, 20)*/
                    
                    Toggle(isOn: $enableNotifications) {
                        Text("Activar Notificaciones")
                    }
                    
                    Picker(selection: $icon,
                           label: Text("Icono de la Aplicación")) {
                            ForEach(Icono.iconos, id: \.self) { iconi in
                                Text(iconi).tag(iconi)
                            }
                    }
                    
                    
                    Text("Apariencia")
                    
                    Picker(selection: $prueba,
                           label: Text("Probando Cosas locas")) {
                            ForEach(Test.allLocations, id: \.self) { location in
                                Text(location).tag(location)
                            }
                    }
                    
                    
                }
                
                
                //Seccion Soporte
                Section(header: Text("Soporte").font(.title) ) {
                    HStack {
                        Text("Name")
                        Spacer()
                        Text("iPhone 11")
                    }
                
                }
            
            }
            
            .navigationBarTitle("Ajustes")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}



struct Test {
    
    static let allLocations = [
        "New York",
        "London",
        "Tokyo",
        "Berlin",
        "Paris"
    ]
}


struct Icono {
    
    static let iconos = [
        "Icon - 1",
        "Icon - 2",
        "Icon - 3",
        "Icon - 4",
        "Icon - 5"
    ]
}
