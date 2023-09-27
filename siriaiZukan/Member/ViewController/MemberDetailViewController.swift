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
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var aboutTextView: UITextView!
    
    public  var community: Community!
    public  var memberId: String!
    
    private var member: Member!
    private var viewModel: MemberViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MemberViewModel()
        reloadView()
        
        aboutTextView.delegate = self
    }
    
    @IBAction func editButton() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let memberEditVC = storyboard.instantiateViewController(withIdentifier: "MemberEditViewController") as! MemberEditViewController

        memberEditVC.community = community
        memberEditVC.memberId  = member.id
        memberEditVC.modalPresentationStyle = .formSheet
        memberEditVC.presentationController?.delegate = self
        present(memberEditVC, animated: true)
    }

    @IBAction func deleteButton() {
        viewModel.deleteMember(member)
        
        if let presentationController = presentationController {
            presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
        }
        
        self.dismiss(animated: true)
    }
    
    private func reloadView() {
        print("community: \(community)")
        print("memberId : \(memberId)")
        member = viewModel.getMember(community, memberId)
        
        if let unwrapImage = viewModel.loadImage(member.id) {
            iconImage.image = treatIconImage(unwrapImage)
        } else {
            iconImage.image = treatIconImage(UIImage(systemName: "person.fill")!)
        }
        
        nickNameLabel.text = member.nickName
        aboutLabel.text    = "\(member.nickName)について"
        realNameLabel.text = member.name
        aboutTextView.text = member.about
        aboutTextView.isEditable = false
    }
    
    private func treatIconImage(_ image: UIImage) -> UIImage {
        iconImage.layer.borderWidth  = 5.0
        iconImage.layer.borderColor  = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6).cgColor
        iconImage.layer.cornerRadius = 100
        
        return image
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 100)
    }
}

extension MemberDetailViewController: UIAdaptivePresentationControllerDelegate, UITextViewDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        reloadView()
        print("call presentationControllerDidDismiss")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.translatesAutoresizingMaskIntoConstraints = true
        textView.sizeToFit()
        textView.isScrollEnabled = true
    }
}
