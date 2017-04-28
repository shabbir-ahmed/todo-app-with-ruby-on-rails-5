class Task < ApplicationRecord
  belongs_to :user

  scope :finish, -> {where('finished': true)}
  scope :notfinish, -> {where('finished': false)}
  scope :published, -> {where('published': true)}
  scope :unpublished, -> {where('published': false)}
end
