//
//  ProductRow.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 18/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductRow: View {
    
    var Producto : Product
    //var Producto: Binding<Product>
    var body: some View {
        
        HStack{
            
            WebImage(url: URL(string: Producto.imgurl)) //Imagen
                .resizable()
                .placeholder(Image("amazon2"))
                .indicator(.activity)
                .animation(.easeInOut(duration: 0.5))
                .scaledToFit()
                .frame(width: 110, height: 110)
                .cornerRadius(15)
                .padding(.trailing, 10)
            
            VStack {
                Text(Producto.name) //Nombre del producto
                    .fontWeight(.bold)
                    .font(.title)
                    .lineLimit(1)
                
                Text(Producto.brand) //Marca del producto
                    .foregroundColor(Color.secondary)
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding(.bottom, -5)
                
               Divider()
                
                HStack{
                    Spacer()
                    VStack {
                        Text("Precio:")
                            .fontWeight(.bold)
                        Text(Producto.priceString)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Precio Objetivo:")
                            .fontWeight(.bold)
                        Text("$" + String(Producto.GoalPrice))
                    }
                    Spacer()
                }
                
            }
        }//.padding([.leading, .trailing], 10)
        .padding(10)
            
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        
        
        ProductRow(Producto: Product(id: "e72c5b13fb460c3390d02938001e17c644f502f7", name: "Bell Qualifier Casco urbano de cara completa para adultos unisex, Negro mate sólido , XS", brand: "Bell", desc: "sdf", currency: "sdf", priceFloat: 2978.0, priceString: "$2,978.76", imgurl: "https://images-na.ssl-images-amazon.com/images/I/71m8wxvEqDL._AC_SL1500_.jpg", url: "https://www.amazon.com.mx/Bell-Qualifier-completa-adultos-Deporte-motocicletas/dp/B00HLUWJCO", GoalPrice: 324))
    }
}

//Datos de un prodcuto para prueba
// ------->   Producto   <--------
//ID: e72c5b13fb460c3390d02938001e17c644f502f7
//Nombre: Bell Qualifier Casco urbano de cara completa para adultos unisex, Negro mate sólido , XS
//Marca1: Bell
//Descripción:
//Precion en string: $2,978.76
//Moneda: USD
//Precio en entero:  2978
//Imagen: https://images-na.ssl-images-amazon.com/images/I/71m8wxvEqDL._AC_SL1500_.jpg
//URL: https://www.amazon.com.mx/Bell-Qualifier-completa-adultos-Deporte-motocicletas/dp/B00HLUWJCO
