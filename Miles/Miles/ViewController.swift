//
//  ViewController.swift
//  Miles
//
//  Created by Lalo Martínez on 3/19/18.
//  Copyright © 2018 Lalo Martínez. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
  
  var sampler: Sampler!

  override func loadView() {
    super.loadView()
    
    self.view.backgroundColor = .white
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Touch", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(touched), for: .touchDown)
    button.addTarget(self, action: #selector(leaved), for: .touchUpInside)
    self.view.addSubview(button)
    
    button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    
    if let url = Bundle.main.url(forResource: "Roland", withExtension: "sf2") {
      sampler = Sampler(fileUrl: url)
    } else {
      fatalError("Could not load file")
    }
    
  }
  
  @objc private func touched() {
    print("shouldplay")
    sampler.startNote(note: 60)
    
  }
  
  @objc func leaved() {
    print("shouldstop")
    sampler.stopNote(note: 60)
  }

}

