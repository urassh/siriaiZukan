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
    
    public  var community: Community? = nil
    public  var editMember: Member?
    private var member: Member = Member()
    private let picker = UIImagePickerController()
    private let viewModel = MemberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editMember == nil {
            iconImage.image = UIImage(systemName: "person.fill")
        } else {
            iconImage.image = viewModel.loadImage(member: editMember!)
        }
        nickNameTextField.text = editMember?.nickName ?? ""
        realNameTextField.text = editMember?.name ?? ""
        
        picker.delegate = self
        nickNameTextField.delegate = self
        realNameTextField.delegate = self
    }
    
    @IBAction func captureButtonTapped() {
        showAlert()
    }
    
    @IBAction func registerButton() {
        guard let unwrapNickName = nickNameTextField.text else { return }
        guard let unwrapRealName = realNameTextField.text else { return }
        guard let unwrapImage    = iconImage.image        else { return }
        guard let savedImage     = viewModel.saveImage(image: unwrapImage, id: member.id) else { return }
        
        member.nickName  = unwrapNickName
        member.name      = unwrapRealName
        member.image     = savedImage
        member.community = community
        
        if editMember == nil {
            viewModel.appendMember(member)
        } else {
            viewModel.updateMember(before: editMember!, after: member)
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
}

extension MemberEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        iconImage.image = firstImage
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 100)
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
