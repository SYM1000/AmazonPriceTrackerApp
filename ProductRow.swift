//
//  ProductRow.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 18/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI

struct ProductRow: View {
    
    //var Producto : Product
    
    var body: some View {
        
        HStack{
            
            Image("amazon1") //Imagen del Producto
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack {
                Text("Nombre del Producto") //Nombre del producto
                    .fontWeight(.bold)
                    .font(.title)
                
                Text("Marca")
                    .foregroundColor(Color.secondary)
                    .font(.headline)
                    .fontWeight(.medium)
            }
            
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow()
    }
}
