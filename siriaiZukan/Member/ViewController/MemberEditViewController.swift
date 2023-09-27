//
//  MemberEditViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/23.
//

import UIKit

class MemberEditViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var realNameTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var aboutTextView: UITextView!
    
    public  var community: Community!
    public  var memberId: String?
    
    private var member: Member!
    private var previousMember: Member?
    private let picker = UIImagePickerController()
    private let viewModel = MemberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousMember = viewModel.getMember(community, memberId)
        member = Member()
        
        print("member: ", member)
        
        if let editingMember = previousMember,
            let loadedImage = viewModel.loadImage(editingMember.id)
        {
            iconImage.image = treatIconImage(loadedImage)
        } else {
            iconImage.image = treatIconImage(UIImage(systemName: "person.fill")!)
        }
        
        nickNameTextField.text = previousMember?.nickName ?? ""
        realNameTextField.text = previousMember?.name ?? ""
        aboutLabel.text = previousMember != nil ? "\(previousMember!.nickName)について" : "この人物について"
        aboutTextView.text =  previousMember?.about ?? ""
        
        picker.delegate = self
        aboutTextView.delegate = self
    }
    
    @IBAction func captureButtonTapped() {
        showAlert()
    }
    
    @IBAction func registerButton() {
        guard let unwrapNickName = nickNameTextField.text else { return }
        guard let unwrapRealName = realNameTextField.text else { return }
        guard let unwrapImage    = iconImage.image        else { return }
        let unwrapAbout = aboutTextView.text ?? ""
        
        member.id        = previousMember?.id ?? ""
        member.nickName  = unwrapNickName
        member.name      = unwrapRealName
        member.image     = viewModel.saveImage(image: unwrapImage, id: member.id)!
        member.community = community
        member.about     = unwrapAbout
        
        if previousMember == nil {
            viewModel.appendMember(member)
        } else {
            viewModel.updateMember(before: previousMember!, after: member)
        }
        
        if let presentationController = presentationController {
            presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
        }
        
        self.dismiss(animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "どの方法で画像を取得しますか？", message: "", preferredStyle: .actionSheet)
        let cameraSheet = UIAlertAction(title: "Camera", style: .default) { [self] (action) in
            self.picker.sourceType = .camera
            present(picker, animated: true)
        }
        
        let librarySheet = UIAlertAction(title: "Library", style: .default) { [self] (action) in
            self.picker.sourceType = .photoLibrary
            present(picker, animated: true)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alert.addAction(cameraSheet)
        alert.addAction(librarySheet)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func treatIconImage(_ image: UIImage) -> UIImage {
        image
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 100)
    }
}

extension MemberEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        iconImage.image = treatIconImage(firstImage)
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
