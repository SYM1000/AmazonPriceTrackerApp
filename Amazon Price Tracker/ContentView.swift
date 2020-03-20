//
//  ContentView.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 15/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State var index = 0
    @State var mostrarVista = false
    @EnvironmentObject var products: ProductsStore
    
    var body: some View {
        
        VStack {
            if(self.index == 0){
                
                NavigationView {
                    Home()
       
                    .navigationBarTitle("Productos")
                }
                
            }else if(self.index == 1){
                SettingsView()
            }
            
            
            Spacer()
            
            CustomTab(index: self.$index, mostrar: self.$mostrarVista)
        }
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
            
        .sheet(isPresented: $mostrarVista){
            AddProductView(link: "").environmentObject(self.products)
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
    
    @EnvironmentObject var products: ProductsStore

    var body : some View{
        
//        List(store.ProductsList, id: \.id) { mode  in
//                ProductRow(Producto: mode)
//            }
        
            List{
                ForEach(products.ProductsList) { producto in
                    ProductRow(Producto: producto)
                }
            }
        
        
        
        }
    }












//ProductRow(Producto: Product(id: "e72c5b13fb460c3390d02938001e17c644f502f7", name: "Bell Qualifier Casco urbano de cara completa para adultos unisex, Negro mate sólido , XS", brand: "Bell", desc: "sdf", currency: "sdf", priceInt: 2978, priceString: "$2,978.76", imgurl: "https://images-na.ssl-images-amazon.com/images/I/71m8wxvEqDL._AC_SL1500_.jpg", url: "https://www.amazon.com.mx/Bell-Qualifier-completa-adultos-Deporte-motocicletas/dp/B00HLUWJCO", GoalPrice: 324))
//
//
//ProductRow(Producto: Product(id: "dsabuhfdg7wef7g62fuvws", name: "Funko Pop! Marvel: Avengers Endgame - Captain America with Broken Shield & Mjoinir", brand: "Funko", desc: "Nada", currency: "Dinero", priceInt: 259, priceString: "$259.00", imgurl: "https://images-na.ssl-images-amazon.com/images/I/61QHDGY%2BEsL._AC_SL1300_.jpg", url: "https://www.amazon.com.mx/Funko-Pop-Marvel-Avengers-Endgame/dp/B07TXLJYT6?pf_rd_r=W1G2G930GH2N40E2GZSE&pf_rd_p=13169a20-3cf8-4606-985e-da1462aeac33", GoalPrice: 200))


