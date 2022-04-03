//
//  UpdateProfileVC.swift
//  WashSquad
//
//  Created by Motaweron on 31/03/2022.
//  Copyright © 2022 CreativeShare. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class UpdateProfileVC: UIViewController {
    
    @IBOutlet weak var ProfileView: UIImageView!{
        didSet{
            self.ProfileView.addActionn(vc: self, action: #selector(self.pickImage))
        }
    }
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var phoneTF: FPNTextField!
    @IBOutlet weak var paasswordTF: UITextField!
    @IBOutlet weak var saverBtn: UIButton!
    
    var phone = ""
    var phone_code = ""
    var error:Bool?

    private var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
//
//        ProfileView.layer.cornerRadius = ProfileView.frame.size.height / 2
//        ProfileView.clipsToBounds = true
//        ProfileView.layer.borderWidth = 1.0
//        ProfileView.layer.borderColor = UIColor(rgb: 0x450038).cgColor
        self.setupPhoneTF()
        self.displaayUserData()
        self.localizeUI()
        
    }
    

    @IBAction private func saaveBtn(_ sender: UIButton) {
        if error == false {
            self.updateProfileAPI()
        }
    }

    
    
    
}
//MARK: - UI
extension UpdateProfileVC {
    
    private func displaayUserData() {
        if let imgDataa = def.dictionary(forKey: "userData")!["logo"] as? Data {
            ProfileView.image = UIImage(data:(imgDataa))
        }
        fullname.text = def.dictionary(forKey: "userData")!["name"] as? String
        phone_code = def.string(forKey: "phone_code") ?? ""
        phone = def.dictionary(forKey: "userData")!["phone"] as? String ?? ""
        print("🚀 phone_code \(phone_code) , \(phone)")
        //self.phoneTF.text = phone
        self.phoneTF.set(phoneNumber: "\(phone_code.replacingOccurrences(of: "00", with: "+"))\(phone)")
    }
    
    private func localizeUI() {
        self.fullname.placeholder = Localized("User name")
        self.phoneTF.placeholder = Localized("Phone number")
        self.paasswordTF.placeholder = Localized("Password")
        self.saverBtn.setTitle(Localized("Save"), for: .normal)
    }
    
    
}
//MARK: - Networking
extension UpdateProfileVC {
    
    private func updateProfileAPI() {
        if let imageData = ProfileView.image!.jpegData(compressionQuality: 1.0) {
            if !api.isConnectedToInternet() {
                showErrorWithStatus(Localized("connMSG"))
                    return
            }else{
                api.updateProfile(targetURL: updateMyProfileUrl,phone_code: self.phone_code,phone: self.phone ,name: self.fullname.text ?? "", pass:self.paasswordTF.text ?? "", logo: ProfileView.image ?? UIImage()) { (error, result, code) in
                    if code == 200 {
                        self.saverBtn.isUserInteractionEnabled = true
                        def.set(["name":self.fullname.text!,"phone":self.phone,"logo":imageData], forKey: "userData")
                        def.set(self.phone_code , forKey: "phone_code")
                        showSuccessWithStatus(Localized("su"))
                        self.displaayUserData()
                    }else {
                        showErrorWithStatus(Localized("errll"))
                        self.saverBtn.isUserInteractionEnabled = true
                }}}}
    }
    
    
    
    
}
//MARK: - Phone Configs
extension UpdateProfileVC:FPNTextFieldDelegate {
    func setupPhoneTF(){
        
        phoneTF.delegate = self
        phoneTF.placeholder = ""
        phoneTF.leftView?.translatesAutoresizingMaskIntoConstraints = false
        phoneTF.leftView?.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        phoneTF.leftView?.heightAnchor.constraint(equalToConstant: 25.0).isActive = true
        phoneTF.setFlag(for: FPNCountryCode.SA)
        phoneTF.flagButton.isUserInteractionEnabled = true
        //phoneTF.flagButtonSize = CGSize(width: 35, height: 35)
        phoneTF.parentViewController = self
        
    }
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        phone_code =  dialCode.replacingOccurrences(of: "+", with: "00")
        def.set(phone_code, forKey: "Unum")
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            phone = textField.getRawPhoneNumber() ??  ""
            error = false
        } else {
            error = true
            
        }
    }
}
//MARK: - Image picker
extension UpdateProfileVC: ImagePickerDelegate {
    @objc private func pickImage() {
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.imagePicker.present(from: ProfileView)
    }
    
    func didSelect(image: UIImage?) {
        guard let image = image else {return}
        //self.userImage.contentMode = .scaleToFill
        self.ProfileView.image = image
        //self.photo = image
    }
}
