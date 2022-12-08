//
//  ViewController.swift
//  Consolidation_2-Flags
//
//  Created by Edwin Przeźwiecki Jr. on 19/03/2022.
//

import UIKit

extension String {
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
}

class ViewController: UITableViewController {
    
    var flags = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        title = "Flags"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
     
        for item in items {
            if item.hasSuffix("png") {
                flags.append(item)
            }
        }
        print(flags.sort())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.imageView?.image = UIImage(named: flags[indexPath.row])
        
//      cell.textLabel?.text = flags[indexPath.row]
        
        let flagName = flags[indexPath.row].fileName()
        cell.textLabel?.text = flagName
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Country") as? DetailViewController {
            
            detailViewController.selectedFlag = flags[indexPath.row]
            
            let flagName = flags[indexPath.row].fileName()
            
            detailViewController.title = "\(flagName)"
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
