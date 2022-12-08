//
//  DetailViewController.swift
//  Consolidation_2-Flags
//
//  Created by Edwin Przeźwiecki Jr. on 19/03/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedFlag: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      title = selectedFlag
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let flagToLoad = selectedFlag {
            imageView.image = UIImage(named: flagToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        
        guard let flag = imageView.image?.jpegData(compressionQuality: 1) else {
            print("No flag found!")
            
            return
        }
        
        let detailViewController = UIActivityViewController(activityItems: [flag, selectedFlag!.fileName()], applicationActivities: [])
        detailViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(detailViewController, animated: true)
    }
}
