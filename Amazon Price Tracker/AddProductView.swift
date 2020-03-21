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
import SPAlert

struct AddProductView: View {
    @EnvironmentObject var products: ProductsStore
    @State var link : String = ""
    @State var cantidad : Int
    @Binding var isPresented: Bool
    @State private var showingAlert = false
    
    var body: some View {
        
        VStack {
            //Agregar una imagende fondo
        VStack{
            Button(action: {
                self.isPresented = false
            }) {
                Image(systemName: "chevron.compact.down") //Indicador. Proximamente: Será un boton para bajar la vista
                .font(.largeTitle)
                .foregroundColor(Color.secondary)
                .padding(.top, 10)
            } //Boton indicador de flecha hacia abajo

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
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Precio objetivo")
                    .font(.headline)
                    .padding(.top, 10)
                      
                    TextField(" Ingresa la cantidad", text: $link) //cantidad
                    //.keyboardType(.numberPad)
                    .cornerRadius(0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                  
              }.padding()
              
                //Boton para añadir
              Button(action: {
  //                Request al API
                if(verificarUrl(urlString: self.link)){ //Añadir metodo para validar el link
                    
                    //print(GetApiRequest(link: self.link)) ------> Para verificar el link que regresa
                    getData(link: self.link, cantidad: self.cantidad){ (output) in
                        //output
                        self.products.AddProduct(producto: output)
                    }
                    print("se ha añadido a la lista")
                    SPAlert.present(title: "Producto agregado", preset: .done)
                    //Agregar un sleep
                    self.isPresented = false
                    
                }else{
                    //Saltar alert
                    self.showingAlert = true
                }
                  
                  
                  
              }) {
                  Text("Añadir Producto").fontWeight(.bold)
                  .padding()
                
              }
              .background(Color.yellow)
              .foregroundColor(Color.white)
              .cornerRadius(20)
                
          }
            Spacer()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Error con URL"), message: Text("Agregar un link válido"), dismissButton: .default(Text("De acuerdo")))
    }
 }
}

//struct AddProductView_Previews: PreviewProvider {
//    static let products = ProductsStore()
//    static var previews: some View {
//        AddProductView().environmentObject(products)
//    }
//}



func getData(link: String, cantidad: Int, completionBlock: @escaping (Product) -> Void) -> Void{
        
        print("getting data")
    
    //https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1
        
        
        let url = GetApiRequest(link: link)
        print(url)
        //var url = link //Solo para pruebas USANDO api_key: DEMOS
    
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string : url)! ) { (data, response, err) in //cambiar pruba por "url"
            
            if err != nil{
                print("Ocurrió un error:")
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            var id = ""
            var name = "Producto Nombre"
            var brand = "Amazon"
            var desc = ""
            var currency = ""
            var priceFloat : Float
            var priceRaw = "$1,234.56"
            var imgurl = ""
            var urlP = ""
            
            //Data for the product
            id = json["request_metadata"]["id"].stringValue
            name = json["product"]["title"].stringValue
            brand = json["product"]["sub_title"]["text"].stringValue
            desc = ""
            currency = json["product"]["buybox_winner"]["price"]["currency"].stringValue
            priceFloat = json["product"]["buybox_winner"]["price"]["value"].floatValue
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
            print("Precio en entero: ", priceFloat)
            print("Imagen: " + imgurl)
            print("URL: " + url)
            
            //Falta añadir el precio objetivo
            var final = Product(id: UUID().uuidString, name: "Producto", brand: "Amazon", desc: desc, currency: "", priceFloat: 0.0, priceString: "$0.0", imgurl: imgurl, url: urlP, GoalPrice: 0)
            
            if(name != ""){
                
                final = Product(id: id, name: name, brand: brand, desc: desc, currency: currency, priceFloat: priceFloat, priceString: priceRaw, imgurl: imgurl, url: urlP, GoalPrice: cantidad)
            }
            
            
            completionBlock(final) //Regresar el objeto creado del producto
 
        }.resume()
    
    //Falta: Añadir precio objetivo
//    final = Product(id: id, name: name, brand: brand, desc: desc, currency: currency, priceInt: priceInt, priceString: priceRaw, imgurl: imgurl, url: urlP, GoalPrice: 123)
//
//    print("nombre del producto: " + final.name)
   //return final
}

func verificarUrl (urlString: String?) -> Bool {
    if let urlString = urlString {
        if let url = NSURL(string: urlString) {
            return UIApplication.shared.canOpenURL(url as URL)
        }
    }
    return false
}

func GetApiRequest(link : String ) -> String{
    
    
    let encodedString = link.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let api_result = ApiParams.linkBase + "api_key=" + ApiParams.api_key + "&type=" + ApiParams.type + "&url=" + encodedString
    //let typeUrl = URL(string: api_result)!
//    if let encodedString  = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed), let url = URL(string: encodedString) {
//        print(url) // www.mydomain.com%2Fkey=%E0%A4%85%E0%A4%95%E0%A5%8D%E0%A4%B7%E0%A4%AF
//    }
    
    return api_result
}













//let url = "https://api.rainforestapi.com/request?api_key=demo&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1"

//Link de pruba: https://api.rainforestapi.com/request?api_key=F11BA09B9AFB4CCDB3FE6E902C0A7CA1&type=product&url=https%3A%2F%2Fwww.amazon.com.mx%2FNintendo-Consola-Switch-Neon-Version%2Fdp%2FB07VGRJDFY%3Fpf_rd_r%3DSD4SHKF9E08KBW248T2D%26pf_rd_p%3Dfe4a2b07-f748-5800-b3bd-5f04ddb6b36f%26pd_rd_r%3D1e9a0d0d-c99f-46de-aaa6-bf3638394220%26pd_rd_w%3D5xKfo%26pd_rd_wg%3D8yoUt%26ref_%3Dpd_gw_ri

//Link de pruebas
//www.amazon.com.mx%2FFunko-Pop-Movies-Black-Buddy%2Fdp%2FB07WTQH232%3Fpf_rd_r%3DW1G2G930GH2N40E2GZSE%26pf_rd_p%3D9bf98ec6-3e20-46ba-bf2c-1893c7bd4635%26pd_rd_r%3D0cfeacec-2db7-4ead-9495-c8650aacdcfd%26pd_rd_w%3DxWmOZ%26pd_rd_wg%3Dt4NgH%26ref_%3Dpd_gw_bia_d0


//Link de prueba: www.amazon.com.mx%2FSAMSUNG-Monitor-1920x1080-Flicker-LS24R350FHLXZX%2Fdp%2FB07Z8PW58J%2Fref%3Dsr_1_1%3F__mk_es_MX%3D%25C3%2585M%25C3%2585%25C5%25BD%25C3%2595%25C3%2591%26keywords%3Dmonitor%26qid%3D1584387122%26sr%3D8-1

//www.amazon.com.mx%2FFIFA-20-Standard-PlayStation-4%2Fdp%2FB07SG1HJBQ%3Fpf_rd_r%3D19BD3BT05T4JETMNB6GS%26pf_rd_p%3Dfe4a2b07-f748-5800-b3bd-5f04ddb6b36f%26pd_rd_r%3Dcb58ac88-3918-4927-9060-88a6ed5d280a%26pd_rd_w%3DobdFq%26pd_rd_wg%3DQSX7l%26ref_%3Dpd_gw_ri
