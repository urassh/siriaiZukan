//
//  CommunityEditViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//

///next: ライブラリにアクセスして、アイコン画像を保存する処理を書く。

import UIKit

class CommunityEditViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var defaultLabel: UILabel!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    
    private let picker = UIImagePickerController()
    private let viewModel = CommunityViewModel()
    private var community: Community = Community()

    override func viewDidLoad() {
        super.viewDidLoad()
        community = Community()
        
        if iconImage.image != nil {
            captureButton.isHidden = true
        }
        
        picker.delegate = self
        nameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if iconImage.image != nil {
            captureButton.isHidden = true
        }
    }
    
    @IBAction func iconButtonTapped() {
        showAlert()
    }
    
    @IBAction func registerTapped() {
        guard let unwrapName  = nameTextField.text else { return }
        guard let unwrapImage = iconImage.image    else { return }
        
        guard let savedImage  = viewModel.saveImage(image: unwrapImage, community: community) else { return }
        
        community.name  = unwrapName
        community.image = savedImage
        
        viewModel.appendCommunity(community)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "どの方法で画像を取得しますか？", message: "", preferredStyle: .actionSheet)
        let cameraSheet = UIAlertAction(title: "Camera", style: .default) { [self] (action) in
            self.picker.sourceType = .camera
            present(picker, animated: true)
        }
        
        let librarySheet = UIAlertAction(title: "Library", style: .default) { [self] (action) in
            present(picker, animated: true)
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        alert.addAction(cameraSheet)
        alert.addAction(librarySheet)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

extension CommunityEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        iconImage.image = firstImage
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 10)
        defaultLabel.isHidden = true
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


