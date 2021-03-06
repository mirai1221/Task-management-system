class Task < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_comma
  belongs_to :user

  enum status: { not_started: 0, undertake: 1, completion: 2 }
  # 検索に使用してよいカラムの制限
  def self.ransackable_attributes(_auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end

  # CSV内容
  # def self.csv_attributes
  #   ["name", "description", "created_at", "updated_at"]
  # end

  # def self.generate_csv
  #   CSV.generate(headers: true) do |csv|
  #     csv << csv_attributes
  #     all.each do |task|
  #       csv << csv_attributes.map{ |attr| task.send(attr) }
  #     end
  #   end
  # end

  # def self.import(file)
  #   CSV.foreach(file.path, headers: true) do |row|
  #     task = new
  #     task.attributes = row.to_hash.slice(*csv_attributes)
  #     task.save!
  #   end
  # end


  # scope :recent, -> { order(created_at: :desc)}


  private

  def validate_name_not_including_comma
    # nameにコンマが含まれているか調べる nameがnilの場合例外が発生するのを避けるため&を利用して、nameがnilの時は検証を通るようにする
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
end
