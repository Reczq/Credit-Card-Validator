import UIKit
import SnapKit

class CreditCardValidatorView: UIView {

    let creditCardTextfield: UITextField = {
        var textfield = UITextField()
        textfield.placeholder = TextFieldSizes.placeholder
        textfield.textAlignment = .center
        textfield.backgroundColor = #colorLiteral(red: 0.7044381164, green: 0.9621019267, blue: 1, alpha: 1)
        textfield.layer.cornerRadius = TextFieldSizes.cornerRadius

        textfield.layer.masksToBounds = TextFieldSizes.masksToBounds
        textfield.layer.shadowRadius = TextFieldSizes.shadowRadius
        textfield.layer.shadowColor = UIColor.black.cgColor
        textfield.layer.shadowOffset = TextFieldSizes.shadowOffset
        textfield.layer.shadowOpacity = TextFieldSizes.shadowOpacity

        return textfield
    }()

    let generateCodeButton: UIButton = {
        var button = UIButton()
        button.setTitle("Generate", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = ButtonsSizes.cornerRadius

        button.layer.shadowRadius = ButtonsSizes.shadowRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = ButtonsSizes.offsetRadius
        button.layer.shadowOpacity = ButtonsSizes.shadowOpacity

        return button
    }()

    let validateCodeButton: UIButton = {
        var button = UIButton()
        button.setTitle("Validate", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.layer.cornerRadius = ButtonsSizes.cornerRadius

        button.layer.shadowRadius = ButtonsSizes.shadowRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = ButtonsSizes.offsetRadius
        button.layer.shadowOpacity = ButtonsSizes.shadowOpacity

        button.isEnabled = false
        button.alpha = ButtonsSizes.alpha

        return button
    }()

    let succesValidationLabel: ResultLabel = {
        var label = ResultLabel()
        label.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = ResultLabelConstraintsValues.cornerRadius
        label.text = "Succes"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.alpha = ResultLabelConstraintsValues.alpha

        return label
    }()

    let failureValidationLabel: ResultLabel = {
        var label = ResultLabel()
        label.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        label.layer.masksToBounds = true
        label.text = "Failure"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.layer.cornerRadius = ResultLabelConstraintsValues.cornerRadius
        label.alpha = ResultLabelConstraintsValues.alpha

        return label
    }()

    func prepareView() {
        addSubviews()
        makeConstraints()
        backgroundColor = #colorLiteral(red: 0.1028626521, green: 0.1058146937, blue: 0.106177406, alpha: 1)
    }

    private func addSubviews() {
        addSubview(succesValidationLabel)
        addSubview(failureValidationLabel)
        addSubview(creditCardTextfield)
        addSubview(generateCodeButton)
        addSubview(validateCodeButton)

        setNeedsUpdateConstraints()
    }

    private func makeConstraints() {

        succesValidationLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(creditCardTextfield.snp.top).offset(ResultLabelConstraintsValues.bottom)
            make.centerX.equalTo(self)
            make.size.equalTo(ResultLabelConstraintsValues.size)
        }

        failureValidationLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(creditCardTextfield.snp.top).offset(ResultLabelConstraintsValues.bottom)
            make.centerX.equalTo(self)
            make.size.equalTo(ResultLabelConstraintsValues.size)
        }

        creditCardTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(TextfieldConstrainsValues.top)
            make.left.equalTo(self).offset(TextfieldConstrainsValues.left)
            make.right.equalTo(self).offset(TextfieldConstrainsValues.right)
            make.height.equalTo(TextfieldConstrainsValues.height)
        }

        generateCodeButton.snp.makeConstraints { (make) in
            make.top.equalTo(creditCardTextfield.snp.bottom).offset(GenerateButtonConstrainsValues.top)
            make.left.equalTo(self).offset(GenerateButtonConstrainsValues.left)
            make.right.equalTo(validateCodeButton.snp.left).offset(GenerateButtonConstrainsValues.right)
            make.width.equalTo(validateCodeButton.snp.width)
            make.height.equalTo(GenerateButtonConstrainsValues.height)
        }

        validateCodeButton.snp.makeConstraints { (make) in
            make.top.equalTo(creditCardTextfield.snp.bottom).offset(ValidateButtonConstrainsValues.top)
            make.right.equalTo(self).offset(ValidateButtonConstrainsValues.right)
            make.width.equalTo(generateCodeButton.snp.width)
            make.height.equalTo(ValidateButtonConstrainsValues.height)
        }
    }
}
