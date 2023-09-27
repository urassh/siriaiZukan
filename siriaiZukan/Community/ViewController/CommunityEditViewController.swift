//
//  CommunityEditViewController.swift
//  siriaiZukan
//
//  Created by 浦山秀斗 on 2023/09/20.
//
import UIKit

class CommunityEditViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var defaultLabel: UILabel!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var personTextField: UITextField!
    
    public var editCommunity: Community?
    private let picker    = UIImagePickerController()
    private let viewModel = CommunityViewModel()
    private var newCommunity: Community!
    private var capturedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newCommunity = Community()
        
        if editCommunity != nil {
            nameTextField.text = editCommunity!.name
            personTextField.text = String(editCommunity!.persons)
            defaultLabel.isHidden = true
            if let unwrapImage = viewModel.loadImage(community: editCommunity!) {
                iconImage.image = treatIconImage(unwrapImage)
            } else {
                iconImage.image = treatIconImage(UIImage(systemName: "person.fill")!)
            }
        }
        
        picker.delegate = self
    }
    
    @IBAction func iconButtonTapped() {
        showAlert()
    }
    
    @IBAction func registerTapped() {
        guard let unwrapName  = nameTextField.text else { return }
        guard let unwrapImage = iconImage.image    else { return }
        guard let unwrapPersons = personTextField.text else { return }
        guard let savedImage  = viewModel.saveImage(image: unwrapImage, id: newCommunity.id) else { return }
        
        newCommunity.name  = unwrapName
        newCommunity.image = savedImage
        newCommunity.persons = Int(unwrapPersons) ?? 0
        
        if editCommunity == nil {
            viewModel.appendCommunity(newCommunity)
        } else {
            viewModel.updateCommunity(before: editCommunity!, after: newCommunity)
        }
        
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
    
    private func treatIconImage(_ image: UIImage) -> UIImage{
        image
            .resizable(toSize: CGSize(width: 200, height: 200))
            .roundedCorners(radius: 10)
    }
}

extension CommunityEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let firstImage = info[.originalImage] as! UIImage
        capturedImage = treatIconImage(firstImage)
        iconImage.image = capturedImage
        newCommunity.image = viewModel.saveImage(image: firstImage, id: newCommunity.id)!
        defaultLabel.isHidden = true
        self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
