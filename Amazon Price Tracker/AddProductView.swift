//
//  AddProductView.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 18/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI

struct AddProductView: View {
    @State var link : String = ""
    
    var body: some View {
        
        VStack {
            VStack {
                Text("Escribe el URL del producto")
                TextField(" URL del producto", text: $link)
                    .background(Color.gray)
                    .cornerRadius(20)
                
                
            }.padding()
            
            Button(action: {
//                Request al API
                //Link de prueba: https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1
                
                getData(link: self.link)
   
                
                
            }) {
                Text("Añadir Producto").fontWeight(.bold)
                .padding()
            }.background(Color.yellow)
                .foregroundColor(Color.white)
            .cornerRadius(20)

        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}



func getData(link: String){
    
    //@Published var data = [Product]()
        print("getting data")
        
        let api = "https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2F"
        
        let producto = link
        let producto_final = producto.replacingOccurrences(of: "https://", with: "")
        //URL para realizar la busqueda del producto
        let url = api + producto_final
        print("url del producto: " + url)
        //let url = "https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1"
        
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string : url)!){ (data, _, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            
            //Data for the product
            
            var id = json["request_metadata"]["id"].stringValue
            var name = json["product"]["title"].stringValue
            var brand = json["product"]["sub_title"]["text"].stringValue
            var desc = ""
            var currency = json["product"]["buybox_winner"]["price"]["currency"].stringValue
            var priceInt = json["product"]["buybox_winner"]["price"]["value"].intValue
            var priceRaw = json["product"]["buybox_winner"]["price"]["raw"].stringValue
            var imgurl = json["product"]["main_image"]["link"].stringValue
            var url = json[["product"]]["link"].stringValue
            
            print(" ------->   Producto   <--------")
            print("ID: " + id)
            print("Nombre: " + name)
            print("Marca1: " + brand)
            print("Descripción: " + desc )
            print("Precion en string: " + priceRaw)
            print("Moneda: " + currency)
            print("Precio en entero: ", priceInt)
            print("Imagen: " + imgurl)
            print("URL: " + url)
            
            
            
//            DispatchQueue.main.async {
//                self.data.append(Product(id: id, name: "", brand: "", desc: "", currency: "", priceInt: 0, priceString: "", imgurl: "", url: ""))
//            }
            
            
        }.resume()
}


struct Product : Identifiable{
    var id : String
    var name : String
    var brand : String
    var desc : String
    var currency : String
    var priceInt : Int
    var priceString : String
    var imgurl : String
    var url : String
}
