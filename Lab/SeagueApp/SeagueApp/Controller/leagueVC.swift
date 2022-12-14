//
//  leagueVC.swift
//  SeagueApp
//
//  Created by YIP ZI XIAN on 08/12/2022.
//

import UIKit

class leagueVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    // Initialize Player
    var player: Player!
    
    @IBAction func onNextTapped(_ sender: Any) {
        // Built-in Function to redirect to another storyboard
        performSegue(
            withIdentifier: "skillVCSeague",
            sender: self
        )
    }
    
    // Parsing data to another storyboard
    // Need to initialize Player in skillVC.swift first
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        // ? is like ! means optional, not mandatory
        if let skill = segue.destination as? skillVC {
            skill.player = player
        }
    }
    
    @IBAction func onMensTapped(_ sender: Any) {
        selectedLeague("mens")
    }
    
    @IBAction func onWomensTapped(_ sender: Any) {
        selectedLeague("womens")
    }
    
    @IBAction func onCoedTapped(_ sender: Any) {
        selectedLeague("coed")
    }
    
    func selectedLeague(_ leagueType: String) {
        player.desiredLeague = leagueType
        nextButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = Player()
    }
}
