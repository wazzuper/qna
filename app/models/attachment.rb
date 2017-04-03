class Attachment < ApplicationRecord
  belongs_to :question, required: false

  mount_uploader :file, FileUploader
end