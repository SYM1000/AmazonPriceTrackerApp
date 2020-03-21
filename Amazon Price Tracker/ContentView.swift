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
        VStack{
        VStack {
            if(self.index == 0){
                
                NavigationView {
                    Home()
       
                    .navigationBarTitle("Productos")
                }
                
            }else if(self.index == 1){
                SettingsView()
            }
        }
        .padding(.bottom, -35)
            CustomTab(index: self.$index, mostrar: self.$mostrarVista)
        }
        //.background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
            
        .sheet(isPresented: $mostrarVista){
//            AddProductView(link: "", cantidad: 0, isPresented: self.$mostrarVista).environmentObject(self.products)
            AddProductView(link: "", cantidad: 0, isPresented: self.$mostrarVista).environmentObject(self.products)
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
        .padding(.top, 30)
        .background(Color.white)
        .clipShape(CShape())
    }
}

struct CShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 35))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 35))
            
            path.addArc(center: CGPoint(x: (rect.width/2), y: 30), radius: 30, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
 
        }
    }
  
}

//Where al productos are displayed(main view)
struct Home : View {
    
    @EnvironmentObject var products: ProductsStore

    var body : some View{

        List{
            ForEach(products.ProductsList) { producto in
                ProductRow(Producto: producto)
                
            }.onDelete(perform: self.deleteItem)
            
            ProductRow(Producto: Product(id: "sdgafg34tdf", name: "Nintendo Consola Switch Neon 32GB Version 1.1 - Standard Edition", brand: "Nintendo", desc: "", currency: "USD", priceFloat: 7699.0, priceString: "$7,699.00", imgurl: "https://images-na.ssl-images-amazon.com/images/I/61JnrafZ7zL._AC_SL1457_.jpg", url: "https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fapi.rainforestapi.com/request?api_key=F11BA09B9AFB4CCDB3FE6E902C0A7CA1&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FNintendo-Consola-Switch-Neon-Version%2Fdp%2FB07VGRJDFY%3Fpf_rd_r%3DSD4SHKF9E08KBW248T2D%26pf_rd_p%3Dfe4a2b07-f748-5800-b3bd-5f04ddb6b36f%26pd_rd_r%3D1e9a0d0d-c99f-46de-aaa6-bf3638394220%26pd_rd_w%3D5xKfo%26pd_rd_wg%3D8yoUt%26ref_%3Dpd_gw_ri", GoalPrice: 0) )
                
            ProductRow(Producto: Product(id: "e72c5b13fb460c3390d02938001e17c644f502f7", name: "Bell Qualifier Casco urbano de cara completa para adultos unisex, Negro mate sólido , XS", brand: "Bell", desc: "sdf", currency: "sdf", priceFloat: 2978.00, priceString: "$2,978.76", imgurl: "https://images-na.ssl-images-amazon.com/images/I/71m8wxvEqDL._AC_SL1500_.jpg", url: "https://www.amazon.com.mx/Bell-Qualifier-completa-adultos-Deporte-motocicletas/dp/B00HLUWJCO", GoalPrice: 324))
                
            ProductRow(Producto: Product(id: "dsabuhfdg7wef7g62fuvws", name: "Funko Pop! Marvel: Avengers Endgame - Captain America with Broken Shield & Mjoinir", brand: "Funko", desc: "Nada", currency: "Dinero", priceFloat: 259.00, priceString: "$259.00", imgurl: "https://images-na.ssl-images-amazon.com/images/I/61QHDGY%2BEsL._AC_SL1300_.jpg", url: "https://www.amazon.com.mx/Funko-Pop-Marvel-Avengers-Endgame/dp/B07TXLJYT6?pf_rd_r=W1G2G930GH2N40E2GZSE&pf_rd_p=13169a20-3cf8-4606-985e-da1462aeac33", GoalPrice: 200))
            
            ProductRow(Producto: Product(id: "46f4df1bcfaeecccebb60c878e76c0074e6e9869", name: "NutriBullet Prime 1000w con 12 accesorios", brand: "NutriBullet", desc: "", currency: "USD", priceFloat: 3699.0, priceString: "$3,699.00", imgurl: "https://images-na.ssl-images-amazon.com/images/I/41b%2Bg94VHpL._AC_.jpg", url: "", GoalPrice: 3500))
            //https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FNutriBullet-Prime-1000w-12-accesorios%2Fdp%2FB07YDZKYMF%2Fref=sr_1_1_sspa%3F__mk_es_MX=%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591&keywords=nutribullet&qid=1584778477&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEzSU1OUDI0VzU2T1JWJmVuY3J5cHRlZElkPUEwNDUyODM1MzY4MjhEVjdHV1lWRCZlbmNyeXB0ZWRBZElkPUEwNTQ4NTEyV1dOOFA4WVM2V0o4JndpZGdldE5hbWU9c3BfYXRmJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ==
        }
        }
    
    private func deleteItem(at indexSet: IndexSet) {
        self.products.ProductsList.remove(atOffsets: indexSet)
    }
    
    }












//ProductRow(Producto: Product(id: "e72c5b13fb460c3390d02938001e17c644f502f7", name: "Bell Qualifier Casco urbano de cara completa para adultos unisex, Negro mate sólido , XS", brand: "Bell", desc: "sdf", currency: "sdf", priceFloat: 2978.00, priceString: "$2,978.76", imgurl: "https://images-na.ssl-images-amazon.com/images/I/71m8wxvEqDL._AC_SL1500_.jpg", url: "https://www.amazon.com.mx/Bell-Qualifier-completa-adultos-Deporte-motocicletas/dp/B00HLUWJCO", GoalPrice: 324))
//
//
//ProductRow(Producto: Product(id: "dsabuhfdg7wef7g62fuvws", name: "Funko Pop! Marvel: Avengers Endgame - Captain America with Broken Shield & Mjoinir", brand: "Funko", desc: "Nada", currency: "Dinero", priceFloat: 259.00, priceString: "$259.00", imgurl: "https://images-na.ssl-images-amazon.com/images/I/61QHDGY%2BEsL._AC_SL1300_.jpg", url: "https://www.amazon.com.mx/Funko-Pop-Marvel-Avengers-Endgame/dp/B07TXLJYT6?pf_rd_r=W1G2G930GH2N40E2GZSE&pf_rd_p=13169a20-3cf8-4606-985e-da1462aeac33", GoalPrice: 200))


