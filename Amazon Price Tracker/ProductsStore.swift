//
//  Storage.swift
//  Amazon Price Tracker
//
//  Created by Santiago Yeomans on 18/03/20.
//  Copyright © 2020 Santiago Yeomans. All rights reserved.
//

import Foundation
import Combine


struct Product : Identifiable{
    var id : String
    var name : String
    var brand : String
    var desc : String
    var currency : String
    var priceFloat : Float
    var priceString : String
    var imgurl : String
    var url : String
    var GoalPrice : Int
}


class ProductsStore : ObservableObject {
    @Published var ProductsList = [Product]()
    
    //Metodos
    func AddProduct(producto : Product){
        //Agregar un Producto
        ProductsList.insert(producto, at: 0)
    }
    
    func DeleteAll(){
        //Eliminar todos los elementos del arreglo
        ProductsList.removeAll()
    }
    
    func DeleteProduct(at indexSet: IndexSet) {
        //Eliminar un elemento del arreglo
        ProductsList.remove(atOffsets: indexSet)
    }
    
    
    
    
}





struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }

    var endIndex: Index { base.endIndex }

    func index(after i: Index) -> Index {
        base.index(after: i)
    }

    func index(before i: Index) -> Index {
        base.index(before: i)
    }

    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}

