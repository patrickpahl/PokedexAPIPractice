//
//  Pokemon.swift
//  PokedexAPIPractice
//
//  Created by Patrick Pahl on 8/30/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import Foundation

//let dict = formsArray[0] is optional, so its safer to use formsArray.first
//Don't need to cast '.first' bc we defined it as dictionary before.


class Pokemon {
    
    private let nameKey = "name"
    private let formsKey = "forms"
    private let urlKey = "url"
    private let statsKey = "stats"
    private let base_statsKey = "base_stat"
    private let movesKey = "moves"
    private let moveKey = "move"
    private let moveNameKey = "name"
    
    let name: String
    let imageEndpoint: String
    let baseStat: Int
    var moves: [String] = []
    
    
    init?(dictionary: [String: AnyObject]){
        
        guard let name = dictionary[nameKey] as? String,
            
        formsArray = dictionary[formsKey] as? [[String: AnyObject]],
        formsDictionary = formsArray.first,
        URL = formsDictionary[urlKey] as? String,
        
        statsArray = dictionary[statsKey] as? [[String: AnyObject]],
        statsDictionary = statsArray.first,
        base_stat = statsDictionary[base_statsKey] as? Int,
        
        movesArray = dictionary[movesKey] as? [[String: AnyObject]],
        movesDictionary = movesArray.first,
        moveDict = movesDictionary[moveKey] as? [String: AnyObject],
        moveName = moveDict[moveNameKey] as? String
            else {
                print("Error: Failable initializer failed!")
                return nil
        }
        
        self.moves.append(moveName)
        
        self.name = name
        self.imageEndpoint = URL
        self.baseStat = base_stat
//        self.moves = moveName
        
    }
}