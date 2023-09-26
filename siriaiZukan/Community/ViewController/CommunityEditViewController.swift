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
    private var newCommunity: Community!
    private var capturedImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        newCommunity = Community()
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
        guard let savedImage  = viewModel.saveImage(image: unwrapImage, id: newCommunity.id) else { return }
        
        newCommunity.name  = unwrapName
        newCommunity.image = savedImage
        viewModel.appendCommunity(newCommunity)
        
        let storyboard: UIStoryboard = self.storyboard!
        let communityView = storyboard.instantiateViewController(withIdentifier: "communityVC") as! CommunityViewController

        self.navigationController?.pushViewController(communityView, animated: true)
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

extension CommunityEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        capturedImage = firstImage
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 10)
        iconImage.image = capturedImage
        newCommunity.image = viewModel.saveImage(image: firstImage, id: newCommunity.id)!
        defaultLabel.isHidden = true
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


