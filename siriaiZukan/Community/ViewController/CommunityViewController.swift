//
//  ViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import UIKit

class CommunityViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communityCell")
        tableView.dataSource = self
    }
}

extension CommunityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "communityCell", for: indexPath) as! CommunityTableViewCell
        cell.setInfo(name: "Life is Tech!", image: UIImage(systemName: "person.fill")!)
        return cell
    }
}
