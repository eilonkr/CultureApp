//
//  ArticleCell.swift
//  CultureApp
//
//  Created by Eilon Krauthammer on 22/03/2021.
//

import UIKit

final class ArticleCell: UICollectionViewCell, Providable {
    typealias Item = Article
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var loveButton: UIButton!
    @IBOutlet weak var loveCountLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    public private(set) var article: Article! {
        didSet { configure() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorImageView.roundCorners(to: .rounded)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
        authorImageView?.image = nil
    }
    
    func provide(_ article: Article) {
        self.article = article
    }
    
    private func configure() {
        mainImageView.load(url: article.coverImageNSURL)
        authorImageView.load(url: article.authorAvatarNSURL ?? NSURL())
        categoryLabel.text = article.category
        titleLabel.text = article.title
        authorNameLabel.text = article.author.authorName
        createdAtLabel.text = article.creationDate
        loveCountLabel.text = String(article.likesCount)
        loveButton.setImage(UIImage(named: article.isLiked ? "liked" : "like"), for: .normal)
        saveButton.setImage(UIImage(named: article.isSaved ? "saved" : "save"), for: .normal)
    }
    
    private func configureDesign() {
        clipsToBounds = false
        roundCorners(to: .custom(8.0))
        mainImageView.roundCorners(to: .custom(8.0))
        mainImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        applyShadow(color: .black, radius: 10.0, opacity: 0.1, offsetY: 2.5, offsetX: 0.0)
    }
    
    // MARK: - Layout
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let newAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        newAttributes.frame.size.width = layoutAttributes.bounds.width
        newAttributes.frame.size.height = systemLayoutSizeFitting(CGSize(width: layoutAttributes.size.width, height: UIView.layoutFittingCompressedSize.height)).height
        return newAttributes
    }
}
