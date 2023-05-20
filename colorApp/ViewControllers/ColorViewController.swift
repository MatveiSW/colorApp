//
//  ViewController.swift
//  colorApp
//
//  Created by Матвей Авдеев on 19.05.2023.
//

import UIKit

protocol SetColorViewControllerDelegate: AnyObject {
    func getBackgroundColor(color: UIColor)
}

final class ColorViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let setColorVC = segue.destination as? SetColorViewController else { return }
        setColorVC.backroundColor = view.backgroundColor
        setColorVC.delegate = self
    }
    
}

extension ColorViewController: SetColorViewControllerDelegate {
    func getBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
    
}


