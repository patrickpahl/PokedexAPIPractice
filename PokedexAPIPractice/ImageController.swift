//
//  ImageController.swift
//  PokedexAPIPractice
//
//  Created by Patrick Pahl on 8/30/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation


import UIKit

class ImageController {
    
    static func imageForURL(url: String, completion: ((image: UIImage?) -> Void)) {
        
        guard let url = NSURL(string: url) else {fatalError("image is nil")}
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data else { completion(image: nil); return }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                completion(image: UIImage(data: data))      //Takes data and turns it into an optional image!
            })
        }
    }
}