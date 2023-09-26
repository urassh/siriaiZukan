//
//  ViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

import UIKit

class CommunityViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    private var viewModel: CommunityViewModel!
    private var communityArray: Array<Community>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CommunityViewModel()
        communityArray = viewModel.getCommunities()
        
        tableView.register(UINib(nibName: "CommunityTableViewCell", bundle: nil), forCellReuseIdentifier: "communityCell")
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight = 80
    }
    
    @IBAction func addButtonTapped() {
        self.performSegue(withIdentifier: "toEditCommunity", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadView()
        self.navigationItem.hidesBackButton = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemberView" {
            let memberVC = segue.destination as! MemberViewController
            memberVC.community = sender as? Community

        }
    }
    
    private func reloadView() {
        communityArray = viewModel.getCommunities()
        tableView.reloadData()
    }
}

extension CommunityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        communityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "communityCell", for: indexPath) as! CommunityTableViewCell
        let community = communityArray[indexPath.row]
        let icon      = viewModel.loadImage(community: community) ?? UIImage(systemName: "person.fill")
        cell.setInfo(name: community.name, image: icon!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toMemberView", sender: self.communityArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // 編集処理
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [self] (action, view, completionHandler) in
            // 編集処理を記述
            let storyboard: UIStoryboard = self.storyboard!
            let communityEditView = storyboard.instantiateViewController(withIdentifier: "communityCreateVC") as! CommunityEditViewController
            communityEditView.editCommunity = communityArray[indexPath.row]

            self.navigationController?.pushViewController(communityEditView, animated: true)

            // 実行結果に関わらず記述
            completionHandler(true)
        }

        // 削除処理
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            self.viewModel.deleteCommunity(self.communityArray[indexPath.row])
            self.reloadView()
            // 実行結果に関わらず記述
            completionHandler(true)
        }
        
        editAction.backgroundColor = UIColor.systemBlue
        editAction.image   = UIImage(systemName: "pencil",     withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
        deleteAction.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle))
        
        // 定義したアクションをセット
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
