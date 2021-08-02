//
//  ViewController.swift
//  JSONPARSE
//
//  Created by Mac on 09/05/1943 Saka.
//

import UIKit

struct Album: Decodable {
    var userId: Int
    var id: Int
    var title: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var albumTable: UITableView!
    var albumArray: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        parseJson()
    }

    func parseJson() {
        let str = "https://jsonplaceholder.typicode.com/albums"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                self.albumArray = try JSONDecoder().decode([Album].self, from: data!)
                    DispatchQueue.main.async {
                        self.albumTable.reloadData()
                    }
                } catch {
                    print("Something went wrong")
                }
            }
        }.resume()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(albumArray[indexPath.row].id)"
        cell?.detailTextLabel?.text = "\(albumArray[indexPath.row].title)"
        return cell!
    }
}
