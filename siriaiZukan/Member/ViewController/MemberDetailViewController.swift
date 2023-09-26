//
//  MemberDetailViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/23.
//

import UIKit

class MemberDetailViewController: UIViewController {
    @IBOutlet var nickNameLabel: UILabel!
    @IBOutlet var realNameLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    public var member: Member!
    private var viewModel: MemberViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MemberViewModel()
        
        nickNameLabel.text = member.nickName
        realNameLabel.text = member.name
        iconImage.image    = viewModel.loadImage(member: member)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMemberEditView" {
            let memberEditVC = segue.destination as! MemberEditViewController
            memberEditVC.community = sender as? Community
            memberEditVC.editMember = member
        }
    }
    
    @IBAction func editButton() {
        self.performSegue(withIdentifier: "toMemberEditView", sender: member)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let memberEditVC = storyboard.instantiateViewController(withIdentifier: "MemberEditViewController") as! MemberEditViewController
        
        memberEditVC.community = member.community
        memberEditVC.editMember = member
        memberEditVC.modalPresentationStyle = .formSheet
        memberEditVC.presentationController?.delegate = self
        present(memberEditVC, animated: true)
    }

    @IBAction func deleteButton() {
        viewModel.deleteMember(member)
        self.dismiss(animated: true)
    }
    
    private func transEditView(member: Member) {
        
    }
    
    private func reloadView() {
        
    }
}

extension MemberDetailViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        reloadView()
        print("call presentationControllerDidDismiss")
    }
}
