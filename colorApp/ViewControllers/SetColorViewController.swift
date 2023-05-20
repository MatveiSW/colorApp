//
//  SetColorViewController.swift
//  colorApp
//
//  Created by Матвей Авдеев on 19.05.2023.
//

import UIKit

final class SetColorViewController: UIViewController {
    
    @IBOutlet var settingColorView: UIView!
    
    @IBOutlet var redColorLabel: UILabel!
    @IBOutlet var greenColorLabel: UILabel!
    @IBOutlet var blueColorLabel: UILabel!
    
    @IBOutlet var redColorTF: UITextField!
    @IBOutlet var greenColorTF: UITextField!
    @IBOutlet var blueColorTF: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    var backroundColor: UIColor!
    unowned var delegate: SetColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redColorTF.delegate = self
        greenColorTF.delegate = self
        blueColorTF.delegate = self
        
        redSlider.value = Float(rgba.red)
        greenSlider.value = Float(rgba.green)
        blueSlider.value = Float(rgba.blue)
        
        settingColorView.backgroundColor = backroundColor
        
        settingKeyboard()
        settingFormatText()
        settingBackgroundView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    @objc func keyboardDoneTapped() {
        redColorTF.resignFirstResponder()
        greenColorTF.resignFirstResponder()
        blueColorTF.resignFirstResponder()
    }
    
    @IBAction func settingColorSliders(_ sender: UISlider) {
        let formattedSliderValue = String(format: "%.2f", sender.value)
        
        if sender.tag == 0 {
            redColorLabel.text = formattedSliderValue
            redColorTF.text = formattedSliderValue
        } else if sender.tag == 1 {
            greenColorLabel.text = formattedSliderValue
            greenColorTF.text = formattedSliderValue
        } else if sender.tag == 2 {
            blueColorLabel.text = formattedSliderValue
            blueColorTF.text = formattedSliderValue
        }
        settingColorView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
        
        
    }
    
    @IBAction func doneButtonPressed() {
        delegate.getBackgroundColor(color: settingColorView.backgroundColor ?? UIColor.white)
        dismiss(animated: true)
    }
    
    
}

private extension SetColorViewController {
    private func settingBackgroundView() {
        let backroundView = UIImageView(image: UIImage(named: "picture"))
        backroundView.frame = view.bounds
        backroundView.contentMode = .scaleAspectFill
        view.addSubview(backroundView)
        view.sendSubviewToBack(backroundView)
    }
    func settingFormatText() {
        redSlider.value = Float(rgba.red)
        greenSlider.value = Float(rgba.green)
        blueSlider.value = Float(rgba.blue)
        
        redColorTF.text = String(format: "%.2f", redSlider.value)
        greenColorTF.text = String(format: "%.2f", greenSlider.value)
        blueColorTF.text = String(format: "%.2f", blueSlider.value)
        
        redColorLabel.text = String(format: "%.2f", redSlider.value)
        greenColorLabel.text = String(format: "%.2f", greenSlider.value)
        blueColorLabel.text = String(format: "%.2f", blueSlider.value)
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        backroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
    func settingKeyboard() {
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(keyboardDoneTapped))
        
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton]
        
        redColorTF.inputAccessoryView = toolbar
        greenColorTF.inputAccessoryView = toolbar
        blueColorTF.inputAccessoryView = toolbar
    }
}

extension SetColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValueTF = textField.text else { return }
        guard let numberValueTF = Float(newValueTF) else { return }
        
        if textField == redColorTF {
            redSlider.value = numberValueTF
            redColorLabel.text = String(format: "%.2f", numberValueTF)
        } else if textField == greenColorTF {
            greenSlider.value = numberValueTF
            greenColorLabel.text = String(format: "%.2f", numberValueTF)
        } else if textField == blueColorTF {
            blueSlider.value = numberValueTF
            blueColorLabel.text = String(format: "%.2f", numberValueTF)
        }
        settingColorView.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}









