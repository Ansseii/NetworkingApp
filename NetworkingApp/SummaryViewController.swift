//
//  SummaryViewController.swift
//  NetworkingApp
//
//  Created by Aleksandr on 22.09.2020.
//

import UIKit

class SummaryViewController: UIViewController {
  
  @IBOutlet weak var characterImageView: UIImageView!
  
  var character: Character!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DispatchQueue.main.async {
      guard let imageUrl = URL(string: self.character.img ?? "") else { return }
      guard let imageData = try? Data(contentsOf: imageUrl) else { return }
      self.characterImageView.image = UIImage(data: imageData)
    }
  }
}
