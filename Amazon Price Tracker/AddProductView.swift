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
    @EnvironmentObject var products: ProductsStore
    @State var link : String = ""
    //var productoNuevo : Product
    
    var body: some View {
        
        VStack {
            //Agregar una imagende fondo
        VStack(){
            Image(systemName: "chevron.compact.down") //Indicador. Proximamente: Será un boton para bajar la vista
                .font(.largeTitle)
                .foregroundColor(Color.secondary)
            
            Text("Añadir un Producto")
            .font(.largeTitle)
            .fontWeight(.bold)
            }

        Spacer()
          VStack {
              VStack(alignment: .leading){
                  Text("Dirección del Producto")
                      .font(.headline)
                      
                  TextField(" Pega la direccion aquí", text: $link)
                      .cornerRadius(0)
.textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Text("Precio objetivo")
                      .font(.headline)
                    .padding(.top, 10)
                      
                  TextField(" Ingresa la cantidad", text: $link)
                    .keyboardType(.numberPad)
                      .cornerRadius(0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                  
              }.padding()
              
                //Boton para añadir
              Button(action: {
  //                Request al API
                if(self.link != ""){
                    getData(link: self.link){ (output) in
                        //output
                        self.products.AddProduct(producto: output)
                    }
                    print("se ha añadido a la lista")
                    
                }else{
                    //Saltar alert
                }
                  
                  
                  
              }) {
                  Text("Añadir Producto").fontWeight(.bold)
                  .padding()
              }   .background(Color.yellow)
                  .foregroundColor(Color.white)
                  .cornerRadius(20)
                

          }
            Spacer()
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static let products = ProductsStore()
    static var previews: some View {
        AddProductView().environmentObject(products)
    }
}



func getData(link: String, completionBlock: @escaping (Product) -> Void) -> Void{
        
    //var final : Product
        //final = Product(id: "", name: "Nombre del Producto", brand: "Amazon", desc: "", currency: "", priceInt: 0, priceString: "$0.0", imgurl: "", url: "", GoalPrice: 0)
    
        var id = ""
        var name = "Producto Nombre"
        var brand = "Amazon"
        var desc = ""
        var currency = ""
        var priceInt = 0
        var priceRaw = "$1,234.56"
        var imgurl = ""
        var urlP = ""
        
        print("getting data")
        
        let api = "https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2F"
    
        //let producto = link.replacingOccurrences(of: "/", with: "%")
        let producto_final = link.replacingOccurrences(of: "https://", with: "")
        
        //URL para realizar la busqueda del producto
        let url = api + producto_final
        //print("url del producto: " + url)

        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string : url)! ) { (data, response, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            
            //Data for the product
            id = json["request_metadata"]["id"].stringValue
            name = json["product"]["title"].stringValue
            brand = json["product"]["sub_title"]["text"].stringValue
            desc = ""
            currency = json["product"]["buybox_winner"]["price"]["currency"].stringValue
            priceInt = json["product"]["buybox_winner"]["price"]["value"].intValue
            priceRaw = json["product"]["buybox_winner"]["price"]["raw"].stringValue
            imgurl = json["product"]["main_image"]["link"].stringValue
            urlP = json[["product"]]["link"].stringValue
            
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
            
            //Falta añadir el precio objetivo
            let final = Product(id: id, name: name, brand: brand, desc: desc, currency: currency, priceInt: priceInt, priceString: priceRaw, imgurl: imgurl, url: urlP, GoalPrice: 123)
            
            completionBlock(final) //Regresar el objeto creado del producto
 
        }.resume()
    
    //Falta: Añadir precio objetivo
//    final = Product(id: id, name: name, brand: brand, desc: desc, currency: currency, priceInt: priceInt, priceString: priceRaw, imgurl: imgurl, url: urlP, GoalPrice: 123)
//
//    print("nombre del producto: " + final.name)
   //return final
}

//let url = "https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1"

//Link de pruebas
//www.amazon.com.mx%2FFunko-Pop-Movies-Black-Buddy%2Fdp%2FB07WTQH232%3Fpf_rd_r%3DW1G2G930GH2N40E2GZSE%26pf_rd_p%3D9bf98ec6-3e20-46ba-bf2c-1893c7bd4635%26pd_rd_r%3D0cfeacec-2db7-4ead-9495-c8650aacdcfd%26pd_rd_w%3DxWmOZ%26pd_rd_wg%3Dt4NgH%26ref_%3Dpd_gw_bia_d0


//Link de prueba: www.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1

//www.amazon.com.mx%2FFIFA-20-Standard-PlayStation-4%2Fdp%2FB07SG1HJBQ%3Fpf_rd_r%3D19BD3BT05T4JETMNB6GS%26pf_rd_p%3Dfe4a2b07-f748-5800-b3bd-5f04ddb6b36f%26pd_rd_r%3Dcb58ac88-3918-4927-9060-88a6ed5d280a%26pd_rd_w%3DobdFq%26pd_rd_wg%3DQSX7l%26ref_%3Dpd_gw_ri
