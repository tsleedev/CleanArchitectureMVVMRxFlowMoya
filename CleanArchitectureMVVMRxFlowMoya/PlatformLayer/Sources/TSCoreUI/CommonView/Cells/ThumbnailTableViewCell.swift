//
//  ThumbnailTableViewCell.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import UIKit
import SnapKit
import Then
import Kingfisher

public class ThumbnailTableViewCell: UITableViewCell {
    // MARK: - Views
    private let containerView = UIView()
    private let thumbnailImageView = UIImageView()
    private let stackView = UIStackView().then {
        $0.axis = .vertical
    }
    private let titleLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .title2)
    }
    private let subTitleLabel = UILabel().then {
        $0.font = UIFont.preferredFont(forTextStyle: .body)
        $0.numberOfLines = 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
    }
    
    public func configure(_ viewModel: ThumbnailItemViewModel) {
        if let urlString = viewModel.thumbnailUrl,
           let url = URL(string: urlString) {
            thumbnailImageView.kf.setImage(with: url,
                                           placeholder: UIImage(systemName: "person.crop.circle")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        }
        if let title = viewModel.title, !title.isEmpty {
            titleLabel.text = title
            titleLabel.isHidden = false
        } else {
            titleLabel.isHidden = true
        }
        if let description = viewModel.description, !description.isEmpty {
            subTitleLabel.text = description
            subTitleLabel.isHidden = false
        } else {
            subTitleLabel.isHidden = true
        }
    }
}

// MARK: - Setup
private extension ThumbnailTableViewCell {
    func setupViews() {
        accessoryType = .disclosureIndicator
        contentView.addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(60)
        }
        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            make.width.height.equalTo(44)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(thumbnailImageView.snp.trailing).offset(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-10)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
}
