//
//  MainController.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import UIKit

class MainController: UIViewController {
    
    private let viewModel = MainViewModel()
    private let validator = Validation()
    private var heightCells: CGFloat {
        return view.frame.size.height / 15
    }
    @IBOutlet weak var editableAmountTextField: UITextField!
    @IBOutlet weak var finalAmountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightEditableAmountVIewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightFinalAmountViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editableAmountTextField.becomeFirstResponder()
        editableAmountTextField.addTarget(self, action: #selector(MainController.textFieldDidChange(_:)), for: .editingChanged)
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        conversion()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        heightEditableAmountVIewConstraint.constant = heightCells
        heightFinalAmountViewConstraint.constant = heightCells
    }
    
    private func bind() {
        viewModel.editableAmount.bind { [weak self] in
            guard let string = $0 else { return }
            self?.finalAmountLabel.text = string
        }
    }
    
    private func conversion() {
        viewModel.conversion(amount: editableAmountTextField.text ?? "0", from: "RU", to: ["EUR", "USD"]) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textField.text = validator.validateTextField(textField: textField)
        viewModel.editableAmount.value = textField.text
        conversion()
    }
}


// MARK: extensions
extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellMainTableView", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        cell.configure(viewModel: viewModel.getCellViewModel(indexPath: indexPath))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCells
    }
}

