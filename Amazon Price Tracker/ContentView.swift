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
    
    var body: some View {
        VStack {
            
            Spacer()
            
            CustomTab(index: self.$index)
        }
        .background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.top))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CustomTab :View{
    
    @Binding var index : Int
    
    var body : some View{
        
        HStack{
            
            //Boton: Vista principal
            Button(action: {
                //Logica del boton
                self.index = 0;
            }) {
                Image(systemName: "house.fill")
            }
            .foregroundColor(Color.black.opacity(self.index == 0 ? 1 : 0.2))
            .font(.system(size: 24))
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            Button(action: {
                
            }) {
                Image(systemName: "plus.circle.fill")
            }.offset(y: -20)
            .font(.system(size: 40))
            
            
            Spacer(minLength: 0)
            
            
            //Boton: Vista Ajustes
            Button(action: {
                //Logica del boton
                self.index = 1;
            }) {
                Image(systemName: "gear")
            }
            .foregroundColor(Color.black.opacity(self.index == 1 ? 1 : 0.2))
            .font(.system(size: 24))
        }
        .padding(.horizontal, 35)
        .background(Color.white)
    }
}
