# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :projects
  has_many :skills
  # table consists of password_hash as a column to store password hashes in DB
  include BCrypt

  # retrieve password from hash
  def password
    @password ||= Password.new(password_hash)
  end

  # create the password hash
  def password=(pass)
    @password = Password.create(pass)
    self.password_hash = @password
  end

end