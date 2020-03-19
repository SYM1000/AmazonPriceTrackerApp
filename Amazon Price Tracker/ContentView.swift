//
//  ContentView.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 15/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var index = 0
    @State var mostrarVista = false
    
    var body: some View {
        VStack {
            
            
            if(self.index == 0){
                NavigationView{
                    Home()
                    .navigationBarTitle("Productos")
                        .edgesIgnoringSafeArea(.all)
                }
            }else if(self.index == 1){
                SettingsView()
            }
            
            
            Spacer()
            
            CustomTab(index: self.$index, mostrar: self.$mostrarVista)
        }
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
            
        .sheet(isPresented: $mostrarVista){
            AddProductView()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Tab bar view
struct CustomTab :View{
    
    @Binding var index : Int
    @Binding var mostrar : Bool
    
    
    var body : some View{
        
        HStack{
            Spacer(minLength: 0)
            //Boton: Vista principal
            Button(action: {
                //Logica del boton
                self.index = 0;
            }) {
                Image(systemName: "house.fill")
            }
            .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.2))
            .font(.system(size: 26))
            .padding(.top, 15)
            .padding(.bottom, 20)
            
            
            Spacer(minLength: 0)
            
            //Boton: Añadir
            Button(action: {
                self.mostrar.toggle()
                
            }) {
                Image(systemName: "plus.circle.fill")
            }.offset(y: -30)
            .font(.system(size: 42))
                .foregroundColor(Color.yellow)
            
            
            Spacer(minLength: 0)
            
            
            //Boton: Vista Ajustes
            Button(action: {
                //Logica del boton
                self.index = 1;
            }) {
                Image(systemName: "gear")
            }
            .foregroundColor(Color.black.opacity(self.index == 1 ? 1 : 0.2))
            .font(.system(size: 28))
            .padding(.top, 15)
            .padding(.bottom, 20)
            
            Spacer(minLength: 0)
        }
        //.padding(.horizontal, 35)
        .background(Color.white)
    }
}

//Where al productos are displayed(main view)
struct Home : View {
    //@ObservableObject var Productos = getData()
    //@Published var data = [Product]()
    
    var body : some View{
        
        
//        List(Productos.data){i in
//            Text(i.id)
//        }
        Text("sfg")
        
        
    }
}
