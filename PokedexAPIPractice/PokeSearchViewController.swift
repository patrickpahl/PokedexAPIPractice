//
//  PokeSearchViewController.swift
//  PokedexAPIPractice
//
//  Created by Patrick Pahl on 8/30/16.
//  Copyright © 2016 Patrick Pahl. All rights reserved.
//

import UIKit

class PokeSearchViewController: UIViewController, UISearchBarDelegate {
    
    //added searchBar delegateabove. No required funcs so won't yell at you when you first implement it. *Set delegate on the MSB for searchBar. 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
    }
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formImageView: UIImageView!
    @IBOutlet weak var baseStatLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else {return}
        
        PokemonController.getPokemon(searchTerm) { (pokemon) in
          
            guard let pokemon = pokemon else {return}
            
            self.nameLabel.text = pokemon.name
            self.baseStatLabel.text = "\(pokemon.baseStat)"
            self.movesLabel.text = "\(pokemon.moves)"
            
            PokemonController.getSpriteEndpointForPokemon(pokemon, completion: { (endpoint) in
              
                guard let endpoint = endpoint else {return}
                
                ImageController.imageForURL(endpoint, completion: { (image) in
                    guard let image = image else {return}
                    self.formImageView.image = image
                })
            })
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
