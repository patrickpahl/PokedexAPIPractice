//
//  PokemonController.swift
//  PokedexAPIPractice
//
//  Created by Patrick Pahl on 8/30/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation




class PokemonController {
    
    static let baseURL = "http://pokeapi.co/api/v2/pokemon/"   //Not NSURL?
    
    static func getPokemon(searchTerm: String, completion: (pokemon: Pokemon?) -> Void){
        
        let searchURL = baseURL + searchTerm.lowercaseString
        
        guard let url = NSURL(string: searchURL) else { completion(pokemon: nil); print("Error: bad url"); return}
        
        //no parameters this time, so use the perform request w/o params
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data,
            JSONDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject]
             else { completion(pokemon: nil); return}
            
            let pokemon = Pokemon(dictionary: JSONDictionary)
            
            dispatch_async(dispatch_get_main_queue(), { 
                completion(pokemon: pokemon)
            })
            
        }
    }
    
    
    //To get image:
    static func getSpriteEndpointForPokemon(pokemon: Pokemon, completion: (endpoint: String?) -> Void) {
        guard let url = NSURL(string: pokemon.imageEndpoint) else { completion(endpoint: nil); return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data, JSONDictionary = (try?NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject], spritesDictionary = JSONDictionary["sprites"] as? [String: AnyObject], spriteEndpoint = spritesDictionary["front_default"] as? String else { completion(endpoint: nil);return }
            
            completion(endpoint: spriteEndpoint)
        }
    }
    
    
}